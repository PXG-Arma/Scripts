/*
    FBT_UpdateExtendedDropdowns.sqf
    -------------------------------
    Handles the cascading metadata dropdowns specifically for the Extended (Confirmation) panel.
    - Monitors for '+ ADD NEW' selection.
    - Toggles visibility of the specific edit fields for each level.
*/
params [["_mode", "Init"]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _registry = call compile preprocessFile "Scripts\Factions\Factions_Registry.sqf";

// Extended IDCs
private _idcSide     = 456151;
private _idcFaction  = 456152;
private _idcSub      = 456153;
private _idcCamo     = 456154;
private _idcEra      = 456155;

// Edit IDCs
private _ideFaction  = 456172;
private _ideSub      = 456173;
private _ideCamo     = 456174;
private _ideEra      = 456175;

private _fnc_addOptions = {
    params ["_ctrlIDC", "_list", ["_addOption", true]];
    private _ctrl = _display displayCtrl _ctrlIDC;
    
    // Remember current selection by text
    private _currentVal = lbText [_ctrlIDC, lbCurSel _ctrlIDC];
    
    lbClear _ctrl;
    { _ctrl lbAdd _x; } forEach _list;
    if (_addOption) then {
        private _idx = _ctrl lbAdd "+ ADD NEW";
        _ctrl lbSetColor [_idx, [0.3, 0.8, 0.3, 1]];
    };
    
    // Restore selection if possible
    private _newIdx = 0;
    if (_currentVal != "") then {
        {
            if (_x == _currentVal) exitWith { _newIdx = _forEachIndex; };
        } forEach _list;
    };
    _ctrl lbSetCurSel _newIdx;
};

// --- PRE-SCAN GLOBAL REGISTRY ---
private _allSides    = ["BLUFOR", "OPFOR", "INDEP"];
private _allFactions = [];
private _allSubs     = [];
private _allEras     = [];
private _allCamos    = [];

{
    _x params ["_s", "_f", "_sub", "_e", "_c"];
    if !(_f in _allFactions) then { _allFactions pushBack _f };
    if (_sub != "" && !(_sub in _allSubs)) then { _allSubs pushBack _sub };
    if !(_e in _allEras) then { _allEras pushBack _e };
    if !(_c in _allCamos) then { _allCamos pushBack _c };
} forEach _registry;

_allFactions sort true;
_allSubs sort true;
_allEras sort true;
_allCamos sort true;

private _selSide = lbText [_idcSide, lbCurSel _idcSide];

switch (_mode) do {
    case "Init": {
        missionNamespace setVariable ["FBT_Extended_Loading", true];
        
        [_idcSide, _allSides, false] call _fnc_addOptions;
        [_idcFaction, _allFactions, true] call _fnc_addOptions;
        
        private _displaySubs = _allSubs apply { if (_x == "") then { "Base" } else { _x } };
        [_idcSub, _displaySubs, true] call _fnc_addOptions;
        
        [_idcCamo, _allCamos, true] call _fnc_addOptions;
        [_idcEra, _allEras, true] call _fnc_addOptions;
        
        missionNamespace setVariable ["FBT_Extended_Loading", nil];
        
        // Initial visibility refresh for Edit boxes
        ["Faction"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf");
        ["Subfaction"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf");
        ["Camo"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf");
        ["Era"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf");
    };

    case "Side": {
        // Do nothing, list is already global
    };

    case "Faction": {
        private _isNew = ((lbText [_idcFaction, lbCurSel _idcFaction]) == "+ ADD NEW");
        (_display displayCtrl _ideFaction) ctrlShow _isNew;
        if (_isNew) then { ctrlSetFocus (_display displayCtrl _ideFaction); };
    };

    case "Subfaction": {
        private _isNew = ((lbText [_idcSub, lbCurSel _idcSub]) == "+ ADD NEW");
        (_display displayCtrl _ideSub) ctrlShow _isNew;
        if (_isNew) then { ctrlSetFocus (_display displayCtrl _ideSub); };
    };

    case "Camo": {
        private _isNew = ((lbText [_idcCamo, lbCurSel _idcCamo]) == "+ ADD NEW");
        (_display displayCtrl _ideCamo) ctrlShow _isNew;
        if (_isNew) then { ctrlSetFocus (_display displayCtrl _ideCamo); };
    };

    case "Era": {
        private _isNew = ((lbText [_idcEra, lbCurSel _idcEra]) == "+ ADD NEW");
        (_display displayCtrl _ideEra) ctrlShow _isNew;
        if (_isNew) then { ctrlSetFocus (_display displayCtrl _ideEra); };
    };
};
