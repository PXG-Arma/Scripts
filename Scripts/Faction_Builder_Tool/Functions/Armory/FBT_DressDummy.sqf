/*
    FBT_DressDummy.sqf
    -------------------------------
    Applies gear from a FBT Role Hashmap to a specific unit.
    Params: [_unit, _roleData]
*/
params ["_unit", ["_roleData", createHashMap]];

if (isNull _unit || count _roleData == 0) exitWith {};

// --- Clear Everything First ---
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

// --- Clothing ---
private _uniform = _roleData getOrDefault ["UNIFORM", ""];
if (_uniform != "") then { _unit forceAddUniform _uniform; };

private _vest = _roleData getOrDefault ["VEST", ""];
if (_vest != "") then { _unit addVest _vest; };

private _backpack = _roleData getOrDefault ["BACKPACK", ""];
if (_backpack != "") then { _unit addBackpackGlobal _backpack; };

private _helmet = _roleData getOrDefault ["HEADGEAR", ""];
if (_helmet == "") then { _roleData getOrDefault ["helmet", ""]; };
if (_helmet != "") then { _unit addHeadgear _helmet; };

private _goggles = _roleData getOrDefault ["GOGGLES", ""];
if (_goggles != "") then { _unit addGoggles _goggles; };

// --- Weapons & Attachments ---
private _fnc_addWep = {
    params ["_u", "_data", "_type"];
    if (typeName _data == "STRING") then {
        if (_data != "") then { _u addWeaponGlobal _data; };
    } else {
        if (count _data > 0) then {
            private _gun = _data select 0;
            if (_gun != "") then {
                _u addWeaponGlobal _gun;
                if (count _data > 1) then {
                    { 
                        switch (_type) do {
                            case "PRI": { _u addPrimaryWeaponItem _x; };
                            case "SEC": { _u addHandgunItem _x; };
                            case "LNC": { _u addSecondaryWeaponItem _x; };
                        };
                    } forEach (_data select 1);
                };
            };
        };
    };
};

[_unit, _roleData getOrDefault ["PRIMARY", ""], "PRI"] call _fnc_addWep;
[_unit, _roleData getOrDefault ["HANDGUN", ""], "SEC"] call _fnc_addWep;
[_unit, _roleData getOrDefault ["LAUNCHER", ""], "LNC"] call _fnc_addWep;

// --- Items & Linked ---
private _linked = _roleData getOrDefault ["NVG", ""];
if (_linked != "") then { _unit linkItem _linked; };

private _binoc = _roleData getOrDefault ["BINOC", ""];
if (_binoc != "") then { _unit addWeaponGlobal _binoc; };

// Containers
private _mags = _roleData getOrDefault ["MAGAZINES", []];
{
    private _magClass = _x select 0;
    private _magCount = (_x select 1) min 50;
    for "_i" from 1 to _magCount do { _unit addMagazineGlobal _magClass; };
} forEach _mags;

private _items = _roleData getOrDefault ["ITEMS", []];
{
    if (typeName _x == "ARRAY") then {
        private _iCount = (_x select 1) min 50;
        for "_i" from 1 to _iCount do { _unit addItem (_x select 0); };
    } else {
        _unit addItem _x;
    };
} forEach _items;

diag_log format ["[FBT] Dummy dressed: %1", _unit];
