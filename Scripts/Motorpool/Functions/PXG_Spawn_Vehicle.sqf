#include "..\..\macros.hpp"

// Get metadata from Camo ListBox
private _indexCamo = lbCurSel IDC_MOTORPOOL_CAMO_LIST;
private _variantData = lbData [IDC_MOTORPOOL_CAMO_LIST, _indexCamo];
if (_variantData == "") exitWith { hint "Please select faction variant." };

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

// Restore debouncing after a short delay
[] spawn { sleep 0.5; player setVariable ["PXG_Motorpool_Spawning", false] };

// Feature Restoration: Auto-despawn existing vehicle at pad
private _existingVehicles = nearestObjects [_spawnCoords, ["LandVehicle", "Air", "Ship"], 5];
{ 
	_x setPos [0,0,0]; 
	[_x] spawn { sleep 6; deleteVehicle (_this select 0) }; 
} forEach _existingVehicles;

// Cleanup preview vehicle if it exists at this location
private _previewVic = missionNamespace getVariable ["PXG_Motorpool_Preview_Vic", objNull];
if (!isNull _previewVic) then { 
	deleteVehicle _previewVic; 
	missionNamespace setVariable ["PXG_Motorpool_Preview_Vic", objNull]; 
	sleep 0.1; // Stabilization delay to prevent networking race conditions
};

private _vehicle = createVehicle[_vehicleType, _spawnCoords, [], 0, "CAN_COLLIDE"];
_vehicle setDir getDir _spawnPosition;

if (fileExists (_basePath + "Faction_Core.sqf")) then {
	private _factionData = call compile preprocessFile (_basePath + "Faction_Core.sqf");
	private _recolourCodeStr = _factionData getOrDefault ["recolour_script", ""];
	if (_recolourCodeStr != "") then {
		[_vehicle, _vehicleType] call compile _recolourCodeStr;
	};
} else {
	private _recolourScriptPath = _basePath + "Vehicles_recolour.sqf";
	if (fileExists _recolourScriptPath) then {
		[_vehicle, _vehicleType] call compile preprocessfile _recolourScriptPath;
	};
};

// --- PYLON PERSISTENCE ---
player setVariable ["PXG_Motorpool_Active_Vehicle", _vehicle];

// Apply custom pylons configured during preview
private _customPylons = player getVariable ["PXG_Motorpool_CustomPylons", []];
{
	_x params ["_pylonIdx", "_mag"];
	_vehicle setPylonLoadout [_pylonIdx, _mag, true];
} forEach _customPylons;

// Refresh Pylon Manager UI for the live vehicle
[_vehicle] call compile preprocessFile "Scripts\Motorpool\Functions\PXG_Motorpool_Pylon_Update_Panel.sqf";