params["_loadout"];

private _medicalItems = getArray (_loadout >> "personalMedical");

for "_i" from 0 to (count _medicalItems - 1) step 2 do { 
	[player, _medicalItems select _i, _medicalItems select _i+1] call compile preprocessFile "scripts\Armory\Functions\fn_addToAnywhere.sqf";
};

if (getNumber (_loadout >> "medicalPerms") == 1) then {
	private _medicalItems = getArray (_loadout >> "medicMedical");

	for "_i" from 0 to (count _medicalItems - 1) step 2 do { 
		private _leftOverMedical = [player, _medicalItems select _i, _medicalItems select _i+1] call compile preprocessFile "scripts\Armory\Functions\fn_addToBackpack.sqf";
		if (_leftOverMedical > 0) then {
			hint "Could not add all medical items to your backpack."
		}
	};
};
