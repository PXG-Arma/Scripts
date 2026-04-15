#include "..\..\macros.hpp"

// 1. Validate UI selections
private _indexSpawn = lbCurSel IDC_RESUPPLY_SPAWNPOINTS;
private _indexSide = lbCurSel IDC_RESUPPLY_SIDE;
private _indexFaction = tvCurSel IDC_RESUPPLY_FACTION_TREE;
private _indexSupply = lbCurSel IDC_RESUPPLY_SUPPLIES_LB;

private _display = findDisplay IDD_RESUPPLY;
if (_indexSide == -1) exitWith { hint "Please select side."};
if (_indexSupply == -1) exitWith { hint "Please select supply crate."};
if (_indexSpawn == -1) exitWith {hint "Please select spawn point."};

// 2. Lookup Registry Data
private _supplyName = lbData [IDC_RESUPPLY_SUPPLIES_LB, _indexSupply];

// Generic items do not require faction/camo selection
private _isGeneric = _supplyName in ["FOB", "FARP", "Wheel", "Track", "Slingloadable Crate (8)"];
if (!_isGeneric) then {
	if (count _indexFaction < 2) exitWith { hint "Please select branch."};
	if (lbCurSel (_display displayCtrl IDC_RESUPPLY_CAMO_LIST) == -1) exitWith { hint "Please select faction variant."};
};
private _registryData = PXG_Resupply_Crate_Registry getOrDefault [_supplyName, PXG_Resupply_Crate_Registry get "Default"];
_registryData params ["_classname", "_cargoSize", "_specialScript"];

// 3. Selection Memory
player setVariable ["PXG_Resupply_Memory_Side", _indexSide];
player setVariable ["PXG_Resupply_Memory_Faction", _indexFaction];
player setVariable ["PXG_Resupply_Memory_Supply", _indexSupply];
player setVariable ["PXG_Resupply_Memory_Spawn", _indexSpawn];

// 4. Pad Detection
private _spawnMaster = player getVariable ["PXG_Resupply_Master", objNull];
if (isNull _spawnMaster) exitWith {hint "Resupply master object not found."};
private _spawnLocationObj = (synchronizedObjects _spawnMaster) select _indexSpawn;
private _spawnPos = getPosATL _spawnLocationObj;
private _spawnDir = getDir _spawnLocationObj;

// Check for vehicles (優先的に車輌へのロード)
private _nearVehicles = nearestObjects [_spawnPos, ["LandVehicle", "Air", "Ship", "Slingload_base_F"], 5];

if (count _nearVehicles > 0) then {
	// LOAD INTO VEHICLE
	private _vehicle = _nearVehicles select 0;
	
	// Check space
	private _currentSpace = _vehicle getVariable ["ace_cargo_space", 0];
	if (_currentSpace >= _cargoSize) then {
		// Spawn execute (temporary location)
		private _crate = [_classname, _cargoSize, [3000, 3000, 100], _spawnDir, _specialScript] call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Crate_Spawn_Execute.sqf";
		
		// Load into vehicle
		[_crate, _vehicle] call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Crate_Spawn_VehicleLoad.sqf";
	} else {
		hint format ["Not enough space in %1. (Needs %2, has %3 available)", getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"), _cargoSize, _currentSpace];
	};
} else {
	// SPAWN ON GROUND (with Alternating Displacement)
	// Detect existing crates near the pad to determine offset
	private _existingCrates = nearestObjects [_spawnPos, ["Reammobox_F", "ACE_Wheel", "ACE_Track"], 3];
	private _crateCount = count _existingCrates;
	
	// Calculate Offset Pattern: 0, -1, 1, -2, 2, -3, 3...
	private _displacementMultiplier = 0;
	if (_crateCount > 0) then {
		if (_crateCount % 2 == 0) then {
			_displacementMultiplier = (_crateCount / 2); // Positive offset
		} else {
			_displacementMultiplier = -((_crateCount + 1) / 2); // Negative offset
		};
	};
	
	private _offsetDistance = _displacementMultiplier * 1.0; // 1.0m per box as requested
	
	// Calculate Final Position (Offset to the side of the pad's direction)
	// Angle: 90 degrees relative to pad direction
	private _finalPos = [_spawnPos, 90, _offsetDistance, _spawnDir] call compile preprocessFile "Scripts\Misc\PXG_Calculate_Position_AngleOffset.sqf";

	// Execute Spawn
	[_classname, _cargoSize, _finalPos, _spawnDir, _specialScript] call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Crate_Spawn_Execute.sqf";
	
	if (_crateCount == 0) then {
		hint "Crate spawned on pad.";
	} else {
		hint format ["Crate spawned next to existing supplies (%1 offset).", _offsetDistance];
	};
};
