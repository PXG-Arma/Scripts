import os
import re
import stat
import time
import subprocess

def _force_write(mission_root, path, content):
    path = os.path.normpath(path)
    for i in range(10):
        try:
            os.makedirs(os.path.dirname(path), exist_ok=True)
            if os.path.exists(path):
                file_stat = os.stat(path)
                if not (file_stat.st_mode & stat.S_IWRITE): os.chmod(path, stat.S_IWRITE)
            with open(path, "w", encoding="utf-8", newline='\n') as f:
                f.write(content)
                f.flush()
                os.fsync(f.fileno())
            return True
        except:
            if i == 9: return False
            if os.path.exists(path): subprocess.run(['attrib', '-r', f'"{path}"'], shell=True, capture_output=True, check=False)
            time.sleep(0.5)
    return False

def _log(mission_root, message):
    try:
        log_path = os.path.join(mission_root, "fbt_governor.log")
        with open(log_path, "a", encoding="utf-8") as f:
            f.write(f"[{time.strftime('%H:%M:%S')}] {message}\n")
    except: pass

def _parse_sqf_array(text):
    if not text: return []
    text = re.sub(r",\s*([\]\)])", r"\1", text).replace("[", "(").replace("]", ")")
    text = text.replace("true", "True").replace("false", "False").replace("objNull", "None")
    try:
        raw = eval(f"({text})")
        def _to_list(obj):
            if isinstance(obj, (list, tuple)): return [_to_list(x) for x in obj]
            return obj
        return _to_list(raw)
    except: return []

def _scrape_legacy_sqf(mission_root, target_dir, var_name, file_name):
    possible_paths = [os.path.join(target_dir, file_name)]
    base_dir = os.path.dirname(target_dir)
    if os.path.exists(base_dir):
        for sibling in ["Desert", "MTP", "Woodland", "Winter", "Jungle", "Camo"]:
            sib_path = os.path.join(base_dir, sibling, file_name)
            if sib_path not in possible_paths: possible_paths.append(sib_path)
    file_path = next((p for p in possible_paths if os.path.exists(p)), None)
    if not file_path: return None
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = re.sub(r"//.*|/\*.*?\*/", "", f.read(), flags=re.DOTALL)
        match = re.search(rf"(?:_?){var_name}\s*=\s*\[(.*)\]", content, re.DOTALL | re.IGNORECASE)
        if not match: return None
        body = match.group(1).strip()
        if body.endswith(";"): body = body[:-1].strip()
        return _parse_sqf_array(body)
    except: return None

def _scrape_modular_metadata(weapons_content):
    """Scrapes SlotGroups, GunGroups, and SightGroups from a modular Weapons.sqf."""
    meta = {"slotgroups": {}, "gungroups": {}, "sightgroups": {}, "attachment_standards": {}}
    
    # 1. GUNGROUP Mapping
    gun_match = re.search(r'_mode\s*==\s*"GUNGROUP".*?switch\s*\(_loadout\)\s*do\s*\{(.*?)\}\s*;', weapons_content, re.DOTALL | re.IGNORECASE)
    if gun_match:
        for case_match in re.finditer(r'case\s+"([^"]+)":\s*\{\s*\[(.*?)\]\s*\}', gun_match.group(1), re.DOTALL):
            meta["gungroups"][case_match.group(1).lower()] = _parse_sqf_array(case_match.group(2))

    # 2. SLOTGROUP Mapping (Roles to Groups)
    slot_match = re.search(r'_mode\s*==\s*"SLOTGROUP".*?switch\s*\(_loadout\)\s*do\s*\{(.*?)\}\s*;', weapons_content, re.DOTALL | re.IGNORECASE)
    if slot_match:
        block = slot_match.group(1)
        for segment in re.split(r'\}', block):
            ids = re.findall(r'case\s+"([^"]+)"', segment)
            group_match = re.search(r'\{\s*"([^"]+)"\s*', segment)
            if ids and group_match:
                for rid in ids: meta["slotgroups"][rid.lower()] = group_match.group(1)

    # 3. SCOPES Mapping (SightGroups)
    scope_match = re.search(r'_mode\s*==\s*"SCOPES".*?switch\s*\(_roleGroup\)\s*do\s*\{(.*?)\}\s*;', weapons_content, re.DOTALL | re.IGNORECASE)
    if scope_match:
        block = scope_match.group(1)
        # This is a nested switch, very complex for regex. We'll look for the most common pattern.
        for role_seg in re.split(r'case\s+"[^"]+"\s*;', block):
            roles = re.findall(r'case\s+"([^"]+)"', role_seg)
            inner_switch = re.search(r'switch\s*\(_weaponGroup\)\s*do\s*\{(.*?)\}', role_seg, re.DOTALL)
            if inner_switch:
                for gun_case in re.finditer(r'case\s+"([^"]+)".*?\{\s*\[(.*?)\]\s*\}', inner_switch.group(1), re.DOTALL):
                    gun_name = gun_case.group(1).lower()
                    scopes = _parse_sqf_array(gun_case.group(2))
                    for r in roles:
                        key = f"{r.lower()}_{gun_name}"
                        meta["sightgroups"][key] = scopes

    # 4. ATTACHMENTS (Standards)
    attach_match = re.search(r'_mode\s*==\s*"ATTACHMENTS".*?switch\s*\(_weapon\)\s*do\s*\{(.*?)\}\s*;', weapons_content, re.DOTALL | re.IGNORECASE)
    if attach_match:
        for case_match in re.finditer(r'case\s+"([^"]+)":\s*\{\s*\[(.*?)\]\s*\}', attach_match.group(1), re.DOTALL):
            items = _parse_sqf_array(case_match.group(2))
            clean_items = [i for i in items if i and i != ""]
            if clean_items: meta["attachment_standards"][case_match.group(1).lower()] = clean_items

    return meta

def _scrape_universal_common(mission_root, era):
    common = {"items": [], "linkeditems": []}
    common_path = os.path.join(mission_root, "Scripts", "Factions", "common")
    if not os.path.exists(common_path): return {}
    LINKED = ["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "binocular", "Laserdesignator", "Rangefinder"]
    NVG = r"NVG|PVS|HMNVS"
    for f_name in ["gear.sqf", "medical.sqf", "radios.sqf"]:
        p = os.path.join(common_path, f_name)
        if not os.path.exists(p): continue
        try:
            with open(p, "r", encoding="utf-8") as f:
                c = re.sub(r"//.*|/\*.*?\*/", "", f.read(), flags=re.DOTALL)
                blocks = [re.sub(r'if\s*\(_variantEra\s*==\s*"[^"]+"\)\s*then\s*\{.*?\}\s*;', "", c, flags=re.DOTALL | re.IGNORECASE)]
                era_match = re.search(rf'if\s*\(_variantEra\s*==\s*"{era}"(?:\s*\|\|\s*_variantEra\s*==\s*"[^"]+")*\)\s*then\s*\{{(.*?)\}}\s*;', c, re.DOTALL | re.IGNORECASE)
                if era_match: blocks.append(era_match.group(1))
                for block in blocks:
                    clean = re.sub(r'case\s+"[^"]+"\s*(?:[:;]).*?(?=case|default|\})', "", block, flags=re.DOTALL | re.IGNORECASE)
                    for count, item in re.findall(r'for\s+"_i"\s+from\s+1\s+to\s+(\d+)\s+do\s+\{\s*player\s+(?:\w+)\s+"([^"]+)"\s*\};', clean, re.IGNORECASE):
                        for _ in range(int(count)): common["items"].append(item)
                    for m in re.findall(r'(?:addItemToUniform|addItemToVest|addItemToBackpack|linkItem|addWeapon)\s+"([^"]+)"', clean, re.IGNORECASE):
                        if any(l in m for l in LINKED) or re.search(NVG, m, re.IGNORECASE):
                            if m not in common["linkeditems"]: common["linkeditems"].append(m)
                        else:
                            if m not in common["items"]: common["items"].append(m)
        except: continue
    return common

def _scrape_legacy_armory(mission_root, target_dir):
    armory = {}
    id_data = _scrape_legacy_sqf(mission_root, target_dir, "availableLoadouts", "Loadoutlist.sqf")
    if not id_data or len(id_data) < 3: return {}, {}
    role_ids = [rid for sublist in id_data[2] for rid in sublist] if isinstance(id_data[2][0], list) else id_data[2]
    files = ["Uniforms.sqf", "Weapons.sqf", "Gear.sqf", "Ammo.sqf"]
    base_dir = os.path.dirname(target_dir)
    contents = []
    weapons_content = ""
    for f_name in files:
        p = os.path.join(target_dir, f_name)
        if not os.path.exists(p): p = os.path.join(base_dir, "Desert", f_name)
        if os.path.exists(p):
            with open(p, "r", encoding="utf-8") as f:
                c = re.sub(r"//.*|/\*.*?\*/", "", f.read(), flags=re.DOTALL)
                contents.append(c)
                if f_name == "Weapons.sqf": weapons_content = c

    modular_meta = _scrape_modular_metadata(weapons_content) if "_mode" in weapons_content else {}

    def _extract_gear(segment, gear_map):
        mappings = [
            (r'forceAddUniform\s+"([^"]+)"', "uniform"),
            (r'forceAddUniform\s+selectRandom\s+\["([^"]+)"', "uniform"),
            (r'addHeadgear\s+"([^"]+)"', "headgear"),
            (r'addHeadgear\s+selectRandom\s+\["([^"]+)"', "headgear"),
            (r'addVest\s+"([^"]+)"', "vest"),
            (r'addBackpack\s+"([^"]+)"', "backpack"),
            (r'addWeapon\s+"([^"]+)"', "primary"),
            (r'addPrimaryWeaponItem\s+"([^"]+)"', "optic"),
            (r'linkItem\s+"([^"]+)"', "nvg"),
            (r'for\s+"_i"\s+from\s+1\s+to\s+(\d+)\s+do\s+\{\s*player\s+(?:\w+)\s+"([^"]+)"\s*\};', "items_count"),
            (r'(?:addItemToUniform|addItemToVest|addItemToBackpack)\s+"([^"]+)"', "items")
        ]
        for pattern, key in mappings:
            if key == "items_count":
                for count, item in re.findall(pattern, segment, re.IGNORECASE):
                    if "items" not in gear_map: gear_map["items"] = []
                    for _ in range(int(count)): gear_map["items"].append(item)
            elif key == "items":
                for item in re.findall(pattern, segment, re.IGNORECASE):
                    if "items" not in gear_map: gear_map["items"] = []
                    gear_map["items"].append(item)
            else:
                match = re.search(pattern, segment, re.IGNORECASE)
                if match:
                    val = match.group(1)
                    if key == "primary": gear_map[key] = [val, []]
                    elif key == "optic":
                        if "primary" in gear_map: gear_map["primary"][1].append(val)
                    else: gear_map[key] = val

    default_gear = {}
    for c in contents:
        match = re.search(r'default\s*\{(.*?)\}', c, re.DOTALL | re.IGNORECASE)
        if match: _extract_gear(match.group(1), default_gear)
    if default_gear: armory["default"] = default_gear

    for rid in role_ids:
        role_gear = {}
        # Special check for modular weapons (Apply block)
        apply_match = re.search(r'_mode\s*==\s*"APPLY".*?switch\s*\(_loadout\)\s*do\s*\{(.*?)\}\s*;', weapons_content, re.DOTALL | re.IGNORECASE)
        segment_source = apply_match.group(1) if apply_match else weapons_content
        for c in contents if apply_match else contents: # Use all contents
            case_pattern = rf'case\s+"{rid}"\s*(?:[:;])'
            for match in re.finditer(case_pattern, c, re.IGNORECASE):
                start = match.end()
                next_match = re.search(r'case\s+"|};', c[start:], re.IGNORECASE)
                segment = c[start : start + next_match.start() if next_match else len(c)]
                _extract_gear(segment, role_gear)
        if role_gear: armory[rid] = role_gear
    return armory, modular_meta

def save_faction(mission_root, data_pairs, run_scan=False, source_path=None):
    try:
        mission_root = os.path.normpath(mission_root).replace("\\", "/")
        def _safe_dict(pairs):
            d = {}
            if not isinstance(pairs, (list, tuple)): return d
            for item in pairs:
                if isinstance(item, (list, tuple)) and len(item) == 2:
                    k, v = item
                    if isinstance(k, str): d[k.lower()] = v
            return d

        raw_data = _safe_dict(data_pairs)
        metadata = _safe_dict(raw_data.get("metadata", []))
        side, name, sub, era, camo = metadata.get("side", "BLUFOR").upper(), metadata.get("factionname", "New").replace("/", "-"), metadata.get("subfaction", "").replace("/", "-"), metadata.get("era", "Modern"), metadata.get("camo", "Default")
        parts = ["Scripts", "Factions", side, name]
        if sub and sub.lower() != "base": parts.append(sub)
        if era: parts.append(era)
        parts.append(camo)
        target_dir = os.path.normpath(os.path.join(mission_root, "/".join(parts))).replace("\\", "/")
        os.makedirs(target_dir, exist_ok=True)
        
        processed_data = {"metadata": raw_data.get("metadata", [])}
        
        scrape_dir = source_path if (source_path and os.path.exists(source_path)) else target_dir
        armory, scraped_meta = _scrape_legacy_armory(mission_root, scrape_dir)
        universal = _scrape_universal_common(mission_root, era)
        if universal:
            if "default" not in armory: armory["default"] = {}
            for k, v in universal.items():
                if k not in armory["default"]: armory["default"][k] = []
                armory["default"][k].extend(v)
        
        raw_armory = raw_data.get("armory", [])
        if isinstance(raw_armory, (list, tuple)):
            for rid, pairs in raw_armory:
                ui_role = _safe_dict(pairs)
                if not ui_role: continue
                if rid not in armory: armory[rid] = {}
                for k, v in ui_role.items():
                    if isinstance(v, (list, tuple)) and len(v) == 0 and k in armory[rid]: continue
                    armory[rid][k] = v
        processed_data["armory"] = armory

        for k in ["slotgroups", "gungroups", "attachment_standards", "sightgroups", "armorygroups", "armoryroles", "armoryids"]:
            val = raw_data.get(k, [])
            if k in scraped_meta and not val: # Fallback to scraped meta if UI is empty
                processed_data[k] = scraped_meta[k]
            elif isinstance(val, (list, tuple)) and k not in ["armorygroups", "armoryroles", "armoryids"]: 
                processed_data[k] = _safe_dict(val)
            else:
                processed_data[k] = val
        
        processed_data["motorpool"] = raw_data.get("motorpool", []) or _scrape_legacy_sqf(mission_root, scrape_dir, "availableVehicles", "Vehicles.sqf") or []
        processed_data["resupply"] = raw_data.get("resupply", []) or _scrape_legacy_sqf(mission_root, scrape_dir, "resupplyAvailable", "Supplies.sqf") or []

        _force_write(mission_root, os.path.join(target_dir, "Faction_Core.sqf"), _format_as_sqf(processed_data))
        if run_scan: update_registry(mission_root)
        return [True, "Faction Saved", raw_data.get("metadata", []), []]
    except Exception as e:
        return [False, f"Save Error: {str(e)}", []]

def update_registry(mission_root):
    try:
        mission_root = os.path.normpath(mission_root).lower()
        factions_dir = os.path.join(mission_root, "scripts", "factions")
        registry_path = os.path.join(factions_dir, "factions_registry.sqf")
        found = []
        for root, _, files in os.walk(factions_dir):
            if any(f.lower() in ["faction_core.sqf", "loadoutlist.sqf"] for f in files):
                rel = os.path.relpath(root, factions_dir).replace("\\", "/")
                parts = rel.split("/")
                if len(parts) < 2 or any(p.lower() == "common" for p in parts): continue
                side, name, rem = parts[0].upper(), parts[1], parts[2:]
                s, e, c = ("", "", "")
                if len(rem) >= 3: s, e, c = rem[0], rem[1], rem[2]
                elif len(rem) == 2: e, c = rem[0], rem[1]
                elif len(rem) == 1: c = rem[0]
                found.append([side, name, s, e, c])
        found.sort()
        header = f"/* PXG Registry - {time.strftime('%Y-%m-%d %H:%M:%S')} */\n\n[\n"
        rows = [f'    ["{e[0]}", "{e[1]}", "{e[2]}", "{e[3]}", "{e[4]}"]' + ("," if i < len(found)-1 else "") for i, e in enumerate(found)]
        _force_write(mission_root, registry_path, header + "\n".join(rows) + "\n]\n")
        return [True, "OK", found]
    except: return [False, "Error", []]

def _format_as_sqf(data):
    return "/* PXG Faction Core */\n\nprivate _factionData = " + _to_sqf_val(data) + ";\n\n_factionData\n"

HASHMAP_KEYS = ["armory", "slotgroups", "gungroups", "attachment_standards", "sightgroups", "metadata", "resupply", "motorpool"]

def _to_sqf_val(val, key_context=None):
    if isinstance(val, (list, tuple, dict)) and len(val) == 0:
        return "createHashMapFromArray [ ]" if key_context in HASHMAP_KEYS else "[]"
    if isinstance(val, dict):
        pairs = [f'["{k.lower()}", {_to_sqf_val(v, k.lower())}]' for k, v in val.items()]
        return f"createHashMapFromArray [\n    {', '.join(pairs)}\n]"
    elif isinstance(val, (list, tuple)):
        if key_context in HASHMAP_KEYS and len(val) > 0 and all(isinstance(x, (list, tuple)) and len(x) == 2 for x in val[:5]):
            pairs = [f'["{str(k).lower() if isinstance(k, str) else k}", {_to_sqf_val(v)}]' for k, v in val]
            return f"createHashMapFromArray [\n        {', '.join(pairs)}\n    ]"
        return "[" + ", ".join([_to_sqf_val(i) for i in val]) + "]"
    elif isinstance(val, str): return '"' + val.replace('"', '""') + '"'
    elif isinstance(val, bool): return "true" if val else "false"
    return str(val) if val is not None else '""'
