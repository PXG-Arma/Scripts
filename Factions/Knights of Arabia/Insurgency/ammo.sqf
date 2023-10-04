params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		switch (primaryWeapon player) do {
		
			case "rhs_weap_akm": {
					[ player, "rhs_30Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "rhs_30Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToUniform;
			};
			case "rhs_weap_savz58p": {
					[ player, "rhs_30Rnd_762x39mm_Savz58", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "rhs_30Rnd_762x39mm_Savz58", 4 ] call pxg_armory_fnc_addToUniform;
			};
			case "uk3cb_sks_01": {
					[ player, "uk3cb_10rnd_magazine_sks", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "uk3cb_10rnd_magazine_sks", 4 ] call pxg_armory_fnc_addToUniform;
			};
			
			default {};
		};
	};
	case "plt";
	case "sqd_ld";
	case "sqd_gre": {
		[ player, "rhs_30Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_30Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToUniform;
	};
	case "sqd_ar": {
		[ player, "rhs_75Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_75Rnd_762x39mm_tracer", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR_green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "UK3CB_SVD_10rnd_762x54", 6 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_SVD_10rnd_762x54_GT", 6 ] call pxg_armory_fnc_addToUniform;
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
		[ player, "rhs_75Rnd_762x39mm", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_75Rnd_762x39mm_tracer", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhs_100Rnd_762x54mmR_green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_rpg7_OG7V_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_rpg7_PG7VL_mag", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhs_mag_f1", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_rdg2_white", 2 ] call pxg_armory_fnc_addToVest;
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
	case "sqd_gre": {
		[ player, "rhs_VOG25", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_White", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Red", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_GRD40_Green", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_VG40OP_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
