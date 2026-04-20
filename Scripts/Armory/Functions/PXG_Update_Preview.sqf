#include "..\..\macros.hpp"
/*
    PXG_Update_Preview.sqf
    ----------------------------
    Applies the currently selected loadout/modular items to the player for the live preview.
*/

private _display = findDisplay IDD_ARMORY;
if (isNull _display) exitWith {};

// Gather UI Selections
private _indexSide = lbCurSel IDC_ARMORY_SIDE;
private _indexFaction = tvCurSel IDC_ARMORY_FACTION_TREE;
private _indexLoadout = tvCurSel IDC_ARMORY_LOADOUT_TREE;

// Validation (Role must be selected)
if (count _indexLoadout < 2) exitWith {};

private _side = str _indexSide;
private _variant = lbData [IDC_ARMORY_CAMO_LIST, lbCurSel IDC_ARMORY_CAMO_LIST];
private _loadout = tvData [IDC_ARMORY_LOADOUT_TREE, _indexLoadout];

// Get Faction Name (Cleaning path index)
private _factionIndex = +_indexFaction;
_factionIndex deleteAt 1; 
private _faction = tvText [IDC_ARMORY_FACTION_TREE, _factionIndex];

// Modular Overrides
private _overrideWeaponData = lbData [IDC_ARMORY_WEAPON_LIST, lbCurSel IDC_ARMORY_WEAPON_LIST];
private _split = _overrideWeaponData splitString "|";
private _overrideWeapon = if (count _split > 0) then { _split select 0 } else { "" };
private _overrideSight = lbData [IDC_ARMORY_ATTACHMENT_LIST, lbCurSel IDC_ARMORY_ATTACHMENT_LIST];

// Apply the Loadout to the Player Character (Preview Mode = true)
[_side, _faction, _variant, _loadout, _overrideWeapon, _overrideSight, true] call compile preprocessfile "scripts\Armory\Functions\PXG_Recieve_Loadout.sqf";
