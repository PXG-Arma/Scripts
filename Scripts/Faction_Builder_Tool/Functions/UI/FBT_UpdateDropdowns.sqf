/*
    FBT_UpdateDropdowns.sqf
    -------------------------------
    Handles population and filtering of the cascading metadata dropdowns.
*/
params [["_mode", "Init"]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

// Retrieve Functions
private _fnc_UpdateDropdowns = missionNamespace getVariable ["FBT_Fnc_UpdateDropdowns", {}];
private _fnc_Prepare        = missionNamespace getVariable ["FBT_Fnc_PrepareFramework", {}];
private _fnc_LoadData       = missionNamespace getVariable ["FBT_Fnc_LoadFactionData", {}];

private _registry = missionNamespace getVariable ["PXG_MasterRegistry_Cache", []];
if (count _registry == 0) then {
    _registry = call compile preprocessFile "Scripts\Factions\Factions_Registry.sqf";
    missionNamespace setVariable ["PXG_MasterRegistry_Cache", _registry];
};

// IDCs
private _idcSide     = 456051;
private _idcFaction  = 456052;
private _idcSub      = 456053;
private _idcCamo     = 456054;
private _idcEra      = 456055;

// Prevent recursive chain reactions during initialization
private _isSuppressed = missionNamespace getVariable ["FBT_SuppressEvents", false];

// Cascade Concurrency: Only the 'Parent' thread (the one the user clicked) is allowed to finish
private _isCascadeThread = missionNamespace getVariable ["FBT_ActiveCascade", false];
if (!_isSuppressed && !_isCascadeThread) then { missionNamespace setVariable ["FBT_ActiveCascade", true]; };

private _fnc_addOptions = {
    params ["_ctrlIDC", "_list", ["_addOption", true], ["_target", ""]];
    private _ctrl = findDisplay 456000 displayCtrl _ctrlIDC;
    lbClear _ctrl;
    { _ctrl lbAdd _x; } forEach _list;
    if (_addOption) then {
        private _idx = _ctrl lbAdd "+ ADD NEW";
        _ctrl lbSetColor [_idx, [0.3, 0.8, 0.3, 1]]; // Green for Add
    };
    
    // Target Lookup
    private _selIdx = 0;
    if (_target != "") then {
        { if (_x == _target) exitWith { _selIdx = _forEachIndex; }; } forEach _list;
    };
    
    // ATOMIC UI UPDATE (Suppress Event Trigger)
    missionNamespace setVariable ["FBT_SuppressEvents", true];
    _ctrl lbSetCurSel _selIdx;
    missionNamespace setVariable ["FBT_SuppressEvents", false];
};

private _selSide = (lbText [_idcSide, lbCurSel _idcSide]);

switch (_mode) do {
    case "Init": {
        // Populate Sides
        private _targetSide = missionNamespace getVariable ["FBT_Target_Side", ""];
        [_idcSide, ["BLUFOR", "OPFOR", "INDEP"], false, _targetSide] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Side", lbText [_idcSide, lbCurSel _idcSide]];
        if (!_isSuppressed) then { ["Side"] call _fnc_UpdateDropdowns; };
    };

    case "Side": {
        if (_isSuppressed && _mode != "Init") exitWith {}; // Only allow during full cascade
        private _factions = [];
        { if ((_x select 0) == _selSide && !((_x select 1) in _factions)) then { _factions pushBack (_x select 1); }; } forEach _registry;
        private _targetFaction = missionNamespace getVariable ["FBT_Target_Faction", ""];
        [_idcFaction, _factions, true, _targetFaction] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Faction", lbText [_idcFaction, lbCurSel _idcFaction]];
        ["Faction"] call _fnc_UpdateDropdowns;
    };

    case "Faction": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _subs = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && !((_x select 2) in _subs)) then { _subs pushBack (_x select 2); }; } forEach _registry;
        // Handle "Base" displays as empty string in registry often
        private _targetSub = missionNamespace getVariable ["FBT_Target_Sub", ""];
        private _displayTarget = if(_targetSub == "") then {"Base"} else {_targetSub};
        private _displaySubs = _subs apply { if (_x == "") then { "Base" } else { _x } };
        [_idcSub, _displaySubs, true, _displayTarget] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Sub", _subs select (lbCurSel _idcSub)];
        ["Subfaction"] call _fnc_UpdateDropdowns;
    };

    case "Subfaction": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _selSub = lbText [_idcSub, lbCurSel _idcSub];
        if (_selSub == "Base") then { _selSub = ""; };
        
        private _camos = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && (_x select 2) == _selSub && !((_x select 4) in _camos)) then { _camos pushBack (_x select 4); }; } forEach _registry;
        private _targetCamo = missionNamespace getVariable ["FBT_Target_Camo", ""];
        [_idcCamo, _camos, true, _targetCamo] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Camo", lbText [_idcCamo, lbCurSel _idcCamo]];
        ["Camo"] call _fnc_UpdateDropdowns;
    };

    case "Camo": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _selSub = lbText [_idcSub, lbCurSel _idcSub];
        if (_selSub == "Base") then { _selSub = ""; };
        private _selCamo = lbText [_idcCamo, lbCurSel _idcCamo];

        private _eras = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && (_x select 2) == _selSub && (_x select 4) == _selCamo && !((_x select 3) in _eras)) then { _eras pushBack (_x select 3); }; } forEach _registry;
        private _targetEra = missionNamespace getVariable ["FBT_Target_Era", ""];
        [_idcEra, _eras, true, _targetEra] call _fnc_addOptions;
        
        ["Era"] call _fnc_UpdateDropdowns;
        
        // Clear targets after full cascade trigger
        missionNamespace setVariable ["FBT_Target_Side", nil];
        missionNamespace setVariable ["FBT_Target_Faction", nil];
        missionNamespace setVariable ["FBT_Target_Sub", nil];
        missionNamespace setVariable ["FBT_Target_Camo", nil];
        missionNamespace setVariable ["FBT_Target_Era", nil];
    };

    case "Era": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _selSub = lbText [_idcSub, lbCurSel _idcSub];
        if (_selSub == "Base") then { _selSub = ""; };
        private _selCamo = lbText [_idcCamo, lbCurSel _idcCamo];
        private _selEra = lbText [_idcEra, lbCurSel _idcEra];

        private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
        private _meta = _masterHash getOrDefault ["Metadata", createHashMap];
        _meta set ["SIDE", _selSide];
        _meta set ["FACTIONNAME", _selFaction];
        _meta set ["SUBFACTION", _selSub];
        _meta set ["CAMO", _selCamo];
        _meta set ["ERA", _selEra];
        _masterHash set ["Metadata", _meta];

        private _factionPath = ["Scripts\Factions\", _selSide, "\", _selFaction, "\", (if(_selSub != "")then{_selSub+"\"}else{""}), (if(_selEra != "")then{_selEra+"\"}else{""}), _selCamo, "\"] joinString "";
        
        // --- DATA LOADING STRATEGY ---
        // 1. Priority: Faction_Core.sqf (Modern Structure)
        private _corePath = _factionPath + "Faction_Core.sqf";
        if (fileExists _corePath) then {
            [_factionPath] call _fnc_LoadData; // This populates MasterHash from Core
        } else {
            // 2. Fallback: Legacy Files
            private _armorySeq = [];
            private _loadoutPath = _factionPath + "Loadoutlist.sqf";
            if (fileExists _loadoutPath) then {
                private _loadouts = call compile preprocessFile _loadoutPath;
                private _groupNames = _loadouts select 0;
                private _roleNames  = _loadouts select 1;
                private _scriptNames = _loadouts select 2;
                {
                    private _gIdx = _forEachIndex;
                    private _gName = _x;
                    { _armorySeq pushBack [_x, (_roleNames select _gIdx) select _forEachIndex, _gName]; } forEach (_scriptNames select _gIdx);
                } forEach _groupNames;
            };
            _masterHash set ["ArmorySequence", _armorySeq];

            // Load Motorpool Sequence
            private _motorSeq = [];
            private _vehPath = _factionPath + "Vehicles.sqf";
            if (fileExists _vehPath) then {
                private _vehs = call compile preprocessFile _vehPath;
                {
                    private _catName = _x select 0;
                    private _vList = _x select 1;
                    { _motorSeq pushBack [_x select 0, _catName, _x select 1]; } forEach _vList;
                } forEach _vehs;
            };
            _masterHash set ["MotorpoolSequence", _motorSeq];

            // Prepare Framework Proxy (Scraper)
            [_factionPath] call _fnc_Prepare;
            
            // Load physical gear data
            [_factionPath] call _fnc_LoadData;
        };

        // 3. Process Sequence into Spawner Arrays
        // SAFETY: Only rebuild if the session data is missing OR if we just loaded from disk
        private _existingGroups = _masterHash getOrDefault ["ArmoryGroups", []];
        if (count _existingGroups == 0 || (fileExists _corePath)) then {
            private _groupsList = [];
            private _rolesList  = [];
            private _idList     = [];
            
            private _armorySeq = _masterHash getOrDefault ["ArmorySequence", []];
            {
                _x params ["_roleID", "_roleName", "_groupName"];
                private _gIdx = _groupsList find _groupName;
                if (_gIdx == -1) then {
                    _groupsList pushBack _groupName;
                    _rolesList pushBack [_roleName];
                    _idList pushBack [_roleID];
                } else {
                    (_rolesList select _gIdx) pushBack _roleName;
                    (_idList select _gIdx) pushBack _roleID;
                };
            } forEach _armorySeq;

            _masterHash set ["ArmoryGroups", _groupsList];
            _masterHash set ["ArmoryRoles", _rolesList];
            _masterHash set ["ArmoryIDs", _idList];
        };

        // Final Debounced Spawn
        if (!_isSuppressed) then {
            private _lastTrigger = missionNamespace getVariable ["FBT_LastSpawnTrigger", 0];
            if (diag_tickTime - _lastTrigger < 0.05) exitWith {}; // 50ms Debounce
            missionNamespace setVariable ["FBT_LastSpawnTrigger", diag_tickTime];

            [] spawn (missionNamespace getVariable ["FBT_Fnc_SpawnParade", {}]);
        };

        // Reset Cascade Lock
        missionNamespace setVariable ["FBT_ActiveCascade", false];
    };
};
