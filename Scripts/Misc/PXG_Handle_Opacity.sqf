#include "..\macros.hpp"

params [["_display", displayNull], ["_mode", "init"]];

// Fallback: If display handle is invalid, try to find it by IDD
if (isNull _display) then {
    if !(isNull findDisplay IDD_ARMORY) exitWith { _display = findDisplay IDD_ARMORY };
    if !(isNull findDisplay IDD_RESUPPLY) exitWith { _display = findDisplay IDD_RESUPPLY };
    if !(isNull findDisplay IDD_MOTORPOOL) exitWith { _display = findDisplay IDD_MOTORPOOL };
};

if (isNull _display) exitWith {};

// Map IDD to correct Background IDC
private _idd = ctrlIDD _display;
private _bgIDC = switch (_idd) do {
    case IDD_ARMORY: { IDC_ARMORY_BACKGROUND };
    case IDD_RESUPPLY: { IDC_RESUPPLY_BACKGROUND };
    case IDD_MOTORPOOL: { IDC_MOTORPOOL_BACKGROUND };
    default { -1 };
};

if (_bgIDC == -1) exitWith {};

// Collector for all background controls in the current display
private _bgCtrls = [_display displayCtrl _bgIDC];
if (_idd == IDD_RESUPPLY) then { _bgCtrls pushBack (_display displayCtrl 451700); };
if (_idd == IDD_ARMORY) then { _bgCtrls pushBack (_display displayCtrl IDC_ARMORY_MODULAR_PANEL); };
if (_idd == IDD_MOTORPOOL) then { _bgCtrls pushBack (_display displayCtrl IDC_MOTORPOOL_PYLON_PANEL); };

private _toggleBtn = _display displayCtrl IDC_UI_OPACITY_TOGGLE;

if (_mode == "init") then {
    // Read preference (Default 0.8)
    private _alpha = profileNamespace getVariable ["PXG_UI_Alpha", 0.8];
    // Force default if 1.0 or 0.8 are not the current values (in case of old garbage data or nil)
    if !(_alpha in [0.8, 1.0]) then { _alpha = 0.8; profileNamespace setVariable ["PXG_UI_Alpha", 0.8]; saveProfileNamespace; };

    { _x ctrlSetBackgroundColor [0.1, 0.1, 0.1, _alpha]; } forEach _bgCtrls;
    
    // Update button visual state
    if (_alpha == 1.0) then {
        _toggleBtn ctrlSetText "%";
        _toggleBtn ctrlSetTooltip "Background: Solid (Click for Soft)";
    } else {
        _toggleBtn ctrlSetText "%";
        _toggleBtn ctrlSetTooltip "Background: Soft (Click for Solid)";
    };
};

if (_mode == "toggle") then {
    private _currentAlpha = profileNamespace getVariable ["PXG_UI_Alpha", 0.8];
    private _newAlpha = if (_currentAlpha == 0.8) then { 1.0 } else { 0.8 };
    
    // Save preference
    profileNamespace setVariable ["PXG_UI_Alpha", _newAlpha];
    saveProfileNamespace;
    
    // Apply to UI
    { _x ctrlSetBackgroundColor [0.1, 0.1, 0.1, _newAlpha]; } forEach _bgCtrls;
    
    // Update button visual state
    if (_newAlpha == 1.0) then {
        _toggleBtn ctrlSetText "%";
        _toggleBtn ctrlSetTooltip "Background: Solid (Click for Soft)";
    } else {
        _toggleBtn ctrlSetText "%";
        _toggleBtn ctrlSetTooltip "Background: Soft (Click for Solid)";
    };
};
