#include "..\..\macros.hpp"

private _indexVehicle = tvCurSel IDC_MOTORPOOL_VEHICLE_LB;
if (count _indexVehicle < 2) exitWith {}; // Exit if category is selected

// Feature Restoration: Save vehicle selection to memory
player setVariable ["PXG_Motorpool_Memory_Vehicle", _indexVehicle];

private _indexData = tvData [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];
if (_indexData == "") exitWith {};

private _previewPicturePath = getText (configFile >> "CfgVehicles" >> _indexData >> "EditorPreview");

if (_previewPicturePath == "") then {
	_previewPicturePath = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";
};

ctrlSetText [IDC_MOTORPOOL_PREVIEW, _previewPicturePath];

// Cargo Preview 
private _indexValue = tvValue [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];

private _cargoCapacity = 0;
if (_indexValue == -1) then {
	_cargoCapacity = getNumber(configFile >> "CfgVehicles" >> _indexData >> "ace_cargo_space");
} else {
	_cargoCapacity = _indexValue; 
};

private _cargoText = "Cargo Capacity: " + str _cargoCapacity;
ctrlSetText [IDC_MOTORPOOL_CARGO_TEXT, _cargoText];

// Crew preview 
private _allSeatsCount = [_indexData, true] call BIS_fnc_crewCount;
private _crewSeatsCount = [_indexData, false] call BIS_fnc_crewCount;
private _cargoSeatsCount = _allSeatsCount - _crewSeatsCount;

private _crewText = "Crew: " + str _crewSeatsCount + " Passengers: " + str _cargoSeatsCount;
ctrlSetText [IDC_MOTORPOOL_SEATS_TEXT, _crewText];