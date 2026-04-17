/*
    FBT_GetCompatibleMags.sqf
    -------------------------------
    Identifies every magazine compatible with the given unit's primary weapon.
    Returns: [[Name, Class, Pic], ...]
*/
params [["_unit", player]];

private _weapon = primaryWeapon _unit;
if (_weapon == "") exitWith { [] };

private _masterList = [];
private _cfgWeapon = configFile >> "CfgWeapons" >> _weapon;

// 1. Get All Muzzles (Handling UGLs)
private _muzzles = ["this"];
private _extraMuzzles = getArray (_cfgWeapon >> "muzzles");
{ if (_x != "this") then { _muzzles pushBack _x; }; } forEach _extraMuzzles;

{
    private _muzzleName = _x;
    private _cfgMuzzle = if (_muzzleName == "this") then { _cfgWeapon } else { _cfgWeapon >> _muzzleName };
    
    // A. Direct Magazines
    private _mags = getArray (_cfgMuzzle >> "magazines");
    { if !(_x in _masterList) then { _masterList pushBack _x; }; } forEach _mags;
    
    // B. Magazine Wells
    private _wells = getArray (_cfgMuzzle >> "magazineWell");
    {
        private _wellCfg = configFile >> "CfgMagazineWells" >> _x;
        if (isClass _wellCfg) then {
            {
                private _wellArr = getArray _x;
                { if !(_x in _masterList) then { _masterList pushBack _x; }; } forEach _wellArr;
            } forEach (configProperties [_wellCfg, "isArray _x"]);
        };
    } forEach _wells;
} forEach _muzzles;

// 2. Format for UI
private _results = [];
{
    private _magCfg = configFile >> "CfgMagazines" >> _x;
    if (isClass _magCfg && {getNumber(_magCfg >> "scope") == 2}) then {
        _results pushBack [getText(_magCfg >> "displayName"), _x, getText(_magCfg >> "picture")];
    };
} forEach _masterList;

_results
