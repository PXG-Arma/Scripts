params [
    ["_side",""], ["_faction",""], ["_variant",""], ["_loadout", []],
    ["_overrideWeapon", ""], ["_overrideSight", ""], ["_isPreview", false]
];

private _basePath = "";

if (_variant select [0,1] == "[") then {
	_basePath = [_variant] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
} else {
	// Fallback for legacy string format
	private _variantArray = _variant splitString " ";
	private _variantCamo = _variantArray select 0;
	private _variantEra = _variantArray select 1;

	private _sideFolder = switch (side player) do {
		case west: {"BLUFOR"};
		case east: {"OPFOR"};
		case resistance: {"INDEP"};
		default {""};
	};
	
	private _eraPath = ""; if (_variantEra != "") then { _eraPath = _variantEra + "\" };
	_basePath = "Scripts\Factions\" + _sideFolder + "\" + _faction + "\" + _eraPath + _variantCamo + "\";
};

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;

[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Armory\Functions\PXG_Set_ACEPerms.sqf";
if (fileExists (_basePath + "Faction_Core.sqf")) then {
	[_side, _faction, _variant, _loadout, _basePath, _overrideWeapon, _overrideSight] call compile preprocessFile "Scripts\Armory\Functions\PXG_ApplyFactionData.sqf";
} else {
	if (fileExists (_basePath + "Uniforms.sqf")) then { [_side, _faction, _variant, _loadout] call compile preprocessFile (_basePath + "Uniforms.sqf") };
	if (fileExists (_basePath + "Weapons.sqf")) then { 
		private _fnc_scriptName = _basePath + "Weapons.sqf";
		[_side, _faction, _variant, _loadout, "APPLY", _overrideWeapon, "", ""] call compile preprocessFile _fnc_scriptName; 
		[_overrideSight] call compile preprocessFile "Scripts\Armory\Functions\PXG_Apply_Legacy_Sight_Override.sqf"; 
	};
	if (fileExists (_basePath + "Ammo.sqf")) then { [_side, _faction, _variant, _loadout] call compile preprocessFile (_basePath + "Ammo.sqf") };
	[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\radios.sqf";
	[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\gear.sqf";
	if (fileExists (_basePath + "Gear.sqf")) then { [_side, _faction, _variant, _loadout] call compile preprocessFile (_basePath + "Gear.sqf") };
	[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\medical.sqf";
};

// Only configure radios if this is NOT a preview (to avoid UI-thread suspension errors)
if (!_isPreview) then {
	[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Armory\Functions\PXG_Configure_RadioChannels.sqf";
};
