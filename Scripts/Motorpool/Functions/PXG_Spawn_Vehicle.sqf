#include "..\..\macros.hpp"

// Get metadata from tvData
private _indexFaction = tvCurSel IDC_MOTORPOOL_FACTION_TREE;
private _variantData = tvData [IDC_MOTORPOOL_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

private _metadata = call compile _variantData;

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";

// Get indices
private _indexSpawn = lbCurSel IDC_MOTORPOOL_SPAWNPOINTS;
private _indexVehicle = tvCurSel IDC_MOTORPOOL_VEHICLE_LB;
if (_indexSpawn == -1 || count _indexVehicle == 0) exitWith {};

private _vehicleType = tvData [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];
private _spawnPosition = synchronizedObjects (player getVariable "PXG_Vehicle_Master") select _indexSpawn;

private _spawnCoords = getPosATL _spawnPosition;

// Prevent race condition (spamming spawn)
if (player getVariable ["PXG_Motorpool_Spawning", false]) exitWith { hint "Spawning in progress..." };
player setVariable ["PXG_Motorpool_Spawning", true];

// Restore debouncing after a short delay (Increased to 2s to prevent rapid spam and mod init race conditions)
[] spawn { sleep 0.5; player setVariable ["PXG_Motorpool_Spawning", false] };

// Feature Restoration: Auto-despawn existing vehicle at pad to prevent clipping/explosions
private _existingVehicles = nearestObjects [_spawnCoords, ["LandVehicle", "Air", "Ship"], 5];
{ 
	_x setPos [0,0,0]; // Move instantly to avoid collision race condition
	[_x] spawn { sleep 6; deleteVehicle (_this select 0) }; // Delay deletion by 6s to silence 3CB Warrior init errors (modfn_init_EH.sqf sleeps 5s before texture check)
} forEach _existingVehicles;

private _vehicle = createVehicle[_vehicleType, _spawnCoords, [], 0, "CAN_COLLIDE"];
_vehicle setDir getDir _spawnPosition;

// Path for recolour script (Handles empty era correctly)
private _recolourScriptPath = _basePath + "Vehicles_recolour.sqf";
if (fileExists _recolourScriptPath) then {
	[_vehicle, _vehicleType] call compile preprocessfile _recolourScriptPath;
};