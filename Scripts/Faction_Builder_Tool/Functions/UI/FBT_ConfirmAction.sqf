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
        
        // --- UI REFRESH ---
        // We spawn this to allow for a tiny delay ensuring the Memory Bridge and Filesystem are ready
        [] spawn {
            // Give Python/Memory a split second to settle
            uiSleep 0.1;
            
            // Force a clear/refresh of the registry dropdowns using the updated cache
            ["Init"] call (missionNamespace getVariable ["FBT_Fnc_UpdateDropdowns", {}]);
            
            // Switch to Overview tab to reveal the new/duplicated parade
            ["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
        };

        // Close metadata panel
        [false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
    } else {
        systemChat format ["[FBT Error] %1", _res select 1];
        diag_log format ["[FBT Error Details] %1", _res];
    };
};
