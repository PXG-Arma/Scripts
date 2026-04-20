/*
    FBT_ConfirmAction.sqf
    -------------------------------
    Processes the confirmed changes from the Extended Panel.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _action = _display getVariable ["FBT_PendingAction", ""];
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];

// --- GATHER METADATA FROM EXTENDED IDCs ---
private _fnc_getVal = {
    params ["_idcCombo", "_idcEdit"];
    private _txt = lbText [_idcCombo, lbCurSel _idcCombo];
    // If it's "+ ADD NEW" or if the field was empty (newly created), use the edit box
    if (_txt == "+ ADD NEW" || _txt == "") then { ctrlText (_display displayCtrl _idcEdit) } else { _txt };
};

private _side = lbText [456151, lbCurSel 456151];
private _faction = [456152, 456172] call _fnc_getVal;
private _sub = [456153, 456173] call _fnc_getVal;
if (_sub == "Base") then { _sub = "" };
private _camo = [456154, 456174] call _fnc_getVal;
private _era = [456155, 456175] call _fnc_getVal;

if (_faction == "") exitWith { systemChat "Error: Faction name cannot be empty."; };

if (_action == "") exitWith { diag_log "[FBT Confirm] Error: No pending action found in display variables."; };

diag_log format ["[FBT Confirm] Processing %1 for %2 (%3)", _action, _faction, _camo];

private _newMeta = createHashMapFromArray [
    ["Side", _side],
    ["FactionName", _faction],
    ["Subfaction", _sub],
    ["Camo", _camo],
    ["Era", _era]
];

if (_action == "NewFaction") then {
    _masterHash set ["Metadata", _newMeta];
    _masterHash set ["Armory", createHashMap];
    _masterHash set ["ArmorySequence", []];
    _masterHash set ["SlotGroups", createHashMap];
    _masterHash set ["GunGroups", createHashMap];
    _masterHash set ["Attachment_Standards", createHashMap];
    _masterHash set ["SightGroups", createHashMap];
};

if (_action == "DuplicateFaction") then {
    _masterHash set ["Metadata", _newMeta];
};

private _res = ["Sync"] call FBT_fnc_Pythia_Sync;

if !(_res isEqualType [] && {count _res > 0}) then {
    systemChat "[FBT Error] Backend Crash: Invalid response from Pythia. Check RPT.";
    diag_log format ["[FBT Error Details] Invalid Response: %1", _res];
} else {
    if (_res select 0) then {
        systemChat format ["%1", _res select 1];
        
        // --- INTELLIGENT MEMORY BRIDGE ---
        // Get the current session cache
        private _cache = missionNamespace getVariable ["FBT_MasterRegistry_Cache", []];
        
        // If the cache is empty (first time in session), bootstrap it from the disk registry
        if (count _cache == 0) then {
            _cache = call compile preprocessFile "Scripts\Factions\Factions_Registry.sqf";
        };

        // Inject the new entries from Python (usually just 1 entry in Session Mode)
        private _newEntries = _res select 3;
        {
            private _entry = _x;
            // Check if entry already exists to prevent duplicates
            private _exists = _cache findIf { _x isEqualTo _entry } != -1;
            if (!_exists) then { _cache pushBack _entry; };
        } forEach _newEntries;

        // Alphabetical re-sort to keep dropdowns clean
        _cache sort true;

        // Commit back to memory
        missionNamespace setVariable ["FBT_MasterRegistry_Cache", _cache];

        // --- AUTO-SELECT LOGIC ---
        missionNamespace setVariable ["FBT_Target_Side", _side];
        missionNamespace setVariable ["FBT_Target_Faction", _faction];
        missionNamespace setVariable ["FBT_Target_Sub", _sub];
        missionNamespace setVariable ["FBT_Target_Era", _era];
        missionNamespace setVariable ["FBT_Target_Camo", _camo];

        // Small delay to ensure Windows file system settles (still helpful for other scripts)
        uiSleep 0.2;

        // Force a clear/refresh of the registry dropdowns
        ["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";
    } else {
        systemChat format ["[FBT Error] %1", _res select 1];
        diag_log format ["[FBT Error Details] %1", _res];
    };
};

// Refresh the physical world models
[] spawn {
    // Switch to Overview tab
    ["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
};

// Close panel
[false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
