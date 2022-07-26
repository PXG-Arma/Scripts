params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_30Rnd_762x39mm"};
		for "_i" from 1 to 4 do { player addItemToBackpack "rhs_30Rnd_762x39mm"};
	};
};

// add secondary ammo
//switch (_loadout) do {
//	default {};
//};

// add assistant ammo 
switch (_loadout) do {
	default {};
};

// add other ammo 
switch (_loadout) do {
	default {};
};

// add grenades
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_f1"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rdg2_white"};
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
};