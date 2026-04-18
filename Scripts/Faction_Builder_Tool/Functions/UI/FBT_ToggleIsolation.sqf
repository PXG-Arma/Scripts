/*
    FBT_ToggleIsolation.sqf
    -------------------------------
    Toggles the isolation mode in the Armory.
    Isolation ON: Only the selected role is visible.
    Isolation OFF: All roles are visible.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _isolate = !(missionNamespace getVariable ["FBT_Armory_IsolateUnit", true]);
missionNamespace setVariable ["FBT_Armory_IsolateUnit", _isolate];

// Update Button State
private _ctrl = _display displayCtrl 456008;
if (_isolate) then {
    _ctrl ctrlSetTextColor [1, 1, 1, 1];
    _ctrl ctrlSetTooltip "Isolation: ON (Only active unit visible)";
} else {
    _ctrl ctrlSetTextColor [0.4, 0.8, 0.4, 1]; // Green highlight when viewing all
    _ctrl ctrlSetTooltip "Isolation: OFF (Entire parade visible)";
};

// Refresh Visibility
private _tree = _display displayCtrl 456010;
private _curSel = tvCurSel _tree;
if (count _curSel > 0) then {
    [_tree, _curSel] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdatePreview.sqf";
};

playSound ["RscDisplayCurator_ping01", true];
