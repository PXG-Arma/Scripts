#include "..\..\macros.hpp"

// Get selected item from faction tree and supply list
private _indexFaction = tvCurSel IDC_RESUPPLY_FACTION_TREE;
private _indexSupplies = lbCurSel IDC_RESUPPLY_SUPPLIES_LB;
if (count _indexFaction < 4) exitwith {};

private _variantData = tvData [IDC_RESUPPLY_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _suppliesScriptPath = _basePath + "Supplies.sqf";

if !(fileExists _suppliesScriptPath) exitWith {};

private _suppliesContents = [];
private _crateContentsText = "";
private _suppliesArray = call compile preprocessfile _suppliesScriptPath;

if (isNil "_suppliesArray") exitWith {};

switch (lbData [IDC_RESUPPLY_SUPPLIES_LB, _indexSupplies]) do
{
    case "FOB";
	case "FARP";
	case "Slingloadable Crate (8)";
	case "Wheel";
	case "Track": {_suppliesContents = [[],[]]};
	default {
		_suppliesContents = _suppliesArray select _indexSupplies select 1;
		{
			private _suppliesName = _x select 0;
			private _suppliesCount = _x select 1;
			_crateContentsText = _crateContentsText + _suppliesName + ": " + str _suppliesCount + "\n"; 
		} forEach _suppliesContents;
	};
};

lbClear IDC_RESUPPLY_CONTENTS_TEXT;
ctrlSetText [IDC_RESUPPLY_CONTENTS_TEXT, _crateContentsText];
