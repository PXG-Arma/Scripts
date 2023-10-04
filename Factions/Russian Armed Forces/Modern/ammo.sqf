params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_30Rnd_545x39_7N22_plum_AK", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_545x39_AK_plum_green", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhs_60Rnd_545X39_7N22_AK", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_60Rnd_545X39_AK_Green", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_dmr";
	case "rcn_dmr": {
		[ player, "rhs_10Rnd_762x54mmR_7N1", 6 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_10Rnd_762x54mmR_7N14", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c": {
		[ player, "rhs_30Rnd_545x39_7N22_plum_AK", 3 ] call pxg_armory_fnc_addToVest;
	};
	case "pil": {};
};

// add secondary ammo
switch (_loadout) do {
	default {};
	case "pil": {
		[ player, "rhs_mag_9x19_7n31_17", 3 ] call pxg_armory_fnc_addToVest;
	};
};


// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhs_60Rnd_545X39_7N22_AK", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_60Rnd_545X39_AK_Green", 4 ] call pxg_armory_fnc_addToBackpack;
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
	case "plt": {
		[ player, "rhs_VOG25", 5 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_White", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Red", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_VG40OP_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		[ player, "rhs_VOG25", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_White", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Red", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_VG40OP_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
