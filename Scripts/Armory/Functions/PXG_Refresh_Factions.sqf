#include "..\..\macros.hpp"

// Get selected item from Side Listbox
private _selectedSide = lbCurSel IDC_ARMORY_SIDE;

private _targetSide = switch (_selectedSide) do {
	case 0: {"BLUFOR"};
	case 1: {"OPFOR"};
	case 2: {"INDEP"};
	default {""};
};

tvClear IDC_ARMORY_FACTION_TREE;
tvClear IDC_ARMORY_LOADOUT_TREE;

if (_targetSide == "") exitWith {};

private _registryPath = "Scripts\Factions\Factions_Registry.sqf";
private _masterRegistry = call compile preprocessFile _registryPath;

private _filteredRegistry = _masterRegistry select { (_x select 0) == _targetSide };

// 4-Level Data Structure: Faction -> SubFaction -> Era -> [Camos]
private _factionTree = createHashMap;

{
	private _sideName = _x select 0;
	private _factionName = _x select 1;
	private _subFactionName = _x select 2;
	private _eraName = _x select 3;
	private _camoName = _x select 4;
	
	if !(_factionName in _factionTree) then { _factionTree set [_factionName, createHashMap] };
	private _subFactionMap = _factionTree get _factionName;
	
	if !(_subFactionName in _subFactionMap) then { _subFactionMap set [_subFactionName, createHashMap] };
	private _eraMap = _subFactionMap get _subFactionName;
	
	if !(_eraName in _eraMap) then { _eraMap set [_eraName, []] };
	(_eraMap get _eraName) pushBack _camoName;
} forEach _filteredRegistry;

private _sortedFactions = keys _factionTree;
_sortedFactions sort true;

// Populate TreeView: Level 1 (Faction)
{
	private _factionName = _x;
	private _fIndex = tvAdd [IDC_ARMORY_FACTION_TREE, [], _factionName];
	
	private _subFactionMap = _factionTree get _factionName;
	private _sortedSubFactions = keys _subFactionMap;
	_sortedSubFactions sort true;
	
	// Populate TreeView: Level 2 (Sub-Faction)
	{
		private _subFactionName = _x;
		private _sfDisplayName = if (_subFactionName == "") then { "Base" } else { _subFactionName };
		private _sfIndex = tvAdd [IDC_ARMORY_FACTION_TREE, [_fIndex], _sfDisplayName];
		
		private _eraMap = _subFactionMap get _subFactionName;
		private _sortedEras = keys _eraMap;
		_sortedEras sort true;
		
		// Populate TreeView: Level 3 (Era)
		{
			private _eraName = _x;
			private _eDisplayName = if (_eraName == "") then { "General" } else { _eraName };
			private _eIndex = tvAdd [IDC_ARMORY_FACTION_TREE, [_fIndex, _sfIndex], _eDisplayName];
			
			private _camos = _eraMap get _eraName;
			_camos sort true;
			
			// Populate TreeView: Level 4 (Camo)
			{
				private _camoName = _x;
				private _metadata = [_targetSide, _factionName, _subFactionName, _eraName, _camoName];
				
				private _cIndex = tvAdd [IDC_ARMORY_FACTION_TREE, [_fIndex, _sfIndex, _eIndex], _camoName];
				tvSetData [IDC_ARMORY_FACTION_TREE, [_fIndex, _sfIndex, _eIndex, _cIndex], str _metadata];
			} forEach _camos;
		} forEach _sortedEras;
	} forEach _sortedSubFactions;
} forEach _sortedFactions;

private _factionMemory = player getVariable ["PXG_Armory_Memory_Faction", [-1,-1]];
if (_factionMemory select 0 != -1) then {tvSetCurSel [IDC_ARMORY_FACTION_TREE, _factionMemory]};
