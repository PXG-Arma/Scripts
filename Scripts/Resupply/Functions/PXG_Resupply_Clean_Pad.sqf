#include "..\..\macros.hpp"

private _indexSpawn = lbCurSel IDC_RESUPPLY_SPAWNPOINTS;
if (_indexSpawn == -1) exitWith {hint "Please select a spawn point to clean."};

private _spawnPosition = synchronizedObjects (player getVariable ["PXG_Resupply_Master", objNull]) select _indexSpawn;
if (isNull _spawnPosition) exitWith {hint "Invalid spawn point."};

private _nearObjects = nearestObjects [getPosATL _spawnPosition, ["Reammobox_F", "Thing", "ThingX", "ACE_Wheel", "ACE_Track"], 5];

if (count _nearObjects == 0) exitWith {hint "Spawn pad is already clean."};

private _count = 0;
{
	if (!(_x isKindOf "LandVehicle") && !(_x isKindOf "Air") && !(_x isKindOf "Ship")) then {
		deleteVehicle _x;
		_count = _count + 1;
	};
} forEach _nearObjects;

hint format ["Cleaned %1 object(s) from pad.", _count];
