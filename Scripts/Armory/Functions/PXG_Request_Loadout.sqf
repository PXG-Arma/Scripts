#include "..\..\macros.hpp"

// Get selected items from GUI 
private _indexSide = lbCurSel IDC_ARMORY_SIDE;
private _indexFaction = tvCurSel IDC_ARMORY_FACTION_TREE;
private _indexLoadout = tvCurSel IDC_ARMORY_LOADOUT_TREE;
private _savedFaction = tvCurSel IDC_ARMORY_FACTION_TREE;

// Gives hints if user does not select all items from UI, prevents errors
if (_indexSide == -1) exitWith { hint "Please select side."};
if (count _indexFaction == 0 ) exitWith { hint "Please select faction."};
if (count _indexFaction < 4 ) exitWith { hint "Please select faction variant."};
if (count _indexLoadout < 2 ) exitWith { hint "Please select loadout."};

player setVariable ["PXG_Armory_Memory_Side", _indexSide];
player setVariable ["PXG_Armory_Memory_Faction", _savedFaction];
player setVariable ["PXG_Armory_Memory_Loadout", _indexLoadout];

// Gets text and data from UI 
private _side = str _indexSide;
private _variant = tvData [IDC_ARMORY_FACTION_TREE, _indexFaction]; // Using tvData to get serialized metadata [Side, Faction, SubFaction, Era, Camo]
_indexFaction deleteAt 1; 
private _faction = tvText [IDC_ARMORY_FACTION_TREE, _indexFaction];
private _loadout = tvData [IDC_ARMORY_LOADOUT_TREE, _indexLoadout];

// Call script for loadouts 
[_side, _faction, _variant, _loadout] call compile preprocessfile "scripts\Armory\Functions\PXG_Recieve_Loadout.sqf";


// Save player side faction and loadout for respawn 
player setVariable ["PXG_Player_side", _side, true];
player setVariable ["PXG_Player_faction", _faction, true];
player setVariable ["PXG_Player_variant", _variant, true];
player setVariable ["PXG_player_loadout", _loadout, true];

// Closes armory dialog 
closeDialog 2;