// Get selected items from GUI 
_indexSide = lbCurSel 431500;
_indexFaction = tvCurSel 431501;
_indexLoadout = tvCurSel 431503;
_indexWeapon = lbCurSel 431504;
_indexScope = lbCurSel 431505;
_savedFaction = tvCurSel 431501;

// Gives hints if user does not select all items from UI, prevents errors
if (_indexSide == -1) exitWith { hint "Please select side."};
if (count _indexFaction == 0 ) exitWith { hint "Please select faction."};
if (count _indexFaction == 1 ) exitWith { hint "Please select faction variant."};
if (count _indexLoadout < 2 ) exitWith { hint "Please select role."};

player setVariable ["PXG_Armory_Memory_Side", _indexSide];
player setVariable ["PXG_Armory_Memory_Faction", _savedFaction];
player setVariable ["PXG_Armory_Memory_Loadout", _indexLoadout];
player setVariable ["PXG_Armory_Memory_Weapon", _indexWeapon];
player setVariable ["PXG_Armory_Memory_Scope", _indexScope];

// Gets text and data from UI 
_side = str _indexSide;
_variant = tvText [431501, _indexFaction];
_indexFaction deleteAt 1; 
_faction = tvText [431501, _indexFaction];
_loadout = tvData [431503, _indexLoadout];
_weapon = lbData [431504, _indexWeapon];
_scope = lbData [431505, _indexScope];

// Call script for loadouts 
[_side, _faction, _variant, _loadout, _scope, _weapon] call compile preprocessfile "scripts\Armory\Functions\PXG_Recieve_Loadout.sqf";

// Save player side faction and loadout for respawn 
player setVariable ["PXG_Player_side", _side, true];
player setVariable ["PXG_Player_faction", _faction, true];
player setVariable ["PXG_Player_variant", _variant, true];
player setVariable ["PXG_player_loadout", _loadout, true];
player setVariable ["PXG_player_weapon", _weapon, true];
player setVariable ["PXG_player_scope", _scope, true];

// Closes armory dialog 
closeDialog 2;