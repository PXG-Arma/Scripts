#include "..\..\macros.hpp"

// Get selected items from UI
private _indexFaction = tvCurSel IDC_RESUPPLY_FACTION_TREE;
private _indexCamo = lbCurSel IDC_RESUPPLY_CAMO_LIST;
private _indexSupplies = lbCurSel IDC_RESUPPLY_SUPPLIES_LB;

if (count _indexFaction < 2) exitWith {};
if (_indexCamo == -1) exitWith {};
if (_indexSupplies == -1) exitWith {};

private _variantData = lbData [IDC_RESUPPLY_CAMO_LIST, _indexCamo];
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
private _crateCargoValue = 0;

// Get Crate Size from Registry (Fixes special items and standard crates)
private _registryData = PXG_Resupply_Crate_Registry getOrDefault [_selectedCategory, PXG_Resupply_Crate_Registry get "Default"];
_crateCargoValue = _registryData select 1;

{
	if ((_x select 0) == _selectedCategory) then {
		_foundContents = _x select 1;
	};
} forEach _suppliesArray;

// Update Cargo Space Indicator
private _displayResupply = findDisplay IDD_RESUPPLY;
private _spaceValueText = format ["<t color='#FFFFFF'>[ %1 ]</t>", _crateCargoValue];
(_displayResupply displayCtrl IDC_RESUPPLY_CONTENTS_SPACE_TEXT) ctrlSetStructuredText parseText _spaceValueText;

// Build display text
private _contentsText = "<t color='#FFFFFF'>";
{
	private _itemClassname = _x select 0;
	private _itemAmount = _x select 1;
	
	private _displayName = getText (configFile >> "CfgMagazines" >> _itemClassname >> "displayName");
	private _itemPicture = getText (configFile >> "CfgMagazines" >> _itemClassname >> "picture");
	
	if (_displayName == "") then {
		_displayName = getText (configFile >> "CfgWeapons" >> _itemClassname >> "displayName");
		_itemPicture = getText (configFile >> "CfgWeapons" >> _itemClassname >> "picture");
	};
	if (_displayName == "") then {
		_displayName = getText (configFile >> "CfgVehicles" >> _itemClassname >> "displayName");
		_itemPicture = getText (configFile >> "CfgVehicles" >> _itemClassname >> "picture");
	};
	if (_displayName == "") then {
		_displayName = _itemClassname; // Fallback
	};

	_contentsText = _contentsText + format ["<img image='%1' size='1.8' verticalAlign='middle' /> %2 x %3<br/>", _itemPicture, _itemAmount, _displayName];
} forEach _foundContents;
_contentsText = _contentsText + "</t>";

// Update UI text content
(_displayResupply displayCtrl IDC_RESUPPLY_CONTENTS_TEXT) ctrlSetStructuredText parseText _contentsText;
