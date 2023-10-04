params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_30Rnd_545x39_7N10_AK", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_545x39_7N10_AK", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhs_75Rnd_762x39mm_tracer", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_75Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_bre": {
		[ player, "rhs_30Rnd_545x39_7N10_AK", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_545x39_7N10_AK", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_5Rnd_Slug", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhs_10Rnd_762x54mmR_7N1", 6 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_10Rnd_762x54mmR_7N14", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "16Rnd_9x21_Mag", 2 ] call pxg_armory_fnc_addToUniform;
	};
	case "sqd_hgre": {
		[ player, "16Rnd_9x21_Mag", 5 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_eng";
	case "rcn_spe": {};
};


// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhs_75Rnd_762x39mm", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_75Rnd_762x39mm_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_rpg7_OG7V_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "rhs_mag_9k38_rocket", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_rpg7_PG7VL_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "rhs_mag_9k38_rocket", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhs_mag_rdg2_white", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhssaf_mag_brd_m83_green", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhssaf_mag_brd_m83_red", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_rgd5", 2 ] call pxg_armory_fnc_addToVest;
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};

};
