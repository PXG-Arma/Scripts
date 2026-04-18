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
};

if (_action == "DuplicateFaction") then {
    _masterHash set ["Metadata", _newMeta];
};

private _res = [] call FBT_fnc_Pythia_Sync;

if (_res select 0) then {
    systemChat format ["%1", _res select 1];
    
    // --- AUTO-SELECT LOGIC ---
    missionNamespace setVariable ["FBT_Target_Side", _side];
    missionNamespace setVariable ["FBT_Target_Faction", _faction];
    missionNamespace setVariable ["FBT_Target_Sub", _sub];
    missionNamespace setVariable ["FBT_Target_Era", _era];
    missionNamespace setVariable ["FBT_Target_Camo", _camo];

    // Refresh the Registry dropdowns and trigger cascade
    ["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";
} else {
    systemChat format ["[FBT Error] %1", _res select 1];
    diag_log format ["[FBT Error Details] %1", _res];
};

// Refresh the physical world models
[] spawn {
    // No sleep needed - Sync is now synchronous
    execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf";
    
    // Switch to Overview tab
    ["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
};

// Close panel
[false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
