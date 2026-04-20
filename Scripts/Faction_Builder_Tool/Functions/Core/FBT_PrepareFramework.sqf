/*
    FBT_PrepareFramework.sqf
    -------------------------------
    Loads and compiles the Faction Framework scripts (Uniforms, Weapons, etc)
    by replacing 'player' with '_unit'. This allows native PXG gear scripts
    to run on staged parade dummies.
*/
params [["_factionPath", ""]];

if (_factionPath == "") exitWith { diag_log "[FBT] Error: No faction path for framework preparation."; };

private _scripts = ["Uniforms.sqf", "Weapons.sqf", "Gear.sqf", "Ammo.sqf"];
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
        // 1. Redirect 'player' to '_unit'
        private _fixedScript = [_fileItems, "player", "_unit"] call _fnc_replace;
        
        // 2. Handle Recursion: Redirect recursive calls to the proxy instead of disk
        // We replace 'compile preprocessFile _fnc_scriptName' with a wrapper that injects our '_unit' into the args.
        private _proxySnippet = format ["{ private _recursiveArgs = _this; _recursiveArgs set [8, _unit]; _recursiveArgs call ((missionNamespace getVariable ['FBT_FrameworkProxy', createHashMap]) get '%1') }", _fileName];
        _fixedScript = [_fixedScript, "compile preprocessFile _fnc_scriptName", _proxySnippet] call _fnc_replace;
        
        // 3. Define Header: We follow the standard 8-arg signature and add '_unit' as the 9th.
        // Signature: _side, _faction, _variant, _loadout, _mode, _weapon, _weaponGroup, _roleGroup, _unit
        private _header = format ["params ['_side', '_faction', '_variant', '_loadout', ['_mode', 'APPLY'], ['_weapon', ''], ['_weaponGroup', ''], ['_roleGroup', ''], ['_unit', objNull]]; private _fnc_scriptName = '%1'; if (isNull _unit && _mode == 'APPLY') exitWith {}; ", _fileName];
        
        // 4. Neutralize original params line
        private _paramsIdx = (toLower _fixedScript) find "params";
        if (_paramsIdx != -1) then {
            private _scriptBefore = _fixedScript select [0, _paramsIdx];
            private _scriptAfter  = _fixedScript select [_paramsIdx + 6]; 
            _fixedScript = _scriptBefore + "private _legacyParams = " + _scriptAfter;
        };

        private _fullScript = _header + _fixedScript + "; ''"; // Ensure it returns something
        
        private _code = compile _fullScript;
        _compiledBlocks set [_fileName, _code];
        diag_log format ["[FBT] Proxy Compiled: %1", _fileName];
    };
} forEach _scripts;

missionNamespace setVariable ["FBT_FrameworkProxy", _compiledBlocks];
true
