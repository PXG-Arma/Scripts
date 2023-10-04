params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		switch (primaryWeapon player) do {
		
			case "rhs_weap_ak104_zenitco01_b33";
			case "rhs_weap_ak103_zenitco01_b33";
			case "rhs_weap_ak103_gp25_npz": {
					[ player, "rhs_30Rnd_762x39mm_polymer", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "rhs_30Rnd_762x39mm_polymer_tracer", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_ak105_zenitco01_b33";
			case "rhs_weap_ak74m_zenitco01_b33";
			case "rhs_weap_ak74m_gp25_npz";
			case "rhs_weap_ak74mr_gp25";
			case "rhs_weap_rpk74m_npz": {
				[ player, "rhs_30Rnd_545x39_7N22_plum_AK", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_30Rnd_545x39_AK_plum_green", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_asval_grip_npz";
			case "rhs_weap_vss_grip_npz": {
				[ player, "rhs_20rnd_9x39mm_SP6", 6 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_20rnd_9x39mm_SP6", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_svdp_npz";
			case "rhs_weap_svds_npz": {
				[ player, "rhs_10Rnd_762x54mmR_7N1", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_10Rnd_762x54mmR_7N14", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_t5000": {
				[ player, "rhs_5Rnd_338lapua_t5000", 8 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_5Rnd_338lapua_t5000", 8 ] call pxg_armory_fnc_addToBackpack;
			};
			
			default {};
		};
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
		[ player, "rhs_18rnd_9x21mm_7N29", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sup_aa_g";
	case "sup_mat_g";
	case "sup_mmg_g";
	case "sqd_eng";
	case "rcn_spe": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
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
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellGreen", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellRed", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_grenade_khattabka_vog25_mag", 2 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_brc": {
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_zarya2", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_grenade_khattabka_vog25_mag", 2 ] call pxg_armory_fnc_addToVest;
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
