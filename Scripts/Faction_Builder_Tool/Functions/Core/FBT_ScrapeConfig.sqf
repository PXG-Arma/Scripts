/*
    FBT_ScrapeConfig.sqf
    -------------------------------
    Scans game configs for gear based on category.
    Returns: Array of [[DisplayName, ClassName, Picture, Bio], ...]
*/
params [["_category", "PRIMARY"]];

private _cache = missionNamespace getVariable ["FBT_ConfigCache", createHashMap];
if (_category in _cache) exitWith { _cache get _category };

private _results = [];

switch (_category) do {
    case "PRIMARY": {
        private _cfg = configFile >> "CfgWeapons";
        for "_i" from 0 to (count _cfg - 1) do {
            private _item = _cfg select _i;
            if (isClass _item) then {
                if (getNumber(_item >> "scope") == 2 && getNumber(_item >> "type") == 1) then {
                    _results pushBack [getText(_item >> "displayName"), configName _item, getText(_item >> "picture"), ""];
                };
            };
        };
    };
    case "LAUNCHER": {
        private _cfg = configFile >> "CfgWeapons";
        {
            if (getNumber(_x >> "scope") == 2 && getNumber(_x >> "type") == 4) then {
                _results pushBack [getText(_x >> "displayName"), configName _x, getText(_x >> "picture"), ""];
            };
        } forEach (configProperties [_cfg, "isClass _x"]);
    };
    case "HANDGUN": {
        {
            if (getNumber(_x >> "scope") == 2 && getNumber(_x >> "type") == 2) then {
                _results pushBack [getText(_x >> "displayName"), configName _x, getText(_x >> "picture"), ""];
            };
        } forEach (configProperties [configFile >> "CfgWeapons", "isClass _x"]);
    };
    case "UNIFORM":
    case "VEST":
    case "HEADGEAR": {
        private _cfgType = configFile >> "CfgWeapons";
        private _typeId = switch (_category) do { case "UNIFORM": {801}; case "VEST": {701}; case "HEADGEAR": {605}; };
        
        private _variants = createHashMap; // BaseClass -> [FullEntry1, FullEntry2]
        
        {
            private _info = _x >> "ItemInfo";
            if (getNumber(_x >> "scope") == 2 && getNumber(_info >> "type") == _typeId) then {
                private _className = configName _x;
                private _baseClass = getText(_x >> "ace_arsenal_uniqueBase");
                if (_baseClass == "") then { _baseClass = _className; }; // If no base, it is the base
                
                private _currentVariants = _variants getOrDefault [_baseClass, []];
                _currentVariants pushBack [getText(_x >> "displayName"), _className, getText(_x >> "picture")];
                _variants set [_baseClass, _currentVariants];
            };
        } forEach (configProperties [_cfgType, "isClass _x"]);
        
        // Populate results with only the FIRST variant of each base (as the representative)
        {
            private _vList = _y;
            _results pushBack [(_vList select 0) select 0, _x, (_vList select 0) select 2, format ["Variants: %1", count _vList]];
        } forEach _variants;
        
        // Store variants globally for the selector
        private _masterVariants = missionNamespace getVariable ["FBT_VariantsCache", createHashMap];
        _masterVariants set [_category, _variants];
        missionNamespace setVariable ["FBT_VariantsCache", _masterVariants];
    };

    case "GOGGLES": {
        {
            if (getNumber(_x >> "scope") == 2) then {
                _results pushBack [getText(_x >> "displayName"), configName _x, getText(_x >> "picture"), ""];
            };
        } forEach (configProperties [configFile >> "CfgGlasses", "isClass _x"]);
    };
    case "NVG": {
        {
            private _info = _x >> "ItemInfo";
            if (getNumber(_x >> "scope") == 2 && getNumber(_info >> "type") == 616) then {
                _results pushBack [getText(_x >> "displayName"), configName _x, getText(_x >> "picture"), ""];
            };
        } forEach (configProperties [configFile >> "CfgWeapons", "isClass _x"]);
    };
    case "BINOC": {
        {
            if (getNumber(_x >> "scope") == 2 && getNumber(_x >> "type") == 4096) then {
                _results pushBack [getText(_x >> "displayName"), configName _x, getText(_x >> "picture"), ""];
            };
        } forEach (configProperties [configFile >> "CfgWeapons", "isClass _x"]);
    };
};

_cache set [_category, _results];
missionNamespace setVariable ["FBT_ConfigCache", _cache];

_results
