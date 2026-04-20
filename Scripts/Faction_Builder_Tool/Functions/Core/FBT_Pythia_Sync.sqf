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
        ["FBT.call", ["fbt_manager", "update_registry", [_missionRoot]]] call py3_fnc_callExtension;
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
    
    _res
};
