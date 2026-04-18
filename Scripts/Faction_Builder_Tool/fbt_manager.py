import os
import re
import stat
import time
import subprocess

def _force_write(path, content):
    """Writes content to a file, with retries and bitwise clearing of read-only flags."""
    path = os.path.normpath(path)
    for i in range(5):
        try:
            if os.path.exists(path):
                os.chmod(path, stat.S_IWRITE)
            with open(path, "w", encoding="utf-8") as f:
                f.write(content)
            return True
        except PermissionError:
            if i == 4: raise
            time.sleep(0.2)
    return False

def save_faction(mission_root, data_pairs):
    """
    Main entry point for synchronizing a faction to disk.
    """
    try:
        # Sanitize input: SQF now sends "/" but let's be 100% sure
        mission_root = mission_root.replace("\\", "/")
        mission_root = os.path.normpath(mission_root)
        
        # 1. Unpack data to dictionary
        data = {k: v for k, v in data_pairs}
        metadata_pairs = data.get("Metadata", [])
        metadata = {k: v for k, v in metadata_pairs}
        metadata_list = metadata_pairs
        
        # 2. Resolve Path Structure
        side = metadata.get("Side", "BLUFOR").upper()
        # Sanitize names but keep spaces for consistency with existing folders
        name = metadata.get("FactionName", "New Faction").strip().replace("/", "-")
        subfaction = metadata.get("Subfaction", "").strip().replace("/", "-")
        era = metadata.get("Era", "Modern").strip().replace("/", "-")
        camo = metadata.get("Camo", "Default").strip().replace("/", "-")
        
        parts = ["Scripts", "Factions", side, name]
        if subfaction and subfaction.lower() != "base": 
            parts.append(subfaction)
        if era: parts.append(era)
        parts.append(camo)
        
        rel_dir = "/".join(parts)
        target_dir = os.path.normpath(os.path.join(mission_root, rel_dir)).replace("\\", "/")
        
        # 3. Create missing directories
        if not os.path.exists(target_dir):
            os.makedirs(target_dir, exist_ok=True)
            
        # 4. Serialize Faction_Core.sqf
        core_file = os.path.join(target_dir, "Faction_Core.sqf").replace("\\", "/")
        sqf_content = _format_as_sqf(data)
        
        _force_write(core_file, sqf_content)
            
        # 5. Registry Update
        reg_res = update_registry(mission_root)
        
        if reg_res[0]:
            # Success: return count and path summary
            return [True, f"FBT: Faction Saved & Registry Updated ({reg_res[1]}).", metadata_list]
        else:
            # Failure: return specific error
            return [True, f"FBT: Faction Saved. Registry FAIL: {reg_res[1]}", metadata_list]
        
    except Exception as e:
        import traceback
        return [False, f"Governor Save Error: {str(e)}\nPath attempted: {target_dir if 'target_dir' in locals() else 'None'}\nRoot: {mission_root}\n{traceback.format_exc()}"]

def update_registry(mission_root):
    """
    Performs a full recursive scan of Scripts/Factions to rebuild Factions_Registry.sqf.
    """
    try:
        mission_root = mission_root.replace("\\", "/")
        factions_dir = os.path.normpath(os.path.join(mission_root, "Scripts", "Factions")).replace("\\", "/")
        registry_path = os.path.join(factions_dir, "Factions_Registry.sqf").replace("\\", "/")
        
        marker_files = ["Faction_Core.sqf", "Loadoutlist.sqf", "Weapons.sqf", "Uniforms.sqf"]
        
        found_entries = []
        processed_dirs = set()

        if not os.path.exists(factions_dir):
            return [False, f"Folder NOT FOUND: {factions_dir}"]

        # Recursive Scan with junction support
        for root, dirs, files in os.walk(factions_dir, followlinks=True):
            if any(f in files for f in marker_files):
                root_norm = os.path.normpath(root).replace("\\", "/")
                if root_norm in processed_dirs: continue
                processed_dirs.add(root_norm)
                
                try:
                    rel = os.path.relpath(root_norm, factions_dir).replace("\\", "/")
                    parts = rel.split("/")
                    
                    if len(parts) < 2: continue
                    if "common" in parts: continue
                    
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
                except:
                    continue

        if not found_entries:
            return [False, f"Scan finished. Found 0 factions in: {factions_dir}"]

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
        
        if _force_write(registry_path, content):
            return [True, f"{len(found_entries)} factions indexed"]
        else:
            return [False, f"Permission Denied writing to {registry_path}"]
        
    except Exception as e:
        return [False, f"Scanner logic error: {str(e)}"]

def mission_check():
    return [True, "BRIDGE SUCCESS: Mission-side logic executing!"]

def _format_as_sqf(data):
    """Converts the internal dictionary to a clean SQF HashMap format."""
    output = "/*\n    PXG Faction Core Configuration\n    Generated via Pythia Governor\n*/\n\n"
    output += "private _factionData = " + _to_sqf_val(data) + ";\n\n"
    output += "_factionData\n"
    return output

def _to_sqf_val(val):
    if isinstance(val, dict):
        pairs = []
        for k, v in val.items():
            pairs.append(f'["{k}", {_to_sqf_val(v)}]')
        inner = ',\n    '.join(pairs)
        return f"createHashMapFromArray [\n    {inner}\n]"
    elif isinstance(val, list):
        if len(val) > 0 and isinstance(val[0], list) and len(val[0]) == 2:
            pairs = [f'["{k}", {_to_sqf_val(v)}]' for k, v in val]
            inner = ',\n        '.join(pairs)
            return f"createHashMapFromArray [\n        {inner}\n    ]"
        items = [_to_sqf_val(i) for i in val]
        return "[" + ", ".join(items) + "]"
    elif isinstance(val, str):
        safe_str = val.replace('"', '""')
        return f'"{safe_str}"'
    elif isinstance(val, bool):
        return "true" if val else "false"
    elif val is None:
        return '""'
    else:
        return str(val)
