_indexSpawn = lbCurSel 451500;
_indexSide = lbCurSel 451504;
_indexFaction = tvCurSel 451501;
_indexSupply = lbCurSel 451502;
_supplyData = lbData [451502, _indexSupply];

if (_indexSide == -1) exitWith { hint "Please select side."};
if (count _indexFaction == 0) exitWith { hint "Please select faction."};
if (count _indexFaction == 1) exitWith { hint "Please select faction variant."};
if (_indexSupply == -1) exitWith { hint "Please select supply crate."};
if (_indexSpawn == -1) exitWith {hint "Please select spawn point."};

_spawnPosition = synchronizedObjects item_spawn_master select _indexSpawn;

player setVariable ["PXG_Resupply_Memory_Side", _indexSide];
player setVariable ["PXG_Resupply_Memory_Faction", _indexFaction];
player setVariable ["PXG_Resupply_Memory_Supply", _indexSupply];
player setVariable ["PXG_Resupply_Memory_Spawn", _indexSpawn];

//Check for vehicles in radius of spawnpoint
private _nearVehicles = nearestObjects [getPos _spawnPosition, ["LandVehicle", "Air", "Ship", "Slingload_base_F"], 5];
_nearVehicles = _nearVehicles + nearestObjects [getPos _spawnPosition, ["Reammobox_F"], 1];

if (count _nearVehicles > 0) then {
	{
		//Check if vehicle is empty
		private _playerCrew = ({ isPlayer _x } count (crew _x));
	
		if (_playerCrew == 0) then {
			
		};	
	}
	forEach _nearVehicles;
	
} else {

	switch(_supplyData) do {
	
	case "FOB": { 
		private _crate = createVehicle["ACE_Box_Chemlights", getPosATL _spawnPosition, [], 0, "CAN_COLLIDE"];
		_crate setDir getDir _spawnPosition;
		
		//Remove default contents from crate
		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;
	
		[[_crate],"Scripts\Resupply\Functions\PXG_Add_FOB_Option.sqf"] remoteExec ["execVM", 0, _crate];
		_crate setVariable ["ace_cargo_customName", "FOB", true];
		[_crate, 8] call ace_cargo_fnc_setSize;
		[_crate, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
		
		}; 
		
	case "Wheel": {
		private _wheel = createVehicle["ACE_Wheel", getPosATL _spawnPosition, [], 0, "CAN_COLLIDE"];
		_wheel setDir getDir _spawnPosition;
	};
	case "Track": {
		private _track = createVehicle["ACE_Track", getPosATL _spawnPosition, [], 0, "CAN_COLLIDE"];
		_track setDir getDir _spawnPosition;
	};
	
	
	  default {
		private _crate = createVehicle["Box_NATO_Ammo_F", getPosATL _spawnPosition, [], 0, "CAN_COLLIDE"];
		_crate setDir getDir _spawnPosition;
		
		//Remove default contents from crate
		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		[_crate] call compile preprocessFile "Scripts\Resupply\Functions\PXG_Crate_Fill.sqf";
		[_crate, 1] call ace_cargo_fnc_setSize;
		[_crate, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
		};
	};
};