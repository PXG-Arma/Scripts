/*
    FBT_ToggleExtended.sqf
    -------------------------------
    Animates the Extended Panel sliding out to the right of the Left Panel.
    Handles action initialization (New vs Duplicate).
*/
params [["_show", true]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _bg = _display displayCtrl 456040;
private _group = _display displayCtrl 456060;

// Handle Boolean OR String action
private _isClosing = if (typeName _show == "BOOL") then { !_show } else { false };
private _action = if (typeName _show == "STRING") then { _show } else { "" };

if (!_isClosing) then {
    // EXPAND
    _bg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.05), safezoneW * 0.25, safezoneH * 0.95];
    _group ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.07), safezoneW * 0.23, safezoneH * 0.85];
    _bg ctrlCommit 0.3;
    _group ctrlCommit 0.3;
    
    _group ctrlShow true;

    // Initialize logic if action provided
    if (_action != "") then {
        _display setVariable ["FBT_PendingAction", _action];
        ["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf";
        systemChat format ["[FBT] Initiating %1 flow...", _action];
    };
} else {
    // COLLAPSE
    _bg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.05), 0, safezoneH * 0.95];
    _group ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.07), 0, safezoneH * 0.85];
    _bg ctrlCommit 0.3;
    _group ctrlCommit 0.3;
    
    _display setVariable ["FBT_PendingAction", ""];

    // Hide group after animation completes
    [] spawn {
        uiSleep 0.3;
        private _disp = findDisplay 456000;
        if (!isNull _disp) then {
             (_disp displayCtrl 456060) ctrlShow false;
        };
    };
};
