#include "..\..\macros.hpp"

// Get selected item from faction list
private _indexFaction = tvCurSel IDC_RESUPPLY_FACTION_TREE;
if (count _indexFaction < 3) exitwith {};

private _variantData = tvData [IDC_RESUPPLY_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _suppliesScriptPath = _basePath + "Supplies.sqf";

if !(fileExists _suppliesScriptPath) exitWith {
	lbClear IDC_RESUPPLY_SUPPLIES_LB;
};

private _suppliesArray = call compile preprocessfile _suppliesScriptPath;

if (isNil "_suppliesArray") exitWith {
	lbClear IDC_RESUPPLY_SUPPLIES_LB;
	diag_log format ["[PXG Error] Could not load supply list at: %1", _suppliesScriptPath];
};

lbClear IDC_RESUPPLY_SUPPLIES_LB;

{
    private _suppliesText = _suppliesArray select _forEachIndex select 0;
	private _supplyData = lbAdd [IDC_RESUPPLY_SUPPLIES_LB, _suppliesText];
	lbSetData [IDC_RESUPPLY_SUPPLIES_LB, _supplyData, _suppliesText];
} forEach _suppliesArray;

private _wheelSupply = lbAdd [IDC_RESUPPLY_SUPPLIES_LB, "Spare Wheel"];
lbSetData [IDC_RESUPPLY_SUPPLIES_LB, _wheelSupply, "Wheel"];

private _trackSupply = lbAdd [IDC_RESUPPLY_SUPPLIES_LB, "Spare Track"];
lbsetData [IDC_RESUPPLY_SUPPLIES_LB, _trackSupply, "Track"];

private _calledFromFOB = player getVariable ["PXG_IsCalledFromFOB", false];
if(!_calledFromFOB) then
{
	private _fobCrate = lbAdd [IDC_RESUPPLY_SUPPLIES_LB, "FOB Crate"];
	lbSetData [IDC_RESUPPLY_SUPPLIES_LB, _fobCrate, "FOB"];

	private _farpCrate = lbadd [IDC_RESUPPLY_SUPPLIES_LB, "FARP Crate"];
	lbSetData [IDC_RESUPPLY_SUPPLIES_LB, _farpCrate, "FARP"];

	private _SlingCrate = lbadd [IDC_RESUPPLY_SUPPLIES_LB, "Slingloadable Crate (8)"];
	lbSetData [IDC_RESUPPLY_SUPPLIES_LB, _SlingCrate, "Slingloadable Crate (8)"];
};

private _suppliesMemory = player getVariable ["PXG_Resupply_Memory_Supply", -1];
if (_suppliesMemory != -1) then {lbSetCurSel [IDC_RESUPPLY_SUPPLIES_LB, _suppliesMemory];};
