#include "..\..\macros.hpp"

params["_classname", "_cargoSize", "_pos", "_dir", "_specialScript"];

// Create object
private _crate = createVehicle [_classname, [3000, 3000, 0], [], 0, "CAN_COLLIDE"];
_crate setDir _dir;
_crate setPosATL _pos;

// Apply Physics Safeguards
_crate addEventHandler ["HandleDamage", {0}];
_crate allowDamage false;
_crate setDamage 0;

// Clear default contents
clearItemCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

// Apply ACE Properties
[_crate, _cargoSize] call ace_cargo_fnc_setSize;
[_crate, true, [0, 1, 1], 0, true] remoteExec ["ace_dragging_fnc_setCarryable"];

// Handle special types
if (_classname == "B_CargoNet_01_ammo_F") then {
	[_crate, 8] call ace_cargo_fnc_setSpace;
};

// Execute special scripts (FOB/FARP)
if (_specialScript != "") then {
	[[_crate], _specialScript] remoteExec ["execVM", 0, _crate];
} else {
	// Normal crate fill
	[_crate] call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Crate_Fill.sqf";
};

_crate
