#include "..\..\macros.hpp"

// Get selected items from UI
private _indexFaction = tvCurSel IDC_RESUPPLY_FACTION_TREE;
private _indexSupplies = lbCurSel IDC_RESUPPLY_SUPPLIES_LB;

if (count _indexFaction < 3) exitWith {};
if (_indexSupplies == -1) exitWith {};

private _variantData = tvData [IDC_RESUPPLY_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _suppliesScriptPath = _basePath + "Supplies.sqf";

// Get supplies data
private _suppliesArray = call compile preprocessfile _suppliesScriptPath;
if (isNil "_suppliesArray") exitWith {};

// Look up selected category
private _selectedCategory = lbData [IDC_RESUPPLY_SUPPLIES_LB, _indexSupplies];
private _foundContents = [];

{
	if ((_x select 0) == _selectedCategory) then {
		_foundContents = _x select 1;
	};
} forEach _suppliesArray;

// Build display text
private _contentsText = "<t size='0.8' color='#FFFFFF'>";
{
	private _itemClassname = _x select 0;
	private _itemAmount = _x select 1;
	
	private _displayName = getText (configFile >> "CfgMagazines" >> _itemClassname >> "displayName");
	if (_displayName == "") then {_displayName = getText (configFile >> "CfgWeapons" >> _itemClassname >> "displayName")};
	if (_displayName == "") then {_displayName = getText (configFile >> "CfgVehicles" >> _itemClassname >> "displayName")};
	if (_displayName == "") then {_displayName = _itemClassname}; // Fallback

	_contentsText = _contentsText + format ["%1 x %2<br/>", _itemAmount, _displayName];
} forEach _foundContents;
_contentsText = _contentsText + "</t>";

// Update UI text
private _displayResupply = findDisplay IDD_RESUPPLY;
(_displayResupply displayCtrl IDC_RESUPPLY_CONTENTS_TEXT) ctrlSetStructuredText parseText _contentsText;
