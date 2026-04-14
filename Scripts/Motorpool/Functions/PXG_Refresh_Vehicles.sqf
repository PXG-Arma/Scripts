#include "..\..\macros.hpp"

// Get selected item from faction list
private _indexFaction = tvCurSel IDC_MOTORPOOL_FACTION_TREE;
if (count _indexFaction < 3) exitwith {};

// Feature Restoration: Save faction selection to memory 
player setVariable ["PXG_Motorpool_Memory_Faction", _indexFaction];

private _variantData = tvData [IDC_MOTORPOOL_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _vehiclesScriptPath = _basePath + "Vehicles.sqf";

if !(fileExists _vehiclesScriptPath) exitWith {
	tvClear IDC_MOTORPOOL_VEHICLE_LB;
};

private _vehiclesArray = call compile preprocessfile _vehiclesScriptPath;

if (isNil "_vehiclesArray") exitWith {
	tvClear IDC_MOTORPOOL_VEHICLE_LB;
	diag_log format ["[PXG Error] Could not load vehicle list at: %1", _vehiclesScriptPath];
};

// Populate TreeView using nested loop for categories
// Clear dependent lists
tvClear IDC_MOTORPOOL_VEHICLE_LB;

{
	private _categoryName = _x select 0;
	private _categoryVehicles = _x select 1;
	
	// Add Category Node
	private _catIdx = tvAdd [IDC_MOTORPOOL_VEHICLE_LB, [], _categoryName];
	
	// Add Vehicles to Category
	{
		private _vehicleClass = _x select 0;
		private _vehicleCargo = _x select 1;
		
		private _displayName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
		if (_displayName == "") then { _displayName = _vehicleClass }; // Fallback to classname
		
		private _vehIdx = tvAdd [IDC_MOTORPOOL_VEHICLE_LB, [_catIdx], _displayName];
		tvSetData [IDC_MOTORPOOL_VEHICLE_LB, [_catIdx, _vehIdx], _vehicleClass];
		tvSetValue [IDC_MOTORPOOL_VEHICLE_LB, [_catIdx, _vehIdx], _vehicleCargo];
	} forEach _categoryVehicles;
	
} forEach _vehiclesArray;

private _vehicleMemory = player getVariable ["PXG_Motorpool_Memory_Vehicle", []];
if (count _vehicleMemory > 0) then { tvSetCurSel [IDC_MOTORPOOL_VEHICLE_LB, _vehicleMemory]; };