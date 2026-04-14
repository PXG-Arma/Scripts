#include "..\..\macros.hpp"

// Get selected item from faction list
private _indexFaction = tvCurSel IDC_ARMORY_FACTION_TREE;
private _factionNodeIdx = [_indexFaction select 0];

if (count _indexFaction < 3) exitwith {};

// Feature Restoration: Save faction selection to memory
player setVariable ["PXG_Armory_Memory_Faction", _indexFaction];

private _variantData = tvData [IDC_ARMORY_FACTION_TREE, _indexFaction];
if (_variantData == "") exitWith {};

// Construct Path utilizing the GetFactionPath utility
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
private _loadoutsScriptPath = _basePath + "Loadoutlist.sqf";

// Get loadouts config for faction
if !(fileExists _loadoutsScriptPath) exitWith {
	tvClear IDC_ARMORY_LOADOUT_TREE;
};

private _loadoutsArray = call compile preprocessfile _loadoutsScriptPath;

if (isNil "_loadoutsArray") exitWith {
	tvClear IDC_ARMORY_LOADOUT_TREE;
	diag_log format ["[PXG Error] Could not load loadout list at: %1", _loadoutsScriptPath];
};

private _elementsArray = _loadoutsArray select 0;

// Clear loadout tree list 
tvClear IDC_ARMORY_LOADOUT_TREE;
{
	tvAdd [IDC_ARMORY_LOADOUT_TREE, [], _x];
	private _parentElement = _forEachIndex; 
	
	private _rolesArray = _loadoutsArray select 1;
	_rolesArray = _rolesArray select _parentElement;
	
	private _rolesDataArray = _loadoutsArray select 2;
	_rolesDataArray = _rolesDataArray select _parentElement;
	
	{	
		tvAdd [IDC_ARMORY_LOADOUT_TREE, [_parentElement], _x];
	} forEach _rolesArray;
	{
		tvSetData [IDC_ARMORY_LOADOUT_TREE, [_parentElement, _forEachIndex], _x];
	} forEach _rolesDataArray;

} forEach _elementsArray;

private _loadoutMemory = player getVariable ["PXG_Armory_Memory_Loadout", [-1,-1]];
if (_loadoutMemory select 0 != -1) then {tvSetCurSel [IDC_ARMORY_LOADOUT_TREE, _loadoutMemory]};
