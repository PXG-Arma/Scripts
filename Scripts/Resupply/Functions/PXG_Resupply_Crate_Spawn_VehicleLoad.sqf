#include "..\..\macros.hpp"

params["_crate", "_vehicle"];

private _success = [_crate, _vehicle, true] call ace_cargo_fnc_loadItem;

if (_success) then {
	// Refresh the Interactive Side Panel if it exists
	if (!isNull (findDisplay IDD_RESUPPLY)) then {
		call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Refresh_Vehicle_Panel.sqf";
	};
} else {
	hint "Failed to load into vehicle. Ensure there is enough space.";
	// If loading failed, we should probably delete the temporary crate to not clutter the scene 
    // but in this modular design, the crate was spawned at [3000,3000,0] by the execute script.
    // If it fails to load, it stays in the 'void'.
};

_success
