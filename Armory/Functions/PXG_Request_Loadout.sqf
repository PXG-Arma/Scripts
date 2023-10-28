// Get selected items from GUI 
private _indexSide = lbCurSel 431500;
private _indexFaction = tvCurSel 431501;
private _indexLoadout = tvCurSel 431503;
private _savedFaction = tvCurSel 431501;

// Gives hints if user does not select all items from UI, prevents errors
if (_indexSide == -1) exitWith { hint "Please select side."};
if (count _indexFaction == 0 ) exitWith { hint "Please select faction."};
if (count _indexLoadout < 2 ) exitWith { hint "Please select loadout."};

player setVariable ["PXG_Armory_Memory_Side", _indexSide];
player setVariable ["PXG_Armory_Memory_Faction", _savedFaction];
player setVariable ["PXG_Armory_Memory_Loadout", _indexLoadout];

// Gets text and data from UI 
private _side = str _indexSide;
private _variant = tvText [431501, _indexFaction];
//private _indexFaction deleteAt 1; 
private _factionName = tvText [431501, _indexFaction];
private _loadoutName = tvText [431503, _indexLoadout];

private _faction = "getText (_x >> 'name') == _factionName" configClasses (missionConfigFile >> "PXGfactions");
private _loadout = "getText (_x >> 'displayName') == _loadoutName" configClasses (_faction select 0);

//hint str(_loadout);

// Call script for loadouts 
[_side, _faction,_variant, _loadout select 0] call compile preprocessfile "scripts\Armory\Functions\PXG_Recieve_Loadout.sqf";

// Save player side faction and loadout for respawn 
player setVariable ["PXG_Player_side", _side, true];
player setVariable ["PXG_Player_faction", _factionName, true];
player setVariable ["PXG_Player_variant", _variant, true];
player setVariable ["PXG_player_loadout", _loadoutName, true];

// Closes armory dialog 
closeDialog 2;