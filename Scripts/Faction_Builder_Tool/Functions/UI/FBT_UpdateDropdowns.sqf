/*
    FBT_UpdateDropdowns.sqf
    -------------------------------
    Handles population and filtering of the cascading metadata dropdowns.
*/
params [["_mode", "Init"]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _registry = call compile preprocessFile "Scripts\Factions\Factions_Registry.sqf";

// IDCs
private _idcSide     = 456051;
private _idcFaction  = 456052;
private _idcSub      = 456053;
private _idcCamo     = 456054;
private _idcEra      = 456055;

// Prevent recursive chain reactions during initialization
private _isSuppressed = missionNamespace getVariable ["FBT_SuppressEvents", false];

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
    _ctrl lbSetCurSel _selIdx;
};

private _selSide = (lbText [_idcSide, lbCurSel _idcSide]);

switch (_mode) do {
    case "Init": {
        // Populate Sides
        private _targetSide = missionNamespace getVariable ["FBT_Target_Side", ""];
        [_idcSide, ["BLUFOR", "OPFOR", "INDEP"], false, _targetSide] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Side", lbText [_idcSide, lbCurSel _idcSide]];
        if (!_isSuppressed) then { 
            ["Side"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf");
        };
    };

    case "Side": {
        if (_isSuppressed && _mode != "Init") exitWith {}; // Only allow during full cascade
        private _factions = [];
        { if ((_x select 0) == _selSide && !((_x select 1) in _factions)) then { _factions pushBack (_x select 1); }; } forEach _registry;
        private _targetFaction = missionNamespace getVariable ["FBT_Target_Faction", ""];
        [_idcFaction, _factions, true, _targetFaction] call _fnc_addOptions;
        missionNamespace setVariable ["FBT_Cached_Faction", lbText [_idcFaction, lbCurSel _idcFaction]];
        ["Faction"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf");
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
        ["Subfaction"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf");
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
        ["Camo"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf");
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
        
        // Clear targets after full cascade
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
        _meta set ["Side", _selSide];
        _meta set ["FactionName", _selFaction];
        _meta set ["Subfaction", _selSub];
        _meta set ["Camo", _selCamo];
        _meta set ["Era", _selEra];
        _masterHash set ["Metadata", _meta];

        private _factionPath = ["Scripts\Factions\", _selSide, "\", _selFaction, "\", (if(_selSub != "")then{_selSub+"\"}else{""}), (if(_selEra != "")then{_selEra+"\"}else{""}), _selCamo, "\"] joinString "";
        
        // 1. Load Armory Sequence
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

        // 2. Load Motorpool Sequence
        private _motorSeq = [];
        private _vehPath = _factionPath + "Vehicles.sqf";
        if (fileExists _vehPath) then {
            private _vehs = call compile preprocessFile _vehPath;
            {
                private _catName = _x select 0;
                private _vList = _x select 1;
                { _motorSeq pushBack [_x select 0, _catName]; } forEach _vList;
            } forEach _vehs;
        };
        _masterHash set ["MotorpoolSequence", _motorSeq];

        // 2.5 Prepare Framework Proxy (Strong Logic)
        private _fnc_prep = missionNamespace getVariable ["FBT_Fnc_PrepareFramework", {params ["_p"]; [_p] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_PrepareFramework.sqf")}];
        [_factionPath] call _fnc_prep;

        // 2.6 Load physical gear data from disk into Session Hash
        [_factionPath] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_LoadFactionData.sqf");

        // 3. Process Sequence into Flat Arrays for Spawner
        private _groupsList = [];
        private _rolesList  = [];
        private _idList     = [];
        
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

        // Final Debounced Spawn
        if (!_isSuppressed) then {
            [] spawn { 
                systemChat "[FBT] Refreshing Staging Area...";
                uiSleep 0.05;
                execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf"; 
            };
        };
    };
};
