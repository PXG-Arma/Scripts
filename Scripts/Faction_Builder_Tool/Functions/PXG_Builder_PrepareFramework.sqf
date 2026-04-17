/*
    PXG_Builder_PrepareFramework.sqf
    -------------------------------
    Loads and compiles the Faction Framework scripts (Uniforms, Weapons, etc)
    by replacing 'player' with '_unit'. This allows native PXG gear scripts
    to run on staged parade dummies.
*/
params [["_factionPath", ""]];

if (_factionPath == "") exitWith { diag_log "[PXG Builder] Error: No faction path for framework preparation."; };

private _scripts = ["Uniforms.sqf", "Weapons.sqf", "Gear.sqf", "Ammo.sqf"];
private _compiledBlocks = createHashMap;

private _compiledBlocks = createHashMap;

// Helper to replace ALL occurrences of a substring (case-insensitive find)
private _fnc_replace = {
    params ["_str", "_old", "_new"];
    private _out = "";
    private _len = count _old;
    private _lowOld = toLower _old;
    while {true} do {
        private _idx = (toLower _str) find _lowOld;
        if (_idx == -1) exitWith { _out = _out + _str; };
        _out = _out + (_str select [0, _idx]) + _new;
        _str = _str select [_idx + _len];
    };
    _out
};

{
    private _fileName = _x;
    private _fullPath = _factionPath + _fileName;
    
    if (fileExists _fullPath) then {
        // --- ENGINE PREPROCESSING ---
        private _fileItems = preprocessFile _fullPath;
        
        // --- PROXY REDIRECTION ---
        private _fixedScript = [_fileItems, "player", "_unit"] call _fnc_replace;
        
        private _header = "params ['_side', '_faction', '_variant', '_loadout', ['_unit', objNull]]; if (isNull _unit) exitWith {}; ";
        private _fullScript = _header + _fixedScript;
        
        private _code = compile _fullScript;
        _compiledBlocks set [_fileName, _code];
        diag_log format ["[PXG Builder] Proxy Compiled: %1", _fileName];
    };
} forEach _scripts;

missionNamespace setVariable ["PXG_Builder_FrameworkProxy", _compiledBlocks];
true
