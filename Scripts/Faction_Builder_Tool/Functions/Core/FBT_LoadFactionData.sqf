/*
    FBT_LoadFactionData.sqf
    -------------------------------
    Reads the Faction_Core.sqf for the current metadata and populates the Master Hash.
    Ensures 'Duplicate' and 'Edit' actions have actual gear data.
*/
params [["_factionPath", ""]];

if (_factionPath == "") exitWith { diag_log "[FBT Load] Error: No path provided."; };

private _coreFile = _factionPath + "Faction_Core.sqf";
if !(fileExists _coreFile) exitWith {
    diag_log format ["[FBT Load] Info: No Faction_Core.sqf found at %1. Initializing empty Armory.", _coreFile];
    private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
    _masterHash set ["Armory", createHashMap];
};

private _data = call compile preprocessFile _coreFile;

if (isNil "_data" || {typeName _data != "HASHMAP"}) exitWith {
    diag_log format ["[FBT Load] Error: Failed to parse %1 or invalid format.", _coreFile];
};

private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];

// Unpack all top-level keys from the Hashmap (Metadata, Armory, GunGroups, etc.)
// This ensures that modular metadata is correctly loaded into the session.
{
    _masterHash set [_x, _y];
} forEach _data;

diag_log format ["[FBT Load] Success: Loaded %1 data categories from %2", count _data, _coreFile];
true
