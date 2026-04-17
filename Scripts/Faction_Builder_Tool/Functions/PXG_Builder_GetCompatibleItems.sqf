/*
    PXG_Builder_GetCompatibleItems.sqf
    -------------------------------
    Identifies compatible attachments for the currently equipped weapon.
*/
params [["_unit", player], ["_slot", "optic"]];

private _weapon = primaryWeapon _unit;
if (_weapon == "") exitWith { [] };

private _compatible = [];
private _cfg = configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo";

private _slotPath = switch (_slot) do {
    case "optic":  { _cfg >> "CowsSlot" };
    case "muzzle": { _cfg >> "MuzzleSlot" };
    case "acc":    { _cfg >> "PointerSlot" };
    case "bipod":  { _cfg >> "UnderBarrelSlot" };
    default { configNull };
};

if (isClass _slotPath) then {
    _compatible = getArray (_slotPath >> "compatibleItems");
};

// Return result formatted for the browser: [[Name, Class, Pic], ...]
private _results = [];
{
    private _itemCfg = configFile >> "CfgWeapons" >> _x;
    if (isClass _itemCfg) then {
        _results pushBack [getText(_itemCfg >> "displayName"), _x, getText(_itemCfg >> "picture"), ""];
    };
} forEach _compatible;

_results
