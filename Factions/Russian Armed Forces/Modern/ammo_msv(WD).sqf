// Welcome to the Faction Ammo file, This should be called "Ammo_FactionName"
// In this file you assign which role gets what ammo
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// When using randomized weapons, ammo can also be assigned using:
// {
//        switch (primaryWeapon player) do {
//             case "WeaponName": {
//                 for "_i" from 1 to 4 do { player addItemToVest "AmmoType"; };
//                 for "_i" from 1 to 4 do { player addItemToBackpack "AmmoType"; };
//             };
// 			case "WeaponName2": {
//                 for "_i" from 1 to 4 do { player addItemToVest "AmmoType"; };
//                 for "_i" from 1 to 4 do { player addItemToBackpack "AmmoType"; };
//             };
// 		};
// };
// This can be put directly into the -default {}			

sleep 0.5 // for some reason it might randomly assign a mag to the uniform without this
params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 

switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_30Rnd_545x39_7N10_plum_AK"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_30Rnd_545x39_7N10_plum_AK"};
		for "_i" from 1 to 4 do { player addItemToVest "rhs_30Rnd_545x39_AK_plum_green"};
	};
	case "sqd_ar": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_60Rnd_545X39_7N10_AK"};
		for "_i" from 1 to 4 do { player addItemToBackpack "rhs_60Rnd_545X39_AK_Green"};
	};
	case "sqd_brc": {
		for "_i" from 1 to 6 do { player addItemToVest "uk3cb_saiga_10rnd_12g_buckshot_magazine"};
		for "_i" from 1 to 8 do { player addItemToBackpack "uk3cb_saiga_10rnd_12g_slug_magazine"};
	};
	case "sf_dmr": {
		for "_i" from 1 to 10 do { player addItemToVest "UK3CB_SVD_10rnd_762x54"};
		for "_i" from 1 to 10 do { player addItemToBackpack "UK3CB_SVD_10rnd_762x54_GT"};
	};
	case "sf_med": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_60Rnd_545X39_7N10_AK"};
		for "_i" from 1 to 4 do { player addItemToBackpack "rhs_60Rnd_545X39_AK_Green"};
	};
	case "rcn_sni": {
		for "_i" from 1 to 10 do { player addItemToVest "rhs_5Rnd_338lapua_t5000"};
		for "_i" from 1 to 15 do { player addItemToBackpack "rhs_5Rnd_338lapua_t5000"};
	};
	case "sup_mmg_g": {
		for "_i" from 1 to 1 do { player addItemToVest "rhs_100Rnd_762x54mmR_green"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_100Rnd_762x54mmR_green"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_100Rnd_762x54mmR_7N13"};
	};
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
	case "sup_hat_l";
	case "sup_hat_g";
	case "sup_mor_l";
	case "sup_mor_g": {
		for "_i" from 1 to 3 do { player addItemToVest "rhs_30Rnd_545x39_7N10_plum_AK"};
		for "_i" from 1 to 4 do { player addItemToVest "rhs_30Rnd_545x39_AK_plum_green"};
	};
	case "ar_ld";
	case "ar_c";
	case "f_pil";
	case "r_pil": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_30Rnd_545x39_7N10_plum_AK"};
	};
	case "f_pil"
};

// add secondary ammo
switch (_loadout) do {
	default {for "_i" from 1 to 1 do { player addItemToUniform "rhs_mag_9x19_17"};};
	case "sqd_eng";
	case "sf_eng": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		for "_i" from 1 to 4 do { player addItemToBackpack "rhs_60Rnd_545X39_AK_Green"};
	};
	case "sup_mmg_l": {
		for "_i" from 1 to 3 do { player addItemToBackpack "rhs_100Rnd_762x54mmR_green"};
	};
	case "sup_hmg_l": {
		for "_i" from 1 to 4 do { player addItemToBackpack "ace_csw_50Rnd_127x108_mag"};
	};
	case "sup_gmg_l": {
		for "_i" from 1 to 4 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_VOG30_30"};
	};
	case "sup_mat_l": {
		for "_i" from 1 to 3 do { player addItemToBackpack "rhs_rpg7_PG7V_mag"};
		for "_i" from 1 to 3 do { player addItemToBackpack "rhs_rpg7_OG7V_mag"};
	};
	case "sup_hat_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_9m1331"};
		for "_i" from 1 to 2 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_9m133f"};
	};
	case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_mag_9k38_rocket"};
	};
	case "sup_mor_l": {
		for "_i" from 1 to 4 do { player addItemToBackpack "ACE_1Rnd_82mm_Mo_HE"};
		for "_i" from 1 to 1 do { player addItemToBackpack "ACE_1Rnd_82mm_Mo_Smoke"};
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_hmg_g": {
		for "_i" from 1 to 6 do { player addItemToBackpack "ace_csw_50Rnd_127x108_mag"};
	};
	case "sup_gmg_g": {
		for "_i" from 1 to 6 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_VOG30_30"};
	};
	case "sup_mat_g": {
		for "_i" from 1 to 3 do { player addItemToBackpack "rhs_rpg7_PG7V_mag"};
		for "_i" from 1 to 3 do { player addItemToBackpack "rhs_rpg7_OG7V_mag"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_rpg7_PG7VL_mag"};
	};
	case "sup_hat_g": {
		for "_i" from 1 to 3 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_9m1331"};
		for "_i" from 1 to 2 do { player addItemToBackpack "ace_compat_rhs_afrf3_mag_9m133f"};
	};
	case "sup_aa_g": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_mag_9k38_rocket"};
	};
	case "sup_mor_g": {
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_1Rnd_82mm_Mo_HE"};
		for "_i" from 1 to 1 do { player addItemToBackpack "ACE_1Rnd_82mm_Mo_Smoke"};
	};
};

// add grenades
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "SmokeShell"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellBlue"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rgd5"};
	};
	case "sqd_ld";
	case "rcn_ld";
	case "sf_ld";
	case "tacp";
	case "plt": {
		for "_i" from 1 to 2 do { player addItemToVest "SmokeShell"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellBlue"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rgd5"};
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "sqd_ld";
	case "sf_ld";
	case "rcn_ld";
	case "tacp";
	case "sup_mmg_l";
	case "sup_hmg_l";
	case "sup_gmg_l";
	case "sup_mat_l";
	case "sup_hat_l";
	case "sup_mor_l";
	case "sup_aa_l";
	case "plt": {
		for "_i" from 1 to 5 do {player addItemToBackpack "rhs_VOG25"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_White"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Red"};
	};

	case "rcn_drone": {
		for "_i" from 1 to 5 do {player addItemToBackpack "rhs_VOG25"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_White"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Red"};
	};
	
	case "sqd_gre": {
		for "_i" from 1 to 10 do {player addItemToBackpack "rhs_VOG25"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_White"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Red"};
	};
};