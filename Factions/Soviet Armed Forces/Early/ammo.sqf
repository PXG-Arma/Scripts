params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_30Rnd_762x39mm", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_762x39mm", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_30Rnd_762x39mm_tracer", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_med";
	case "sqd_eng": {
		[ player, "rhs_30Rnd_762x39mm", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_762x39mm", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_30Rnd_762x39mm_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "UK3CB_AK47_45Rnd_Magazine_G", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "UK3CB_SVD_10rnd_762x54", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_SVD_10rnd_762x54_GT", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR_green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l";
	case "sup_mat_g": {
		[ player, "rhs_30Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_762x39mm_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {};
};

// add secondary ammo
switch (_loadout) do {
	default {};
	case "plt";
	case "logi";
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhs_mag_9x18_8_57N181S", 2 ] call pxg_armory_fnc_addToUniform;
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "UK3CB_AK47_45Rnd_Magazine_G", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhs_100Rnd_762x54mmR_green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_rpg7_OG7V_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VM_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_rpg7_OG7V_mag", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VM_mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhs_mag_rdg2_white", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_rdg2_black", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_rgd5", 2 ] call pxg_armory_fnc_addToVest;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhs_mag_rdg2_white", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_rdg2_black", 1 ] call pxg_armory_fnc_addToVest;
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
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		[ player, "rhs_VOG25", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_White", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Red", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Green", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
