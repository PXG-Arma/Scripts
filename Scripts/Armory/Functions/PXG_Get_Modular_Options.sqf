/*
    PXG_Get_Modular_Options.sqf
    ----------------------------
    Discovery Layer for the Modular Armory.
    Extracts allowed weapons and optics for a specific role or group.

    Arguments:
    0: STRING _basePath (Path to faction folder)
    1: STRING _loadout (Role ID or Group Name)
    2: STRING _mode ("SLOTGROUP", "WEAPASSIGN", "GUNGROUP", "SCOPES", "ATTACHMENTS")
    3: ARRAY _metadata (Full 5-part metadata: [Side, Faction, SubFaction, Era, Camo])
    4: STRING _weapon (Optional, for attachment/scope compatibility)
    5: STRING _weaponGroup (Optional)
    6: STRING _roleGroup (Optional)

    Returns:
    Data requested by the mode (String or Array)
*/

params [
    "_basePath", "_loadout", "_mode", ["_metadata", []], 
    ["_weapon", ""], ["_weaponGroup", ""], ["_roleGroup", ""]
];

// Ensure metadata is available for legacy conversion
_metadata params [["_side", ""], ["_faction", ""], ["_sub", ""], ["_era", ""], ["_camo", ""]];
private _variantString = str _metadata;

// --- 1. MODERN HASHMAP ARCHITECTURE ---
private _corePath = _basePath + "Faction_Core.sqf";
if (fileExists _corePath) exitWith {
    private _data = call compile preprocessFile _corePath;
    if (isNil "_data" || {typeName _data != "HASHMAP"}) exitWith { if (_mode in ["SLOTGROUP"]) then { "" } else { [] } };

    switch (_mode) do {
        case "SLOTGROUP": {
            // Find which group the role belongs to (e.g. "sqd_ld" -> "Lead Elements")
            // In Hashmap, we might use a specific 'SlotGroups' map or check role metadata
            private _slotGroups = _data getOrDefault ["SlotGroups", createHashMap];
            _slotGroups getOrDefault [_loadout, ""]
        };
        case "WEAPASSIGN": {
            // Get weapon groups allowed for this role or group
            private _armory = _data getOrDefault ["Armory", createHashMap];
            private _roleData = _armory getOrDefault [_loadout, createHashMap];
            _roleData getOrDefault ["primary_options", []]
        };
        case "GUNGROUP": {
            // Resolve a group name (e.g. "Assault Rifles") to classnames
            private _gunGroups = _data getOrDefault ["GunGroups", createHashMap];
            _gunGroups getOrDefault [_loadout, []]
        };
        case "SCOPES": {
            // Get allowed sights for the role group and weapon group
            // For Hashmaps, we check role-specific first, then fall back to SightGroups
            private _armory = _data getOrDefault ["Armory", createHashMap];
            private _roleData = _armory getOrDefault [_loadout, createHashMap]; // _loadout might be role ID or group
            private _sights = _roleData getOrDefault ["sight_options", []];
            
            if (count _sights == 0) then {
                private _sightGroups = _data getOrDefault ["SightGroups", createHashMap];
                _sights = _sightGroups getOrDefault [_roleGroup, []];
                if (count _sights == 0) then { _sights = _sightGroups getOrDefault ["Standard", []]; };
            };
            _sights
        };
        case "ATTACHMENTS": {
            private _attachmentStandards = _data getOrDefault ["Attachment_Standards", createHashMap];
            _attachmentStandards getOrDefault [_weapon, ["", "", ""]]
        };
        default { [] };
    };
};

// --- 2. LEGACY SCRIPT FALLBACK ---
private _weaponsPath = _basePath + "Weapons.sqf";
if (fileExists _weaponsPath) exitWith {
    // Standardized 8-parameter bridge to legacy Scripts
    private _fnc_scriptName = _weaponsPath;
    [_side, _faction, _variantString, _loadout, _mode, _weapon, _weaponGroup, _roleGroup] call compile preprocessFile _fnc_scriptName;
};

if (_mode in ["SLOTGROUP"]) then { "" } else { [] }
