#include "..\..\macros.hpp"

params["_crate", "_vehicle"];

private _success = [_crate, _vehicle, true] call ace_cargo_fnc_loadItem;

if (_success) then {
	private _remainingSpace = _vehicle getVariable ["ace_cargo_space", 0];
	private _maxSpace = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ace_cargo_space");
    private _loadedItems = _vehicle getVariable ["ace_cargo_loaded", []];
	
	private _itemsList = "";
	{
		private _itemName = "";
		if (typeName _x == "STRING") then {
			_itemName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			if (_itemName == "") then {_itemName = _x};
		} else {
			_itemName = _x getVariable ["ace_cargo_customName", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
			if (_itemName == "") then {_itemName = typeOf _x};
		};
		_itemsList = _itemsList + format ["<br/>- %1", _itemName];
	} forEach _loadedItems;

	private _status = if (_remainingSpace <= 0) then {"<t color='#ff0000'>FULL</t>"} else {format ["%1 units left", _remainingSpace]};

	// Refresh the Interactive Side Panel if it exists
	if (!isNull (findDisplay IDD_RESUPPLY)) then {
		call compile preprocessFile "Scripts\Resupply\Functions\PXG_Resupply_Refresh_Vehicle_Panel.sqf";
	};
} else {
	hint "Failed to load into vehicle. Ensure there is enough space.";
	// If loading failed, we should probably delete the temporary crate to not clutter the scene 
    // but in this modular design, the crate was spawned at [3000,3000,0] by the execute script.
    // If it fails to load, it stays in the 'void'.
};

_success
