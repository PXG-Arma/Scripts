/*
    PXG_Builder_ToggleOpacity.sqf
    -------------------------------
    Toggles the opacity for all backgrounds in the Faction Builder.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

// Background IDCs
private _bgs = [456011, 456021, 456032, 456040]; // Left, Right, Bottom, Extended
private _opacBtn = _display displayCtrl 456006;

private _isSolid = _display getVariable ["PXG_Opacity_Solid", false];

if (_isSolid) then {
	// Revert to 80% opacity
    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlSetBackgroundColor [0.1, 0.1, 0.1, 0.8];
        _ctrl ctrlCommit 0.2;
    } forEach _bgs;
	
	_opacBtn ctrlSetBackgroundColor [0.2, 0.25, 0.25, 0.6];
	_opacBtn ctrlCommit 0.2;
	_display setVariable ["PXG_Opacity_Solid", false];
} else {
	// Make 100% Solid
    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1.0];
        _ctrl ctrlCommit 0.2;
    } forEach _bgs;
	
	_opacBtn ctrlSetBackgroundColor [0.35, 0.45, 0.45, 0.9];
	_opacBtn ctrlCommit 0.2;
	_display setVariable ["PXG_Opacity_Solid", true];
};
