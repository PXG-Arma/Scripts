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

// Calculate source path for duplication/migration if needed
private _sourcePath = "";
if (_action == "DuplicateFaction") then {
    private _sSide = lbText [456051, lbCurSel 456051];
    private _sFact = lbText [456052, lbCurSel 456052];
    private _sSub  = lbText [456053, lbCurSel 456053]; if (_sSub == "Base" || _sSub find "SELECT" != -1) then { _sSub = "" };
    private _sCamo = lbText [456054, lbCurSel 456054]; if (_sCamo find "SELECT" != -1) then { _sCamo = "" };
    private _sEra  = lbText [456055, lbCurSel 456055]; if (_sEra find "SELECT" != -1) then { _sEra = "" };
    
    _sourcePath = ["Scripts\Factions\", _sSide, "\", _sFact, "\", (if(_sSub != "")then{_sSub+"\"}else{""}), (if(_sEra != "")then{_sEra+"\"}else{""}), _sCamo, "\"] joinString "";
};

private _res = ["Sync", _sourcePath] call FBT_fnc_Pythia_Sync;

if !(_res isEqualType [] && {count _res > 0}) then {
    systemChat "[FBT Error] Backend Crash: Invalid response from Pythia. Check RPT.";
    diag_log format ["[FBT Error Details] Invalid Response: %1", _res];
} else {
    if (_res select 0) then {
        systemChat format ["%1", _res select 1];
        
        // --- UI REFRESH ---
        // We spawn this to allow for a tiny delay ensuring the Memory Bridge and Filesystem are ready
        [_side, _faction, _sub, _era, _camo] spawn {
            params ["_side", "_faction", "_sub", "_era", "_camo"];
            
            // 1. Manually update the registry cache to avoid re-reading the file (volatile update)
            private _registry = missionNamespace getVariable ["PXG_MasterRegistry_Cache", []];
            private _newEntry = [_side, _faction, _sub, _era, _camo];
            
            // Check if entry already exists to avoid duplicates in cache
            private _exists = false;
            { if (_x isEqualTo _newEntry) exitWith { _exists = true; }; } forEach _registry;
            if (!_exists) then { _registry pushBack _newEntry; };
            missionNamespace setVariable ["PXG_MasterRegistry_Cache", _registry];

            // 2. Set targets so the main UI dropdowns automatically select the new faction
            missionNamespace setVariable ["FBT_Target_Side",    _side];
            missionNamespace setVariable ["FBT_Target_Faction", _faction];
            missionNamespace setVariable ["FBT_Target_Sub",     _sub];
            missionNamespace setVariable ["FBT_Target_Camo",    _camo];
            missionNamespace setVariable ["FBT_Target_Era",     _era];

            // 3. Ensure events are not suppressed so the cascade can fire
            missionNamespace setVariable ["FBT_SuppressEvents", false];

            // Give Python/Memory a split second to settle
            uiSleep 0.1;
            
            // 4. Switch to Overview tab. TabSwitch already calls ["Init"] internally,
            // which will now use the targets we just set to snap the UI to the new faction.
            ["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
        };

        // Close metadata panel
        [false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
    } else {
        systemChat format ["[FBT Error] %1", _res select 1];
        diag_log format ["[FBT Error Details] %1", _res];
    };
};
