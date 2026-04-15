#include "..\..\macros.hpp"

params["_crate"];

private _display = findDisplay IDD_RESUPPLY;
private _indexFaction = tvCurSel (_display displayCtrl IDC_RESUPPLY_FACTION_TREE);
private _camoList = _display displayCtrl IDC_RESUPPLY_CAMO_LIST;
private _indexCamo = lbCurSel _camoList;
private _indexSupplies = lbCurSel (_display displayCtrl IDC_RESUPPLY_SUPPLIES_LB);

if (count _indexFaction < 2) exitwith {};
if (_indexCamo == -1) exitwith {};
if (_indexSupplies == -1) exitWith {};

private _variantData = lbData [_camoList, _indexCamo];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _suppliesScriptPath = _basePath + "Supplies.sqf";

private _suppliesArray = call compile preprocessfile _suppliesScriptPath;
if (isNil "_suppliesArray") exitWith {};

// Find matching category
private _selectedCategoryName = lbData [IDC_RESUPPLY_SUPPLIES_LB, _indexSupplies];
private _suppliesContent = [];
private _suppliesName = "";

{
	if ((_x select 0) == _selectedCategoryName) then {
		_suppliesName = _x select 0;
		_suppliesContent = _x select 1;
	};
} forEach _suppliesArray;

if (count _suppliesContent == 0) exitWith {};

{
	private _supplyType = _x select 0;
	private _supplyAmount = _x select 1;
	
	if (_suppliesName == "Parachutes") then {
		_crate addBackpackCargoGlobal [_supplyType, _supplyAmount];
	} else {
		_crate addItemCargoGlobal [_supplyType, _supplyAmount];
	};
} forEach _suppliesContent;

_crate setVariable ["ace_cargo_customName", _suppliesName, true];
