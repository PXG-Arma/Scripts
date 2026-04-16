#include "..\..\macros.hpp"

private _display = uiNamespace getVariable ["PXG_Cam_Active_Display", displayNull];
if (isNull _display) exitWith {};

private _ctrlList = _display displayCtrl IDC_MOTORPOOL_PYLON_LIST;
private _index = lbCurSel _ctrlList;
if (_index == -1) exitWith {};

private _pylonIdx = _ctrlList lbValue _index;
private _pylonName = _ctrlList lbData _index;

// Determine target vehicle
private _vehicle = player getVariable ["PXG_Motorpool_Active_Vehicle", objNull];
if (isNull _vehicle) then {
    _vehicle = missionNamespace getVariable ["PXG_Cam_TargetObj", objNull];
};
if (isNull _vehicle) exitWith {};

// Get compatible magazines
private _compatible = _vehicle getCompatiblePylonMagazines _pylonIdx;

private _ctrlCombo = _display displayCtrl IDC_MOTORPOOL_PYLON_COMBO;
lbClear _ctrlCombo;

// Add "Empty" option
private _emptyIdx = _ctrlCombo lbAdd "--- Empty ---";
_ctrlCombo lbSetData [_emptyIdx, ""];

{
    private _displayName = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
    private _icon = getText (configFile >> "CfgMagazines" >> _x >> "picture");
    
    private _idx = _ctrlCombo lbAdd _displayName;
    _ctrlCombo lbSetData [_idx, _x];
    _ctrlCombo lbSetPicture [_idx, _icon];
} forEach _compatible;

_ctrlCombo lbSetCurSel 0;
