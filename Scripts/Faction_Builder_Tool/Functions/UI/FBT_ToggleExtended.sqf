/*
    FBT_ToggleExtended.sqf
    -------------------------------
    Animates the Extended Panel sliding out to the right of the Left Panel.
*/
params [["_show", true]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _bg = _display displayCtrl 456040;
private _group = _display displayCtrl 456060;

if (_show) then {
    // EXPAND
    _bg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.05), safezoneW * 0.25, safezoneH * 0.95];
    _group ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.07), safezoneW * 0.23, safezoneH * 0.85];
    _bg ctrlCommit 0.3;
    _group ctrlCommit 0.3;
    
    _group ctrlShow true;
} else {
    // COLLAPSE
    _bg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.05), 0, safezoneH * 0.95];
    _group ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.07), 0, safezoneH * 0.85];
    _bg ctrlCommit 0.3;
    _group ctrlCommit 0.3;
    
    // Hide group after animation completes
    [] spawn {
        uiSleep 0.3;
        (findDisplay 456000 displayCtrl 456060) ctrlShow false;
    };
};
