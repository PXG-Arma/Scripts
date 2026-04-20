#include "..\macros.hpp"
/*
    PXG_Handle_UI_Expansion.sqf
    ---------------------------
    Handles the smooth shift animation for centering the UI when side panels are toggled.
    
    Inputs:
    0: DISPLAY - The UI display object
    1: BOOL    - Expansion state (true = Expand & Center, false = Collapse & Center)
    2: ARRAY   - List of Side Panel IDCs to animate
*/

params [["_display", displayNull], ["_shouldExpand", false], ["_sideIDCs", []]];

if (isNull _display) exitWith {};

// --- 1. CONFIGURATION ---
private _mainTargetX = if (_shouldExpand) then { PXG_UI_MAIN_X_CENTERED } else { PXG_UI_MAIN_X };
private _sideTargetX = if (_shouldExpand) then { PXG_UI_EXT_X_CENTERED } else { PXG_UI_EXT_X };

private _sideControls = _sideIDCs apply { _display displayCtrl _x };
private _allControls = allControls _display;

// Only move top-level controls to prevent double-shifting nested elements
private _topLevelControls = _allControls select { isNull (ctrlParentControlsGroup _x) };
private _mainControls = _topLevelControls - _sideControls;

// --- 2. CALCULATE SHIFT DELTA ---
// We find the current X of the first visible main control to determine the required movement
private _referenceControl = controlNull;
{
    if (ctrlShown _x && { (ctrlPosition _x select 0) > (safezoneX) }) exitWith { _referenceControl = _x };
} forEach _mainControls;

if (isNull _referenceControl) exitWith {}; // Safety exit if no reference found

private _currentX = (ctrlPosition _referenceControl) select 0;
private _deltaX = _mainTargetX - _currentX;

// If we are already at the target and side panel fade matches intent, skip
if (count _sideControls == 0) exitWith {};
private _targetFade = if (_shouldExpand) then {0} else {1};
if (abs(_deltaX) < 0.001 && { (ctrlFade (_sideControls select 0)) == _targetFade }) exitWith {};

// --- 3. ANIMATE MAIN PANEL ---
{
    private _pos = ctrlPosition _x;
    _x ctrlSetPosition [(_pos select 0) + _deltaX, _pos select 1, _pos select 2, _pos select 3];
    _x ctrlCommit 0.5;
} forEach _mainControls;

// --- 4. ANIMATE SIDE PANEL ---
private _currentSideX = (ctrlPosition (_sideControls select 0)) select 0;
private _deltaSideX = _sideTargetX - _currentSideX;

{
    private _pos = ctrlPosition _x;
    if (_shouldExpand) then {
        // Prepare for fade-in if currently hidden
        if (!ctrlShown _x || { (ctrlFade _x) == 1 }) then {
            _x ctrlSetFade 1;
            _x ctrlCommit 0;
            _x ctrlShow true;
        };
        
        _x ctrlSetPosition [(_pos select 0) + _deltaSideX, _pos select 1, _pos select 2, _pos select 3];
        _x ctrlSetFade 0;
        _x ctrlCommit 0.5;
    } else {
        // Move back and fade out
        _x ctrlSetPosition [(_pos select 0) + _deltaSideX, _pos select 1, _pos select 2, _pos select 3];
        _x ctrlSetFade 1;
        _x ctrlCommit 0.5;
        
        // Hide after animation completes
        _x spawn { sleep 0.5; if ( (ctrlFade _this) >= 0.9 ) then { _this ctrlShow false; }; };
    };
} forEach _sideControls;
