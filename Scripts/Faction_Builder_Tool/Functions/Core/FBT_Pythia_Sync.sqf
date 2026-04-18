FBT_fnc_Pythia_Sync = {
    /*
        FBT_fnc_Pythia_Sync
        -------------------------------
        Synchronizes the current FBT state to disk using the Pythia Governor.
        - Serializes Master Hash to Array-of-Pairs (Reliable I/O).
        - Calls fbt_manager.py via the Mod Bridge.
        - Returns: [Success (bool), Message (string), Metadata (array)]
    */

if !(missionNamespace getVariable ["FBT_Bridge_Ready", false]) then {
    [] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Bridge_Init.sqf";
};

if !(missionNamespace getVariable ["FBT_Bridge_Ready", false]) exitWith {
    systemChat "[FBT] Sync Failed: Bridge not initialized.";
};

private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
if (count _masterHash == 0) exitWith { diag_log "[FBT Sync] Error: Master Hash empty."; };

diag_log "[FBT Sync] Starting serialization...";

// 1. Robust Serialization Helper (HashMap -> Array of Pairs)
private _fnc_hashToPairs = {
    params ["_input"];
    if !(_input isEqualType createHashMap) exitWith { _input };
    
    private _pairs = [];
    {
        private _val = _y;
        if (_val isEqualType createHashMap) then {
            _val = [_val] call _fnc_hashToPairs;
        };
        _pairs pushBack [_x, _val];
    } forEach _input;
    _pairs
};

// 2. Prepare Data
private _fullDataPairs = [_masterHash] call _fnc_hashToPairs;

// Sanitize Path: Convert "\" to "/" to prevent Python escape character corruption
private _missionRoot = (getMissionPath "") splitString "\" joinString "/";
if !(_missionRoot endsWith "/") then { _missionRoot = _missionRoot + "/"; };

// 3. Call Governor via Proxy
// Arguments: [mission_root, data_pairs]
private _res = ["FBT.call", ["fbt_manager", "save_faction", [_missionRoot, _fullDataPairs]]] call py3_fnc_callExtension;

    _res
};
