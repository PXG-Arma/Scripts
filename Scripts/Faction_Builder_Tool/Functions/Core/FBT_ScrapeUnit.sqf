/*
    FBT_ScrapeUnit.sqf
    -------------------------------
    Converts a dressed 3D unit back into a session hash.
    Used for legacy faction imports and live editing state capture.
*/
params [["_unit", objNull]];

if (isNull _unit) exitWith { createHashMap };

private _roleState = createHashMap;

// 1. Clothing
_roleState set ["UNIFORM", uniform _unit];
_roleState set ["VEST", vest _unit];
_roleState set ["BACKPACK", backpack _unit];
_roleState set ["HEADGEAR", headgear _unit];
_roleState set ["GOGGLES", goggles _unit];

// 2. Weapons & Attachments
private _fnc_scrapeWep = {
    params ["_weapon"];
    if (_weapon == "") exitWith { ["", []] };
    private _attachments = _unit weaponAccessories _weapon;
    // Filter out empty strings from the accessories array
    _attachments = _attachments select { _x != "" };
    [_weapon, _attachments]
};

_roleState set ["PRIMARY", [primaryWeapon _unit] call _fnc_scrapeWep];
_roleState set ["HANDGUN", [handgunWeapon _unit] call _fnc_scrapeWep];
_roleState set ["LAUNCHER", [secondaryWeapon _unit] call _fnc_scrapeWep];

// 3. Magazines (FBT uses counts)
private _mags = magazinesAmmoFull _unit; // [[class, ammo, isLoaded, type, location], ...]
private _magCounts = createHashMap; // Class -> Count

{
    private _class = _x select 0;
    private _current = _magCounts getOrDefault [_class, 0];
    _magCounts set [_class, _current + 1];
} forEach _mags;

private _formattedMags = [];
{
    _formattedMags pushBack [_x, _y];
} forEach _magCounts;

_roleState set ["MAGAZINES", _formattedMags];

// 4. Items (Flat array)
private _items = (uniformItems _unit) + (vestItems _unit) + (backpackItems _unit);
// Remove magazines from items list as they are handled in the MAGAZINES key
{
    private _magClass = _x;
    private _idx = _items find _magClass;
    if (_idx != -1) then { _items deleteAt _idx; };
} forEach (magazines _unit);

_roleState set ["ITEMS", _items];

// 5. Linked Items
_roleState set ["NVG", hmd _unit];
_roleState set ["BINOC", binocular _unit];

_roleState
