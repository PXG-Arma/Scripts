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

private _registryPath = "Scripts\Factions\Factions_Registry.sqf";
if !(fileExists _registryPath) exitWith { diag_log "[PXG Error] Faction Registry not found!"; };
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
	private _fIndex = tvAdd [_treeIDC, [], _factionName];
	
	private _subFactionMap = _factionTree get _factionName;
	private _sortedSubFactions = keys _subFactionMap;
	_sortedSubFactions sort true;
	
	// Populate TreeView: Level 2 (Sub-Faction / Branch)
	{
		private _subFactionName = _x;
		private _sfDisplayName = if (_subFactionName == "") then { "Base" } else { _subFactionName };
		private _sfFormattedName = ">> " + _sfDisplayName + " <<";
		private _sfIndex = tvAdd [_treeIDC, [_fIndex], _sfFormattedName];
		
		private _eraMap = _subFactionMap get _subFactionName;
		private _sortedEras = keys _eraMap;
		_sortedEras sort true;
		
		// Populate TreeView: Level 3 (Variants with Era Suffix)
		{
			private _eraName = _x;
			private _eDisplayName = if (_eraName == "") then { "General" } else { _eraName };
			
			private _camos = _eraMap get _eraName;
			_camos sort true;
			
			{
				private _camoName = _x;
				private _metadata = [_targetSide, _factionName, _subFactionName, _eraName, _camoName];
				
				// Standardized padding for readability
				private _targetLength = 22;
				private _spacesCount = (_targetLength - (count _camoName)) max 1;
				private _padding = "";
				for "_i" from 1 to _spacesCount do { _padding = _padding + " " };
				
				private _variantDisplayName = _camoName + _padding + "[" + _eDisplayName + "]";
				
				private _vIndex = tvAdd [_treeIDC, [_fIndex, _sfIndex], _variantDisplayName];
				tvSetData [_treeIDC, [_fIndex, _sfIndex, _vIndex], str _metadata];
				
				// --- Camo Icon Extraction ---
				private _subFolderPart = if (_subFactionName != "") then { _subFactionName + "\" } else { "" };
				private _eraFolderPart = if (_eraName != "") then { _eraName + "\" } else { "" };
				private _uniformsPath = "Scripts\Factions\" + _targetSide + "\" + _factionName + "\" + _subFolderPart + _eraFolderPart + _camoName + "\Uniforms.sqf";
				
                if (fileExists _uniformsPath) then {
                    private _rawText = loadFile _uniformsPath;
                    private _uniformClass = "";
                    
                    // Find first classname after 'forceAddUniform' keyword
                    private _searchKey = "forceAddUniform ";
                    private _keyIdx = _rawText find _searchKey;
                    if (_keyIdx > -1) then {
                        private _afterKey = _rawText select [_keyIdx + count _searchKey];
                        if ((_afterKey select [0,1]) == """") then {
                            // Pattern A: forceAddUniform "classname"
                            private _inner = _afterKey select [1];
                            private _end = _inner find """";
                            if (_end > -1) then { _uniformClass = _inner select [0, _end]; };
                        } else {
                            // Pattern B: forceAddUniform selectRandom varName
                            private _beforeKey = _rawText select [0, _keyIdx];
                            private _scanPos = 0;
                            private _lastMatchPos = -1;
                            while {_scanPos < count _beforeKey} do {
                                private _hit = (_beforeKey select [_scanPos]) find "[""";
                                if (_hit == -1) exitWith {};
                                _lastMatchPos = _scanPos + _hit;
                                _scanPos = _lastMatchPos + 1;
                            };
                            if (_lastMatchPos > -1) then {
                                private _afterBQ = _beforeKey select [_lastMatchPos + 2];
                                private _endQ = _afterBQ find """";
                                if (_endQ > -1) then { _uniformClass = _afterBQ select [0, _endQ]; };
                            };
                        };
                    };
                    
                    if (_uniformClass != "" && {isClass (configFile >> "CfgWeapons" >> _uniformClass)}) then {
                        private _iconPath = getText (configFile >> "CfgWeapons" >> _uniformClass >> "picture");
                        if (_iconPath != "") then {
                            tvSetPicture [_treeIDC, [_fIndex, _sfIndex, _vIndex], _iconPath];
                        };
                    };
                };
				// --- End Camo Icon ---
			} forEach _camos;
		} forEach _sortedEras;
		
		tvExpand [_treeIDC, [_fIndex, _sfIndex]];
	} forEach _sortedSubFactions;
} forEach _sortedFactions;

// Restore Memory
if (_memoryVar != "") then {
    private _factionMemory = player getVariable [_memoryVar, [-1,-1]];
    if (_factionMemory select 0 != -1) then { tvSetCurSel [_treeIDC, _factionMemory] };
};
