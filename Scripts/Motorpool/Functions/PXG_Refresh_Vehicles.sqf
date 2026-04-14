#include "..\..\macros.hpp"

// Get selected item from faction list
private _indexFaction = tvCurSel IDC_MOTORPOOL_FACTION_TREE;
if (count _indexFaction < 3) exitwith {};

private _variantData = tvData [IDC_MOTORPOOL_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _vehiclesScriptPath = _basePath + "Vehicles.sqf";

if !(fileExists _vehiclesScriptPath) exitWith {
	lbClear IDC_MOTORPOOL_VEHICLE_LB;
};

private _vehiclesArray = call compile preprocessfile _vehiclesScriptPath;

if (isNil "_vehiclesArray") exitWith {
	lbClear IDC_MOTORPOOL_VEHICLE_LB;
	diag_log format ["[PXG Error] Could not load vehicle list at: %1", _vehiclesScriptPath];
};

lbClear IDC_MOTORPOOL_VEHICLE_LB;

{
	private _vehicleText = _vehiclesArray select _forEachIndex select 0;
	private _vehicleData = _vehiclesArray select _forEachIndex select 1;
	private _vehicleCargo = _vehiclesArray select _forEachIndex select 2;
	
	private _vehicleLB = lbAdd [IDC_MOTORPOOL_VEHICLE_LB, _vehicleText];
	lbSetData [IDC_MOTORPOOL_VEHICLE_LB, _vehicleLB, _vehicleData];
	lbSetValue [IDC_MOTORPOOL_VEHICLE_LB, _vehicleLB, _vehicleCargo];
} forEach _vehiclesArray;

private _vehicleMemory = player getVariable ["PXG_Motorpool_Memory_Vehicle", -1];
if (_vehicleMemory != -1) then {lbSetCurSel [IDC_MOTORPOOL_VEHICLE_LB, _vehicleMemory];};