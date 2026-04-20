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

private _fnc_resetLock = { missionNamespace setVariable ["FBT_ActiveCascade", false]; };

private _fnc_addOptions = {
    params ["_ctrlIDC", "_list", ["_addOption", true], ["_target", ""], ["_placeholder", ""]];
    private _ctrl = (findDisplay 456000) displayCtrl _ctrlIDC;
    lbClear _ctrl;
    
    private _finalList = if (_placeholder != "" && _target == "") then { [_placeholder] + _list } else { _list };
    
    { _ctrl lbAdd _x; } forEach _finalList;
    if (_addOption) then {
        private _idx = _ctrl lbAdd "+ ADD NEW";
        _ctrl lbSetColor [_idx, [0.3, 0.8, 0.3, 1]];
    };
    
    private _selIdx = 0;
    if (_target != "") then {
        { if (_x == _target) exitWith { _selIdx = _forEachIndex; }; } forEach _finalList;
    };
    
    missionNamespace setVariable ["FBT_SuppressEvents", true];
    _ctrl lbSetCurSel _selIdx;
    missionNamespace setVariable ["FBT_SuppressEvents", false];
    
    // Return true if we are on a valid selection (not a placeholder)
    (_placeholder == "" || _selIdx > 0)
};

private _selSide = (lbText [_idcSide, lbCurSel _idcSide]);

switch (_mode) do {
    case "Init": {
        // Populate Sides
        private _targetSide = missionNamespace getVariable ["FBT_Target_Side", ""];
        private _placeholder = if (_targetSide == "") then { "--- SELECT SIDE ---" } else { "" };
        private _valid = [_idcSide, ["BLUFOR", "OPFOR", "INDEP"], false, _targetSide, _placeholder] call _fnc_addOptions;
        
        if (_targetSide != "") then { systemChat format ["[FBT] Init: Target Side found: %1 (Valid: %2)", _targetSide, _valid]; };

        missionNamespace setVariable ["FBT_Cached_Side", lbText [_idcSide, lbCurSel _idcSide]];
        if (_valid && !_isSuppressed) then { ["Side"] call _fnc_UpdateDropdowns; };
    };

    case "Side": {
        if (_isSuppressed && _mode != "Init") exitWith {}; 
        if (_selSide find "SELECT" != -1) exitWith {
             [_idcFaction, [], true, "", "--- SELECT FACTION ---"] call _fnc_addOptions;
             call _fnc_resetLock;
        };

        private _factions = [];
        { if ((_x select 0) == _selSide && !((_x select 1) in _factions)) then { _factions pushBack (_x select 1); }; } forEach _registry;
        
        private _targetFaction = missionNamespace getVariable ["FBT_Target_Faction", ""];
        private _placeholder = if (count _factions > 1 && _targetFaction == "") then { "--- SELECT FACTION ---" } else { "" };
        
        private _valid = [_idcFaction, _factions, true, _targetFaction, _placeholder] call _fnc_addOptions;
        
        if (_targetFaction != "") then { systemChat format ["[FBT] Side: Target Faction found: %1 (Valid: %2)", _targetFaction, _valid]; };

        missionNamespace setVariable ["FBT_Cached_Faction", lbText [_idcFaction, lbCurSel _idcFaction]];
        if (_valid) then { ["Faction"] call _fnc_UpdateDropdowns; };
    };

    case "Faction": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        if (_selFaction find "SELECT" != -1) exitWith {
            [_idcSub, [], true, "", "--- SELECT SUBFACTION ---"] call _fnc_addOptions;
            call _fnc_resetLock;
        };

        private _subs = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && !((_x select 2) in _subs)) then { _subs pushBack (_x select 2); }; } forEach _registry;
        
        private _targetSub = missionNamespace getVariable ["FBT_Target_Sub", ""];
        private _displayTarget = if(_targetSub == "") then {""} else {if(_targetSub == "") then {"Base"} else {_targetSub}};
        private _displaySubs = _subs apply { if (_x == "") then { "Base" } else { _x } };
        
        private _placeholder = if (count _subs > 1 && _targetSub == "") then { "--- SELECT SUBFACTION ---" } else { "" };
        private _valid = [_idcSub, _displaySubs, true, _displayTarget, _placeholder] call _fnc_addOptions;
        
        if (_targetSub != "") then { systemChat format ["[FBT] Faction: Target Subfaction found: %1 (Valid: %2)", _targetSub, _valid]; };
        
        private _selIdx = lbCurSel _idcSub;
        private _realSub = if (_placeholder != "" && _selIdx == 0) then { "--- SELECT ---" } else { _subs select (if(_placeholder != "") then {_selIdx - 1} else {_selIdx}) };
        missionNamespace setVariable ["FBT_Cached_Sub", _realSub];
        
        if (_valid) then { ["Subfaction"] call _fnc_UpdateDropdowns; };
    };

    case "Subfaction": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _selSub = lbText [_idcSub, lbCurSel _idcSub];
        if (_selSub find "SELECT" != -1) exitWith {
            [_idcCamo, [], true, "", "--- SELECT CAMO ---"] call _fnc_addOptions;
            call _fnc_resetLock;
        };
        if (_selSub == "Base") then { _selSub = ""; };
        
        private _camos = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && (_x select 2) == _selSub && !((_x select 4) in _camos)) then { _camos pushBack (_x select 4); }; } forEach _registry;
        
        private _targetCamo = missionNamespace getVariable ["FBT_Target_Camo", ""];
        private _placeholder = if (count _camos > 1 && _targetCamo == "") then { "--- SELECT CAMO ---" } else { "" };
        
        private _valid = [_idcCamo, _camos, true, _targetCamo, _placeholder] call _fnc_addOptions;

        if (_targetCamo != "") then { systemChat format ["[FBT] Subfaction: Target Camo found: %1 (Valid: %2)", _targetCamo, _valid]; };

        missionNamespace setVariable ["FBT_Cached_Camo", lbText [_idcCamo, lbCurSel _idcCamo]];
        
        if (_valid) then { ["Camo"] call _fnc_UpdateDropdowns; };
    };

    case "Camo": {
        private _selFaction = lbText [_idcFaction, lbCurSel _idcFaction];
        private _selSub = lbText [_idcSub, lbCurSel _idcSub];
        if (_selSub == "Base") then { _selSub = ""; };
        private _selCamo = lbText [_idcCamo, lbCurSel _idcCamo];
        if (_selCamo find "SELECT" != -1) exitWith {
            [_idcEra, [], true, "", "--- SELECT ERA ---"] call _fnc_addOptions;
            call _fnc_resetLock;
        };

        private _eras = [];
        { if ((_x select 0) == _selSide && (_x select 1) == _selFaction && (_x select 2) == _selSub && (_x select 4) == _selCamo && !((_x select 3) in _eras)) then { _eras pushBack (_x select 3); }; } forEach _registry;
        
        private _targetEra = missionNamespace getVariable ["FBT_Target_Era", ""];
        private _placeholder = if (count _eras > 1 && _targetEra == "") then { "--- SELECT ERA ---" } else { "" };
        
        private _valid = [_idcEra, _eras, true, _targetEra, _placeholder] call _fnc_addOptions;
        
        if (_valid) then {
            missionNamespace setVariable ["FBT_SuppressEvents", true];
            ["Era"] call _fnc_UpdateDropdowns;
            missionNamespace setVariable ["FBT_SuppressEvents", false];
        };
        
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

        if (_selEra find "SELECT" != -1) exitWith {
             missionNamespace setVariable ["FBT_ActiveCascade", false];
        };

        private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
        if (typeName _masterHash != "HASHMAP") then { _masterHash = createHashMap; missionNamespace setVariable ["FBT_MasterHash", _masterHash]; };
        
        private _meta = _masterHash getOrDefault ["Metadata", createHashMap];
        _meta set ["SIDE", _selSide];
        _meta set ["FACTIONNAME", _selFaction];
        _meta set ["SUBFACTION", _selSub];
        _meta set ["CAMO", _selCamo];
        _meta set ["ERA", _selEra];
        _masterHash set ["Metadata", _meta];

        private _factionPath = ["Scripts\Factions\", _selSide, "\", _selFaction, "\", (if(_selSub != "")then{_selSub+"\"}else{""}), (if(_selEra != "")then{_selEra+"\"}else{""}), _selCamo, "\"] joinString "";
        
        // Reset Proxy to avoid stale script references during cascade
        missionNamespace setVariable ["FBT_FrameworkProxy", createHashMap];
        
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
        if (count _existingGroups == 0) then {
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

            // 4. Modular Discovery (BigArmory Integration)
            // This is only needed for Legacy factions. New framework (1-file) already has this data in Faction_Core.sqf.
            private _proxy = missionNamespace getVariable ["FBT_FrameworkProxy", createHashMap];
            private _wepCode = _proxy getOrDefault ["Weapons.sqf", {}];
            
            // SKIP DISCOVERY if 1-file framework is detected
            if (!(fileExists _corePath) && { !(_wepCode isEqualTo {}) }) then {
                diag_log "[FBT Discovery] Starting modular metadata discovery...";
                private _slotGroups = _masterHash getOrDefault ["SlotGroups", createHashMap];
                private _gunGroups = _masterHash getOrDefault ["GunGroups", createHashMap];
                private _sights = _masterHash getOrDefault ["SightGroups", createHashMap];
                private _attachments = _masterHash getOrDefault ["Attachment_Standards", createHashMap];

                // Robust reset: ensure we are working with HashMaps, not stale arrays or strings
                if (typeName _slotGroups != "HASHMAP") then { _slotGroups = createHashMap; };
                if (typeName _gunGroups != "HASHMAP") then { _gunGroups = createHashMap; };
                if (typeName _sights != "HASHMAP") then { _sights = createHashMap; };
                if (typeName _attachments != "HASHMAP") then { _attachments = createHashMap; };

                private _flatIDs = [];
                { { _flatIDs pushBackUnique _x; } forEach _x; } forEach _idList;

                {
                    private _roleID = _x;
                    // Discover SlotGroup for this role
                    private _group = [_selSide, _selFaction, _selCamo, _roleID, "SLOTGROUP", "", "", "", objNull] call _wepCode;
                    if (!isNil "_group" && { typeName _group == "STRING" } && { _group != "" }) then {
                        _slotGroups set [_roleID, _group];
                        
                        // Discover GunGroups available for this SlotGroup
                        private _weapAssign = [_selSide, _selFaction, _selCamo, _group, "WEAPASSIGN", "", "", "", objNull] call _wepCode;
                        if (!isNil "_weapAssign" && { typeName _weapAssign == "ARRAY" }) then {
                            {
                                private _weapGroup = _x;
                                // Discover weapons in this GunGroup
                                private _guns = [_selSide, _selFaction, _selCamo, _weapGroup, "GUNGROUP", "", "", "", objNull] call _wepCode;
                                if (!isNil "_guns" && { typeName _guns == "ARRAY" }) then {
                                    _gunGroups set [_weapGroup, _guns];
                                    // Discover standard attachments for each gun
                                    {
                                        private _gun = _x;
                                        private _stdAtts = [_selSide, _selFaction, _selCamo, _roleID, "ATTACHMENTS", _gun, "", "", objNull] call _wepCode;
                                        if (!isNil "_stdAtts" && { typeName _stdAtts == "ARRAY" } && { count _stdAtts > 0 }) then {
                                            _attachments set [_gun, _stdAtts];
                                        };
                                    } forEach _guns;
                                };
                                // Discover sights for this SlotGroup + GunGroup combo
                                private _scopes = [_selSide, _selFaction, _selCamo, _roleID, "SCOPES", "", _weapGroup, _group, objNull] call _wepCode;
                                if (!isNil "_scopes" && { typeName _scopes == "ARRAY" } && { count _scopes > 0 }) then {
                                    private _sightKey = format ["%1_%2", _group, _weapGroup];
                                    _sights set [_sightKey, _scopes];
                                };
                            } forEach _weapAssign;
                        };
                    };
                } forEach _flatIDs;

                _masterHash set ["SlotGroups", _slotGroups];
                _masterHash set ["GunGroups", _gunGroups];
                _masterHash set ["SightGroups", _sights];
                _masterHash set ["Attachment_Standards", _attachments];
                diag_log format ["[FBT Discovery] Completed: %1 SlotGroups, %2 GunGroups found.", count _slotGroups, count _gunGroups];
            };
        };

        // Final Debounced Spawn
        if (!_isSuppressed) then {
            private _lastTrigger = missionNamespace getVariable ["FBT_LastSpawnTrigger", 0];
            if (diag_tickTime - _lastTrigger >= 0.25) then {
                missionNamespace setVariable ["FBT_LastSpawnTrigger", diag_tickTime];
                [] spawn (missionNamespace getVariable ["FBT_Fnc_SpawnParade", {}]);
            };
        };

        // Reset Cascade Lock
        call _fnc_resetLock;
    };
};
