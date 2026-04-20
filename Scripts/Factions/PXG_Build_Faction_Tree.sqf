/*
    PXG_Build_Faction_Tree.sqf
    ----------------------------
    Centralized utility to populate a TreeView control with factions from the master registry.
    
    Arguments:
    0: CONTROL or IDC (The TreeView control to populate)
    1: STRING _targetSide ("BLUFOR", "OPFOR", "INDEP")
    2: STRING _memoryVar (Player variable name to restore selection)
    
    Example:
    [IDC_ARMORY_FACTION_TREE, "BLUFOR", "PXG_Armory_Memory_Faction"] call compile preprocessFile "Scripts\Factions\PXG_Build_Faction_Tree.sqf";
*/

params ["_tree", ["_targetSide", ""], ["_memoryVar", ""]];

private _treeIDC = if (_tree isEqualType controlNull) then { ctrlIDC _tree } else { _tree };

tvClear _treeIDC;

if (_targetSide == "") exitWith {};

private _masterRegistry = missionNamespace getVariable ["PXG_MasterRegistry_Cache", []];
if (count _masterRegistry == 0) then {
    private _registryPath = "Scripts\Factions\Factions_Registry.sqf";
    if (fileExists _registryPath) then {
        private _data = call compile preprocessFile _registryPath;
        if (_data isEqualType [] && {count _data > 0}) then {
            _masterRegistry = _data;
            missionNamespace setVariable ["PXG_MasterRegistry_Cache", _masterRegistry];
        } else {
            diag_log format ["[PXG Warning] Master Registry at %1 is empty or malformed. Using empty tree.", _registryPath];
            _masterRegistry = [];
        };
    } else {
        diag_log "[PXG Error] Faction Registry not found!";
        _masterRegistry = [];
    };
};

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
	private _fIndex = tvAdd [_treeIDC, [], _factionName];
	
	private _subFactionMap = _factionTree get _factionName;
	private _sortedSubFactions = keys _subFactionMap;
	_sortedSubFactions sort true;
	
	// Populate TreeView: Level 2 (Sub-Faction / Branch)
	{
		private _subFactionName = _x;
		private _sfDisplayName = if (_subFactionName == "") then { "Base" } else { _subFactionName };
		private _sfFormattedName = _sfDisplayName;
		private _sfIndex = tvAdd [_treeIDC, [_fIndex], _sfFormattedName];
		private _metadata = [_targetSide, _factionName, _subFactionName];
		tvSetData [_treeIDC, [_fIndex, _sfIndex], str _metadata];
	} forEach _sortedSubFactions;
	
	tvExpand [_treeIDC, [_fIndex]];
} forEach _sortedFactions;

// Restore Memory
if (_memoryVar != "") then {
    private _factionMemory = player getVariable [_memoryVar, [-1]];
    if (count _factionMemory > 0 && { _factionMemory select 0 != -1 }) then { tvSetCurSel [_treeIDC, _factionMemory] };
};
