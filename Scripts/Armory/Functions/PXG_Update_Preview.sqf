#include "..\..\macros.hpp"
/*
    PXG_Update_Preview.sqf
    ----------------------------
    Updates the IDC_ARMORY_PREVIEW_PICTURE with the selected weapon icon.
*/

private _display = findDisplay IDD_ARMORY;
private _ctrlWeaponList = _display displayCtrl IDC_ARMORY_WEAPON_LIST;
private _ctrlPreview = _display displayCtrl IDC_ARMORY_PREVIEW_PICTURE;

private _selectionData = _ctrlWeaponList lbData (lbCurSel _ctrlWeaponList);
private _split = _selectionData splitString "|";
private _selectedWeapon = if (count _split > 0) then { _split select 0 } else { "" };

if (_selectedWeapon == "") exitWith { _ctrlPreview ctrlSetText ""; };

private _picture = getText (configFile >> "CfgWeapons" >> _selectedWeapon >> "picture");
_ctrlPreview ctrlSetText _picture;
