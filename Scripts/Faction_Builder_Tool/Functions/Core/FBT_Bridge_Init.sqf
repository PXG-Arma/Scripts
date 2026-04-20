/*
    FBT_Bridge_Init.sqf
    -------------------------------
    Automates the initialization of the Pythia Bridge.
    Connects the mission folder (C:) to the mod folder (D:).
*/

diag_log "[FBT Bridge] Initializing Pythia Bridge...";

if (isNil "py3_fnc_callExtension") exitWith {
    diag_log "[FBT Bridge] ERROR: Pythia Extension not found! Persistence will be disabled.";
    missionNamespace setVariable ["FBT_Bridge_Ready", false];
};

// Registry Sync Bridge is now pre-compiled globally in init_Builder.sqf

private _missionRoot = getMissionPath "";
private _res = ["FBT.register_mission_path", [_missionRoot]] call py3_fnc_callExtension;

if (_res select 0) then {
    diag_log format ["[FBT Bridge] SUCCESS: Bridge established and Refreshed: %1", _res select 1];
    missionNamespace setVariable ["FBT_Bridge_Ready", true];
    
    // Heartbeat: Confirm mission-side logic is accessible
    private _ping = ["FBT.call", ["fbt_manager", "mission_check", []]] call py3_fnc_callExtension;
    diag_log format ["[FBT Bridge] Heartbeat: %1", _ping];
    systemChat "[FBT] Pythia Bridge Synchronized.";
} else {
    diag_log format ["[FBT Bridge] FAILED: %1", _res select 1];
    systemChat "[FBT] Bridge Connection Failed. Check RPT.";
    missionNamespace setVariable ["FBT_Bridge_Ready", false];
};

missionNamespace getVariable ["FBT_Bridge_Ready", false];
