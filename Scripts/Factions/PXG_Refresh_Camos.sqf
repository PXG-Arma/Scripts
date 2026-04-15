#include "..\macros.hpp"

/*
    PXG_Refresh_Camos.sqf
    ----------------------------
    Arguments:
    0: CONTROL or IDC (TreeView)
    1: IDC (ListBox for Camos)
    2: STRING _nextRefreshScript (Script to call when camo is selected)
    3: STRING _memoryVar (Optional)
*/

params ["_tree", "_listIDC", ["_nextRefreshScript", ""], ["_memoryVar", ""]];

private _treeIDC = if (_tree isEqualType controlNull) then { ctrlIDC _tree } else { _tree };
private _indexFaction = tvCurSel _treeIDC;

if (count _indexFaction < 2) exitWith { lbClear _listIDC; };

private _branchData = tvData [_treeIDC, _indexFaction];
if (_branchData == "") exitWith { lbClear _listIDC; };

private _metadata = call compile _branchData;
_metadata params ["_targetSide", "_factionName", "_subFactionName"];

// Fetch variants from Registry
private _registryPath = "Scripts\Factions\Factions_Registry.sqf";
private _masterRegistry = call compile preprocessFile _registryPath;

private _variants = _masterRegistry select { 
    (_x select 0) == _targetSide && 
    (_x select 1) == _factionName && 
    (_x select 2) == _subFactionName 
};

lbClear _listIDC;

{
    _x params ["_side", "_faction", "_sub", "_eraName", "_camoName"];
    
    private _eDisplayName = if (_eraName == "") then { "General" } else { _eraName };
    
    // Standardized padding for 3-column look in a single ListBox row
    // Using a simple format that aligns reasonably well
    private _targetLength = 22;
    private _spacesCount = (_targetLength - (count _camoName)) max 1;
    private _padding = "";
    for "_i" from 1 to _spacesCount do { _padding = _padding + " " };
    
    private _displayName = _camoName + _padding + "[" + _eDisplayName + "]";
    private _lIndex = lbAdd [_listIDC, _displayName];
    
    // Store full 5-part metadata
    lbSetData [_listIDC, _lIndex, str _x];
    
    // --- Camo Icon Extraction ---
    private _subFolderPart = if (_sub != "") then { _sub + "\" } else { "" };
    private _eraFolderPart = if (_eraName != "") then { _eraName + "\" } else { "" };
    private _uniformsPath = "Scripts\Factions\" + _side + "\" + _faction + "\" + _subFolderPart + _eraFolderPart + _camoName + "\Uniforms.sqf";
    
    if (fileExists _uniformsPath) then {
        private _rawText = loadFile _uniformsPath;
        private _uniformClass = "";
        private _searchKey = "forceAddUniform ";
        private _keyIdx = _rawText find _searchKey;
        if (_keyIdx > -1) then {
            private _afterKey = _rawText select [_keyIdx + count _searchKey];
            if ((_afterKey select [0,1]) == """") then {
                private _inner = _afterKey select [1];
                private _end = _inner find """";
                if (_end > -1) then { _uniformClass = _inner select [0, _end]; };
            } else {
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
                lbSetPicture [_listIDC, _lIndex, _iconPath];
                // Force full color on selection
                lbSetPictureColorSelected [_listIDC, _lIndex, [1,1,1,1]];
            };
        };
    };
} forEach _variants;

// Auto-select if only one
if (lbSize _listIDC == 1) then {
    lbSetCurSel [_listIDC, 0];
    // Trigger next refresh automatically
    if (_nextRefreshScript != "") then {
        call compile preprocessFile _nextRefreshScript;
    };
} else {
    // Restore Memory if multiple
    if (_memoryVar != "") then {
        private _camoMemory = player getVariable [_memoryVar, -1];
        if (_camoMemory != -1 && _camoMemory < lbSize _listIDC) then {
            lbSetCurSel [_listIDC, _camoMemory];
            if (_nextRefreshScript != "") then { call compile preprocessFile _nextRefreshScript; };
        };
    };
};
