/*
    FBT_ToggleInventory.sqf
    -------------------------------
    Collapses or expands the Bottom Panel Inventory view to save screen real estate.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _bottomBg = _display displayCtrl 456032;
private _invText = _display displayCtrl 456030;
private _btnCollapse = _display displayCtrl 456031;

// Retrieve the current toggled state (defaults to expanded/false)
private _isCollapsed = _display getVariable ["FBT_Inventory_Collapsed", false];

if (_isCollapsed) then {
	// EXPAND IT
	_bottomBg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.75), safezoneW * 0.5, safezoneH * 0.25];
	_invText ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.77), safezoneW * 0.40, safezoneH * 0.03];
	_btnCollapse ctrlSetPosition [safezoneX + (safezoneW * 0.72), safezoneY + (safezoneH * 0.77), safezoneW * 0.02, safezoneH * 0.03];
	
	_btnCollapse ctrlSetText "-";
	_btnCollapse ctrlSetBackgroundColor [0.2, 0.25, 0.25, 0.6]; // Normal muted state
	_display setVariable ["FBT_Inventory_Collapsed", false];
} else {
	// COLLAPSE IT
	_bottomBg ctrlSetPosition [safezoneX + (safezoneW * 0.25), safezoneY + (safezoneH * 0.96), safezoneW * 0.5, safezoneH * 0.04];
	_invText ctrlSetPosition [safezoneX + (safezoneW * 0.26), safezoneY + (safezoneH * 0.965), safezoneW * 0.40, safezoneH * 0.03];
	_btnCollapse ctrlSetPosition [safezoneX + (safezoneW * 0.72), safezoneY + (safezoneH * 0.965), safezoneW * 0.02, safezoneH * 0.03];
	
	_btnCollapse ctrlSetText "+";
	_btnCollapse ctrlSetBackgroundColor [0.35, 0.45, 0.45, 0.9]; // Highlighted/greyer state when collapsed
	_display setVariable ["FBT_Inventory_Collapsed", true];
};

_bottomBg ctrlCommit 0.3;
_invText ctrlCommit 0.3;
_btnCollapse ctrlCommit 0.3;
