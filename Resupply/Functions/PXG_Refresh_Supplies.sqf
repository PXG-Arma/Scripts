// Get selected item from faction list
_indexFaction = tvCurSel 451501;
_faction = [_indexFaction select 0];

// Prevents error about missing SQF if player selects faction rather than variant from tree list 
if (count _indexFaction < 2) exitwith {};

// Get faction name 
_faction = tvText [451501, _faction];
// Get variant name
_variant = tvText [451501, _indexFaction];

// Split variant name to get variant era 
_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;
_variantCamo = _variantArray #0;

// Path for supplies list 
_suppliesScriptPath = "Scripts\Factions\";
_suppliesScriptPath = _suppliesScriptPath + _faction + "\" + _variantEra + "\supplies_" + _variantCamo + ".sqf";

_suppliesFile = call compile preprocessfile _suppliesScriptPath;
_suppliesConfig = _suppliesFile select 0;     // What goes in each crate
_supplyCategories = _suppliesFile select 1;   // How they appear in the UI tree

tvClear 451502;

// Populate categories and their supply names from the faction file
{
	_categoryName = _x select 0;
	_categorySupplies = _x select 1;
	_catIdx = _forEachIndex;

	// Add category header as a parent node
	tvAdd [451502, [], _categoryName];

	// Add each supply name as a child node, storing the name as data
	{
		tvAdd [451502, [_catIdx], _x];
		tvSetData [451502, [_catIdx, _forEachIndex], _x];
	} forEach _categorySupplies;

} forEach _supplyCategories;

// Add special logistics items under their own auto-generated category
_logisticsCatIdx = count _supplyCategories;
tvAdd [451502, [], "Logistics"];
_logIdx = 0;

tvAdd [451502, [_logisticsCatIdx], "Spare Wheel"];
tvSetData [451502, [_logisticsCatIdx, _logIdx], "Wheel"];
_logIdx = _logIdx + 1;

tvAdd [451502, [_logisticsCatIdx], "Spare Track"];
tvSetData [451502, [_logisticsCatIdx, _logIdx], "Track"];
_logIdx = _logIdx + 1;

tvAdd [451502, [_logisticsCatIdx], "Slingloadable Crate (8)"];
tvSetData [451502, [_logisticsCatIdx, _logIdx], "Slingloadable Crate (8)"];
_logIdx = _logIdx + 1;

tvAdd [451502, [_logisticsCatIdx], "Vehicle Resupply"];
tvSetData [451502, [_logisticsCatIdx, _logIdx], "Vehicle Resupply"];
_logIdx = _logIdx + 1;

_calledFromFOB = player getVariable ["PXG_IsCalledFromFOB", false];
if (!_calledFromFOB) then {
	tvAdd [451502, [_logisticsCatIdx], "FOB Crate"];
	tvSetData [451502, [_logisticsCatIdx, _logIdx], "FOB"];
	_logIdx = _logIdx + 1;

	tvAdd [451502, [_logisticsCatIdx], "FARP Crate"];
	tvSetData [451502, [_logisticsCatIdx, _logIdx], "FARP"];
	_logIdx = _logIdx + 1;
};

// Restore memory (stored as [catIdx, supplyIdx] array)
_suppliesMemory = player getVariable ["PXG_Resupply_Memory_Supply", []];
if (count _suppliesMemory > 0) then { tvSetCurSel [451502, _suppliesMemory]; };
