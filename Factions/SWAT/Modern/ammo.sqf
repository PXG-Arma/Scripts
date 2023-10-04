params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine_GT", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_brc": {
		[ player, "rhsusf_5Rnd_Slug", 8 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_5Rnd_Slug", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ope": {
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine_GT", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsusf_5Rnd_762x51_m993_Mag", 8 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_5Rnd_762x51_m62_Mag", 8 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_17Rnd_9x19_FMJ", 5 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ope": {
		[ player, "rhsusf_mag_17Rnd_9x19_FMJ", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "pil": {
		for "_i" from 1 to 2 do { player addItemTovest "rhsusf_mag_17Rnd_9x19_FMJ"};
	};
};

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
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "ACE_M84", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_m7a3_cs", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "tsp_popperCharge_mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_brc": {
		[ player, "ACE_CTS9", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "ACE_M84", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_m7a3_cs", 2 ] call pxg_armory_fnc_addToVest;
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt";
	case "rcn_ld";
	case "sqd_ld": { 
		[ player, "UK3CB_BAF_1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_m4009", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_m576", 4 ] call pxg_armory_fnc_addToBackpack;
	};
};
