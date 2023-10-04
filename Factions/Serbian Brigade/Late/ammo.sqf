params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhsgref_30rnd_556x45_m21_t", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsgref_30rnd_556x45_m21", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsgref_30rnd_556x45_m21", 2 ] call pxg_armory_fnc_addToBackpack;

	};
	case "sqd_ar": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsgref_10Rnd_792x57_m76", 8 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhssaf_10Rnd_792x57_m76_tracer", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhsgref_30rnd_556x45_m21_t", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsgref_30rnd_556x45_m21", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsgref_30rnd_556x45_m21", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_spe": {
		[ player, "rhsgref_30rnd_556x45_m21", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsgref_30rnd_556x45_m21_t", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhsgref_20rnd_765x17_vz61", 4 ] call pxg_armory_fnc_addToVest;
	};
};

// add secondary ammo
//switch (_loadout) do {
//	default {};
//};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_SR", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "rhs_mag_9k38_rocket", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_SR", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "rhs_mag_9k38_rocket", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhssaf_mag_brd_m83_white", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhssaf_mag_brd_m83_red", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhssaf_mag_brd_m83_green", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhssaf_mag_br_m84", 2 ] call pxg_armory_fnc_addToVest;
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
