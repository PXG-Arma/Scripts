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
    params ["_ctrlIDC", "_list", ["_addOption", true], ["_target", ""]];
    private _ctrl = _display displayCtrl _ctrlIDC;
    
    // Remember current selection by text (if no target provided)
    private _currentVal = if (_target == "") then { lbText [_ctrlIDC, lbCurSel _ctrlIDC] } else { _target };
    
    lbClear _ctrl;
    { _ctrl lbAdd _x; } forEach _list;
    if (_addOption) then {
        private _idx = _ctrl lbAdd "+ ADD NEW";
        _ctrl lbSetColor [_idx, [0.3, 0.8, 0.3, 1]];
    };
    
    // Restore/Apply selection if possible
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

switch (_mode) do {
    case "Init": {
        missionNamespace setVariable ["FBT_Extended_Loading", true];

        // --- DUPLICATION PRE-POPULATION ---
        private _isDuplicate = (_display getVariable ["FBT_PendingAction", ""]) == "DuplicateFaction";
        private _curSide = ""; private _curFact = ""; private _curSub = ""; private _curCamo = ""; private _curEra = "";

        if (_isDuplicate) then {
            _curSide = lbText [456051, lbCurSel 456051];
            _curFact = lbText [456052, lbCurSel 456052];
            _curSub  = lbText [456053, lbCurSel 456053];
            _curCamo = lbText [456054, lbCurSel 456054];
            _curEra  = lbText [456055, lbCurSel 456055];
        };
        
        [_idcSide, _allSides, false, _curSide] call _fnc_addOptions;
        [_idcFaction, _allFactions, true, _curFact] call _fnc_addOptions;
        
        private _displaySubs = _allSubs apply { if (_x == "") then { "Base" } else { _x } };
        [_idcSub, _displaySubs, true, _curSub] call _fnc_addOptions;
        
        [_idcCamo, _allCamos, true, _curCamo] call _fnc_addOptions;
        [_idcEra, _allEras, true, _curEra] call _fnc_addOptions;
        
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

