import sys
import os

# Add the Faction_Builder_Tool directory to sys.path so we can import fbt_manager
scripts_dir = r"c:\Users\pino4\OneDrive\Documentos\Arma 3 - Other Profiles\AquaFox\mpmissions\TEST\Tanoa_PXG_Template.Tanoa\Scripts"
fbt_dir = os.path.join(scripts_dir, "Faction_Builder_Tool")
sys.path.append(fbt_dir)

try:
    import fbt_manager
    mission_root = r"c:\Users\pino4\OneDrive\Documentos\Arma 3 - Other Profiles\AquaFox\mpmissions\TEST\Tanoa_PXG_Template.Tanoa"
    print(f"Running DYNAMIC DUO update_registry for: {mission_root}")
    result = fbt_manager.update_registry(mission_root)
    print(f"Result Elements: {len(result)}")
    print(f"Status: {result[0]}")
    print(f"Message: {result[1]}")
    print(f"Registry Length: {len(result[2])}")
    
    # Check if the Generated file exists
    gen_path = os.path.join(mission_root, "Scripts", "Factions", "FBT_Registry_Generated.sqf")
    if os.path.exists(gen_path):
        print(f"Success: Generated registry found at {gen_path}")
        with open(gen_path, "r", encoding="utf-8") as f:
            print("--- Generated Content Preview ---")
            print("".join(f.readlines()[:5]))
            print("---------------------------------")
    else:
        print("FAIL: Generated registry NOT found.")
        
except Exception as e:
    import traceback
    print(f"Error during validation run: {e}")
    print(traceback.format_exc())
