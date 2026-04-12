// Get selected item from Side Listbox
_selectedSide = lbCurSel 451504;

_targetSide = switch (_selectedSide) do {
	case 0: {"BLUFOR"};
	case 1: {"OPFOR"};
	case 2: {"INDEP"};
	default {""};
};

tvClear 451501;
tvClear 451502;

if (_targetSide == "") exitWith {};

_registryPath = "Scripts\Factions\Factions_Registry.sqf";
_masterRegistry = call compile preprocessFile _registryPath;

_filteredRegistry = _masterRegistry select { (_x select 0) == _targetSide };

// 3-Level Data Structure: Faction -> Era -> [Camos]
_factionTree = createHashMap;

{
	_sideName = _x select 0;
	_factionName = _x select 1;
	_eraName = _x select 2;
	_camoName = _x select 3;
	
	if !(_factionName in _factionTree) then { _factionTree set [_factionName, createHashMap] };
	_eraMap = _factionTree get _factionName;
	
	if !(_eraName in _eraMap) then { _eraMap set [_eraName, []] };
	(_eraMap get _eraName) pushBack _camoName;
} forEach _filteredRegistry;

_sortedFactions = keys _factionTree;
_sortedFactions sort true;

// Populate TreeView: Level 1 (Faction)
{
	_factionName = _x;
	_fIndex = tvAdd [451501, [], _factionName];
	
	_eraMap = _factionTree get _factionName;
	_sortedEras = keys _eraMap;
	_sortedEras sort true;
	
	// Populate TreeView: Level 2 (Era)
	{
		_eraName = _x;
		_eDisplayName = if (_eraName == "") then { "General" } else { _eraName };
		_eIndex = tvAdd [451501, [_fIndex], _eDisplayName];
		
		_camos = _eraMap get _eraName;
		_camos sort true;
		
		// Populate TreeView: Level 3 (Camo)
		{
			_camoName = _x;
			_metadata = [_targetSide, _factionName, _eraName, _camoName];
			
			_cIndex = tvAdd [451501, [_fIndex, _eIndex], _camoName];
			tvSetData [451501, [_fIndex, _eIndex, _cIndex], str _metadata];
		} forEach _camos;
	} forEach _sortedEras;
} forEach _sortedFactions;

_factionMemory = player getVariable ["PXG_Resupply_Memory_Faction", [-1,-1]];
if (_factionMemory select 0 != -1) then {tvSetCurSel [451501, _factionMemory]};