import os
import re
import stat
import time
import subprocess

def _force_write(mission_root, path, content):
    """Writes content directly to a file handle (Truncate & Write) for maximum OneDrive/Lock friendliness."""
    path = os.path.normpath(path)
    
    for i in range(10):  # Robust retry loop
        try:
            # 1. Ensure directory exists
            os.makedirs(os.path.dirname(path), exist_ok=True)
            
            # 2. Force-strip the Read-Only flag using Windows 'attrib' (more aggressive than os.chmod)
            if os.path.exists(path):
                subprocess.run(['attrib', '-r', path], capture_output=True, check=False)
            
            # 3. Direct content overwrite (Truncate + Write)
            with open(path, "w", encoding="utf-8") as f:
                f.write(content)
            
            return True
        except (PermissionError, OSError) as e:
            if i == 9: 
                _log(mission_root, f"FATAL WRITE ERROR after 10 tries: {str(e)}")
                return False
            _log(mission_root, f"Retrying direct write due to lock ({i+1}/10): {str(e)}")
            time.sleep(0.3)
    return False

def _log(mission_root, message):
    """Simple logger to track in-game behavior."""
    try:
        log_path = os.path.join(mission_root, "fbt_governor.log")
        with open(log_path, "a", encoding="utf-8") as f:
            f.write(f"[{time.strftime('%H:%M:%S')}] {message}\n")
    except:
        pass

def save_faction(mission_root, data_pairs, run_scan=False):
    """
    Main entry point for synchronizing a faction to disk.
    If run_scan is False (Session Mode), it skips the slow mission scan.
    """
    try:
        mission_root = os.path.normpath(mission_root).replace("\\", "/")
        
        # 1. Unpack data (Normalize keys for Framework compatibility)
        raw_data = {k: v for k, v in data_pairs}
        metadata_pairs = raw_data.get("Metadata", [])
        metadata = {k.lower(): v for k, v in metadata_pairs}
        
        # 2. Resolve Path Structure
        side = metadata.get("side", "BLUFOR").upper()
        name = metadata.get("factionname", "New Faction").strip().replace("/", "-")
        subfaction = metadata.get("subfaction", "").strip().replace("/", "-")
        era = metadata.get("era", "Modern").strip().replace("/", "-")
        camo = metadata.get("camo", "Default").strip().replace("/", "-")
        
        parts = ["Scripts", "Factions", side, name]
        if subfaction and subfaction.lower() != "base": parts.append(subfaction)
        if era: parts.append(era)
        parts.append(camo)
        
        rel_dir = "/".join(parts)
        target_dir = os.path.normpath(os.path.join(mission_root, rel_dir)).replace("\\", "/")
        
        # 3. Create missing directories
        if not os.path.exists(target_dir):
            os.makedirs(target_dir, exist_ok=True)
            
        # 4. Process Data (Reconstruct for Framework)
        processed_data = {"Metadata": metadata_pairs}
        
        # Armory Processing (Preserve SQF casing for Framework compatibility)
        raw_armory = raw_data.get("Armory", [])
        if isinstance(raw_armory, list):
            armory_dict = {}
            for role_id, role_gear_pairs in raw_armory:
                role_gear = {k: v for k, v in role_gear_pairs}
                armory_dict[role_id] = role_gear
            processed_data["Armory"] = armory_dict
            
        # Explicit Modular Metadata Handling
        modular_keys = ["SlotGroups", "GunGroups", "Attachment_Standards", "SightGroups"]
        for key in modular_keys:
            val = raw_data.get(key, {})
            # Ensure it's a dict for Hashmap serialization
            if isinstance(val, list): val = {k: v for k, v in val}
            processed_data[key] = val
            
        # Motorpool Recat (Framework compatible)
        motor_seq = raw_data.get("MotorpoolSequence", [])
        if motor_seq:
            cat_map = {}
            for entry in motor_seq:
                v_class, v_cat = entry[0], entry[1]
                v_cargo = entry[2] if len(entry) > 2 else 4
                if v_cat not in cat_map: cat_map[v_cat] = []
                cat_map[v_cat].append([v_class, v_cargo])
            # Motorpool MUST remain a list of lists for legacy foreach compatibility
            processed_data["Motorpool"] = [[cat, vlist] for cat, vlist in cat_map.items()]
        else:
            processed_data["Motorpool"] = []

        # 5. Serialize Faction_Core.sqf
        core_file = os.path.join(target_dir, "Faction_Core.sqf").replace("\\", "/")
        _force_write(mission_root, core_file, _format_as_sqf(processed_data))
        _log(mission_root, f"Saved: {rel_dir}")
            
        # 6. Session Mode: Return the individual entry for the Memory Bridge
        if not run_scan:
            new_entry = [side, name, subfaction if subfaction.lower() != "base" else "", era, camo]
            return [True, "Faction Saved (Session Mode)", metadata_pairs, [new_entry]]

        # 7. Full Rebuild Mode
        reg_res = update_registry(mission_root)
        return [True, f"Faction Saved & Indexed ({reg_res[1]})", metadata_pairs, reg_res[2]] if reg_res[0] else [True, f"Saved (Registry Locked: {reg_res[1]})", metadata_pairs, []]
        
    except Exception as e:
        import traceback
        _log(mission_root, f"SAVE ERROR: {str(e)}\n{traceback.format_exc()}")
        return [False, f"Save Error: {str(e)}", []]

def update_registry(mission_root):
    """
    Performs a full recursive scan of Scripts/Factions to rebuild Factions_Registry.sqf.
    """
    try:
        # 1. Hard-standardize everything to lowercase for Windows path matching
        mission_root = os.path.abspath(mission_root).replace("\\", "/").lower()
        if not mission_root.endswith("/"): mission_root += "/"
        
        factions_dir = os.path.join(mission_root, "scripts/factions").replace("\\", "/")
        registry_path = os.path.join(factions_dir, "factions_registry.sqf").replace("\\", "/")
        
        _log(mission_root, f"Starting Registry Scan in: {factions_dir}")
        
        # Case-insensitive markers
        marker_files = ["faction_core.sqf", "loadoutlist.sqf", "weapons.sqf", "uniforms.sqf"]
        
        found_entries = []
        processed_dirs = set()

        if not os.path.exists(factions_dir):
            _log(mission_root, f"FATAL: Factions dir missing at {factions_dir}")
            return [False, f"Folder NOT FOUND: {factions_dir}"]

        # Recursive Scan with junction support
        for root, dirs, files in os.walk(factions_dir, followlinks=True):
            # Case-insensitive file check
            files_lower = [f.lower() for f in files]
            if any(m in files_lower for m in marker_files):
                # Standardize for duplicate detection
                root_norm = os.path.abspath(root).replace("\\", "/").lower()
                if root_norm in processed_dirs: continue
                processed_dirs.add(root_norm)
                
                try:
                    rel = os.path.relpath(root, factions_dir).replace("\\", "/")
                    if rel == ".": continue
                    
                    parts = rel.split("/")
                    if len(parts) < 2: continue
                    if any(p.lower() == "common" for p in parts): continue 
                    
                    side = parts[0].upper()
                    name = parts[1]
                    sub, era, camo = "", "", ""
                    
                    rem = parts[2:]
                    depth = len(rem)
                    
                    if depth >= 3:
                        sub, era, camo = rem[0], rem[1], rem[2]
                    elif depth == 2:
                        era, camo = rem[0], rem[1]
                    elif depth == 1:
                        camo = rem[0]
                    
                    found_entries.append([side, name, sub, era, camo])
                except Exception as e:
                    _log(mission_root, f"Error processing {root}: {str(e)}")
                    continue

        if not found_entries:
            _log(mission_root, "Scan finished: 0 factions found.")
            return [False, f"Scan finished. Found 0 factions in: {factions_dir}"]

        _log(mission_root, f"Scan SUCCESS: {len(found_entries)} factions found.")
        found_entries.sort(key=lambda x: (x[0], x[1], x[2], x[3], x[4]))

        header = f"/*\n    PXG Faction Master Registry\n    ----------------------------\n    AUTO-GENERATED BY FBT GOVERNOR\n    Last Update: {time.strftime('%Y-%m-%d %H:%M:%S')}\n*/\n\n[\n"
        
        rows = []
        current_side = ""
        for i, e in enumerate(found_entries):
            if e[0] != current_side:
                current_side = e[0]
                rows.append(f"    //                        --{current_side}--")
            
            comma = "," if i < len(found_entries) - 1 else ""
            line = f'    ["{e[0]}", "{e[1]}", "{e[2]}", "{e[3]}", "{e[4]}"]{comma}'
            rows.append(line)
            
        content = header + "\n".join(rows) + "\n]\n"
        
        # DYNAMIC DUO
        registry_path = os.path.join(factions_dir, "FBT_Registry_Generated.sqf").replace("\\", "/")
        
        if _force_write(mission_root, registry_path, content):
            return [True, f"{len(found_entries)} factions indexed", found_entries]
        else:
            _log(mission_root, f"FAILED TO WRITE: {registry_path}")
            return [False, f"Permission Denied writing to {registry_path}", []]
        
    except Exception as e:
        import traceback
        _log(mission_root, f"LOGIC ERROR: {str(e)}\n{traceback.format_exc()}")
        return [False, f"Scanner logic error: {str(e)}"]

def mission_check():
    return [True, "BRIDGE SUCCESS: Mission-side logic executing!"]

def _format_as_sqf(data):
    """Converts the internal dictionary to a clean SQF HashMap format."""
    output = "/*\n    PXG Faction Core Configuration\n    Generated via Pythia Governor\n*/\n\n"
    output += "private _factionData = " + _to_sqf_val(data) + ";\n\n"
    output += "_factionData\n"
    return output

# Whitelist of keys that MUST be serialized as Hashmaps (createHashMapFromArray)
# This prevents accidental conversion of legacy array structures (like Motorpool) into hashmaps.
HASHMAP_KEYS = ["Armory", "SlotGroups", "GunGroups", "Attachment_Standards", "SightGroups", "Metadata"]

def _to_sqf_val(val, key_context=None):
    if isinstance(val, dict):
        pairs = [f'["{k}", {_to_sqf_val(v, k)}]' for k, v in val.items()]
        inner = ',\n    '.join(pairs)
        return f"createHashMapFromArray [\n    {inner}\n]"
    elif isinstance(val, list):
        # Only convert to Hashmap if it's in our whitelist AND looks like a list of pairs
        if key_context in HASHMAP_KEYS and len(val) > 0 and all(isinstance(x, list) and len(x) == 2 for x in val[:5]):
             if len(val) > 1 or (len(val) == 1 and isinstance(val[0][0], str)):
                pairs = [f'["{k}", {_to_sqf_val(v)}]' for k, v in val]
                inner = ',\n        '.join(pairs)
                return f"createHashMapFromArray [\n        {inner}\n    ]"
        
        items = [_to_sqf_val(i) for i in val]
        return "[" + ", ".join(items) + "]"
    elif isinstance(val, str):
        return '"' + val.replace('"', '""') + '"'
    elif isinstance(val, bool):
        return "true" if val else "false"
    elif val is None:
        return '""'
    return str(val)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("root", help="Mission Root Path")
    args = parser.parse_args()
    
    # CLI Call for UpdateRegistry.bat
    print(f"--- FBT GOVERNOR CLI ---")
    print(f"Scanning: {args.root}")
    res = update_registry(args.root)
    print(f"Status: {'SUCCESS' if res[0] else 'FAILED'}")
    print(f"Message: {res[1]}")
