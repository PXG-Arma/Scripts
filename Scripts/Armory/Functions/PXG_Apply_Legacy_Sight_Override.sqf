/*
    PXG_Apply_Legacy_Sight_Override.sqf
    ----------------------------
    Post-processing script for legacy factions to apply UI-selected optics.
*/

params [["_overrideSight", ""]];

if (_overrideSight == "") exitWith {};

// Arma 3 addPrimaryWeaponItem automatically replaces existing items in the same slot.
player addPrimaryWeaponItem _overrideSight;
