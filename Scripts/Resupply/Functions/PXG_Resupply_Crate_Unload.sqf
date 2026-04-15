#include "..\..\macros.hpp"

#define IDC_PANEL_LIST 451704

private _display = findDisplay IDD_RESUPPLY;
private _vehicle = _display getVariable ["PXG_Resupply_Current_Vehicle", objNull];
if (isNull _vehicle) exitWith { hint "No vehicle selected." };

private _selIdx = lbCurSel IDC_PANEL_LIST;
if (_selIdx == -1) exitWith { hint "Please select an item to delete." };

private _loadedItems = _vehicle getVariable ["ace_cargo_loaded", []];
if (count _loadedItems == 0) exitWith { hint "Vehicle is empty." };

private _itemToDelete = _loadedItems select _selIdx;

if (typeName _itemToDelete == "STRING") then {
	// If it's a string, we need to use ACE's removeCargo function or adjust ace_cargo_loaded manually
    // Actually, in ACE 3, if it's a string, it means it's a 'serialized' item.
    // Use the official removal function if available, or modify the variable.
    [_vehicle, _itemToDelete] call ace_cargo_fnc_removeCargo; 
} else {
	// If it's an object, we can just delete it and ACE handles the cleanup of references.
    // However, it's safer to use the unload function first or clear references.
    [_itemToDelete, _vehicle] call ace_cargo_fnc_unloadItem;
    deleteVehicle _itemToDelete;
};

hint "Cargo deleted and returned to depot.";

// Refresh the panel
call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Refresh_Vehicle_Panel.sqf";
