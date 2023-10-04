params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "30Rnd_65x39_caseless_green", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "UK3CB_RPK_75rnd_762x39", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_RPK_75rnd_762x39_GM", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_dmr";
	case "rcn_dmr": {
		[ player, "rhs_10Rnd_762x54mmR_7N1", 12 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhs_100Rnd_762x54mmR", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_7BZ3", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_100Rnd_762x54mmR_green", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "pil": {};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "11Rnd_45ACP_Mag", 3 ] call pxg_armory_fnc_addToUniform;
	};
	case "sqd_eng";
	case "rcn_spe": {};
};


// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "UK3CB_RPK_75rnd_762x39", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_RPK_75rnd_762x39_GM", 4 ] call pxg_armory_fnc_addToBackpack;
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
		[ player, "1Rnd_HE_Grenade_shell", 5 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeRed_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeGreen_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UGL_FlareWhite_F", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		[ player, "1Rnd_HE_Grenade_shell", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeRed_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeGreen_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UGL_FlareWhite_F", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
