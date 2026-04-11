sleep 1;

_side = player getVariable "PXG_Player_Side";
_faction = player getVariable "PXG_Player_Faction";
_variant = player getVariable "PXG_Player_Variant"; 
_loadout = player getVariable "PXG_Player_Loadout";
_weapon = player getVariable ["PXG_Player_Weapon", "default"];
_scope = player getVariable ["PXG_Player_Scope", "default"];

[_side, _faction, _variant, _loadout, _scope, _weapon] call compile preprocessfile "scripts\Armory\Functions\PXG_Recieve_Loadout.sqf";