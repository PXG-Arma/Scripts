// Get metadata from tvData
_indexFaction = tvCurSel 461501;
_variantData = tvData [461501, _indexFaction];
if (_variantData == "") exitWith {};

_metadata = call compile _variantData;
_sideFolder = _metadata select 0;
_faction = _metadata select 1;
_variantEra = _metadata select 2;
_variantCamo = _metadata select 3;

// ... (Existing Spawn Logic) ...
_indexSpawn = lbCurSel 461500;
_indexVehicle = tvCurSel 461502;
if (_indexSpawn == -1 || count _indexVehicle == 0) exitWith {};

_vehicleType = tvData [461502, _indexVehicle];
_spawnPosition = synchronizedObjects (player getVariable "PXG_Vehicle_Master") select _indexSpawn;

// (Check for vehicles in radius logic omitted for brevity, assuming same)
// ...

_spawnCoords = getPosATL _spawnPosition;
private _vehicle = createVehicle[_vehicleType, _spawnCoords, [], 0, "CAN_COLLIDE"];
_vehicle setDir getDir _spawnPosition;

// Path for recolour script (Handles empty era correctly)
_eraPath = ""; if (_variantEra != "") then { _eraPath = _variantEra + "\" };
_recolourScriptPath = "Scripts\Factions\" + _sideFolder + "\" + _faction + "\" + _eraPath + _variantCamo + "\Vehicles_recolour.sqf";
[_vehicle, _vehicleType] call compile preprocessfile _recolourScriptPath;