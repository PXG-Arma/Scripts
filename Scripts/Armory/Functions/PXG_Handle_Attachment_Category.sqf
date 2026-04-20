#include "..\..\macros.hpp"
/*
    PXG_Handle_Attachment_Category.sqf
    ----------------------------------
    Fired when clicking one of the 4 attachment icons.
    Sets the active category and refreshes the list.
*/

params ["_category"];

private _display = findDisplay IDD_ARMORY;
if (isNull _display) exitWith {};

// 1. Update State
_display setVariable ["PXG_Armory_Active_Attachment_Slot", _category];

// 2. UI Feedback (Highlight active icon)
private _icons = [
    ["optic", IDC_ARMORY_SIGHT_ICON],
    ["bipod", IDC_ARMORY_UNDERBARREL_ICON],
    ["acc", IDC_ARMORY_GRIP_ICON],
    ["muzzle", IDC_ARMORY_MUZZLE_ICON]
];

{
    _x params ["_catName", "_idc"];
    private _ctrl = _display displayCtrl _idc;
    if (_catName == _category) then {
        _ctrl ctrlSetBackgroundColor [0.29, 0.42, 0.42, 1]; // Active Highlight
    } else {
        _ctrl ctrlSetBackgroundColor [0, 0, 0, 0]; // Transparent
    };
} forEach _icons;

// 3. Refresh List
// Trigger the weapon list "Update Only" mode to refresh the bottom section
private _ctrlWeaponList = _display displayCtrl IDC_ARMORY_WEAPON_LIST;
[_ctrlWeaponList] call compile preprocessFile "Scripts\Armory\Functions\PXG_Refresh_Modular_Lists.sqf";
