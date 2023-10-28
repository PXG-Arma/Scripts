params["_side","_faction","_variant", "_loadout"]; 

// Split variant name to get era and camopattern 
//_variantArray = _variant splitString " ";
//_variantEra = _variantArray #1;
//_variantCamo = _variantArray #0;

// removes all items from current loadout
removeAllWeapons player;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;

hint ("You have a fresh loadout."); // Hint for debugging if loadouts are missing items

// Give uniforms 

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addUniform.sqf";

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addWeapons.sqf";

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addRadio.sqf";

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addMedical.sqf";

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addGear.sqf";

[_loadout] call compile preprocessFile "scripts\Armory\Functions\fn_addAmmo.sqf";

// Set ACE permissions 
[_side, _faction, _variant, _loadout] call compile preprocessFile "scripts\Armory\Functions\PXG_Set_ACEPerms.sqf";

// configure radios
[_side, _faction, _variant, _loadout] call compile preprocessFile "scripts\Armory\Functions\PXG_Configure_RadioChannels.sqf";

