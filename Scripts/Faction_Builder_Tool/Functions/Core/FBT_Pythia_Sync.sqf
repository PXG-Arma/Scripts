FBT_fnc_Pythia_Sync = {
    /*
        FBT_fnc_Pythia_Sync
        -------------------------------
        Synchronizes the current FBT state to disk using the Pythia Governor.
        Supports "Sync" (Save during session) and "Commit" (Final disk rebuild).
    */
    params [["_mode", "Sync"]];

    if !(missionNamespace getVariable ["FBT_Bridge_Ready", false]) then {
        [] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Bridge_Init.sqf";
    };

    if !(missionNamespace getVariable ["FBT_Bridge_Ready", false]) exitWith {
        systemChat "[FBT] Sync Failed: Bridge not initialized.";
        []
    };

    // Sanitize Path: Convert "\" to "/"
    private _missionRoot = (getMissionPath "") splitString "\" joinString "/";
    if ((_missionRoot select [count _missionRoot - 1, 1]) != "/") then { _missionRoot = _missionRoot + "/"; };

    // --- MODE: COMMIT (Direct scanned rebuild) ---
    if (_mode == "Commit") exitWith {
        diag_log "[FBT] Committing Registry to Disk...";
        private _res = ["FBT.call", ["fbt_manager", "update_registry", [_missionRoot]]] call py3_fnc_callExtension;
        missionNamespace setVariable ["PXG_MasterRegistry_Cache", nil];
        _res
    };

    // --- MODE: SYNC (Fast Session Save) ---
    private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
    if (count _masterHash == 0) exitWith { 
        diag_log "[FBT Sync] Error: Master Hash empty.";
        [false, "Session Data Missing", []]
    };

    // Robust Serialization Helper (HashMap -> Array of Pairs)
    private _fnc_hashToPairs = {
        params ["_input"];
        if !(_input isEqualType createHashMap) exitWith { _input };
        private _pairs = [];
        {
            private _val = _y;
            if (_val isEqualType createHashMap) then { _val = [_val] call _fnc_hashToPairs; };
            _pairs pushBack [_x, _val];
        } forEach _input;
        _pairs
    };

    private _fullDataPairs = [_masterHash] call _fnc_hashToPairs;

    // Call Governor via Proxy (run_scan = false for session mode)
    // Arguments: [mission_root, data_pairs, run_scan]
    private _res = ["FBT.call", ["fbt_manager", "save_faction", [_missionRoot, _fullDataPairs, false]]] call py3_fnc_callExtension;
    
    if (_res isEqualType [] && {count _res >= 4} && {_res select 0}) then {
        private _newEntries = _res select 3;
        if (_newEntries isEqualType []) then {
            private _cache = missionNamespace getVariable ["PXG_MasterRegistry_Cache", []];
            private _added = 0;
            { 
                private _entry = _x;
                if ({ _x isEqualTo _entry } count _cache == 0) then { 
                    _cache pushBack _entry; 
                    _added = _added + 1;
                }; 
            } forEach _newEntries;
            
            if (_added > 0) then {
                _cache sort true;
                missionNamespace setVariable ["PXG_MasterRegistry_Cache", _cache];
                diag_log format ["[FBT Sync] Memory Bridge Updated: %1 new entries added to cache.", _added];
            } else {
                diag_log "[FBT Sync] Memory Bridge: No new entries added (already present in cache).";
            };
        };
    } else {
        diag_log format ["[FBT Sync] Warning: Registry Cache not updated. Backend Result: %1", _res];
    };

    _res
};
