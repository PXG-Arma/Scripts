params ["_loadout"];

private _radio = getText (_loadout >> "personalRadio");
private _lRadio = getText (_loadout >> "longRangeRadio");

if (_radio != "") then {
	private _leftOverRadio = [player, _radio, 1] call compile preprocessFile "scripts\Armory\Functions\fn_addToUniform.sqf";
	if (_leftOverRadio > 0) then {
		hint "Could not add radio to uniform";
	};
};

if (_lRadio != "") then {
	if (_lRadio == "ACRE_PRC117F") then {
		private _leftOverRadio = [player, _lRadio, 1] call compile preprocessFile "scripts\Armory\Functions\fn_addToBackpack.sqf";
		if (_leftOverRadio > 0) then {
			hint "Could not add radio to backpack";
		};
	} else {
		private _leftOverRadio = [player, _lRadio, 1] call compile preprocessFile "scripts\Armory\Functions\fn_addToVest.sqf";
		if (_leftOverRadio > 0) then {
			hint "Could not add radio to vest";
		};
	};

};