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
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag"};
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red"};
	};
	case "sqd_hgre": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag"};
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red"};
		for "_i" from 1 to 6 do { player addItemToBackpack "UK3CB_BAF_1Rnd_60mm_Mo_Shells"};
		for "_i" from 1 to 2 do { player addItemToBackpack "UK3CB_BAF_1Rnd_60mm_Mo_Smoke_White"}
	};
	case "sqd_ar": {
		for "_i" from 1 to 2 do { player addItemToVest "UK3CB_BAF_556_200Rnd"};
		for "_i" from 1 to 3 do { player addItemToBackpack "UK3CB_BAF_556_200Rnd_T"};
	};
	case "sqd_brc": {
		for "_i" from 1 to 8 do { player addItemToVest "UK3CB_BAF_12G_Pellets"};
		for "_i" from 1 to 12 do { player addItemToBackpack "UK3CB_BAF_12G_Slugs"};
	};
	case "sf_dmr": {
		for "_i" from 1 to 5 do { player addItemToVest "UK3CB_BAF_762_L42A1_20Rnd"};
		for "_i" from 1 to 5 do { player addItemToBackpack "UK3CB_BAF_762_L42A1_20Rnd_T"};
	};
	case "sf_med": {
		for "_i" from 1 to 2 do { player addItemToVest "UK3CB_BAF_556_200Rnd"};
		for "_i" from 1 to 2 do { player addItemToBackpack "UK3CB_BAF_556_200Rnd_T"};
	};
	case "rcn_sni": {
		for "_i" from 1 to 10 do { player addItemToVest "UK3CB_BAF_338_5Rnd"};
		for "_i" from 1 to 10 do { player addItemToBackpack "UK3CB_BAF_338_5Rnd_Tracer"};
	};
	case "rcn_amr": {
		for "_i" from 1 to 6 do { player addItemToVest "ACE_5Rnd_127x99_AMAX_Mag"};
		for "_i" from 1 to 12 do { player addItemToBackpack "ACE_5Rnd_127x99_API_Mag"};
	};
	case "sup_mmg_g": {
		for "_i" from 1 to 2 do { player addItemToVest "UK3CB_BAF_762_200Rnd"};
		for "_i" from 1 to 3 do { player addItemToBackpack "UK3CB_BAF_762_200Rnd_T"};
	};
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
	case "sup_hat_l";
	case "sup_hat_g";
	case "sup_mor_l";
	case "sup_mor_g": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag"};
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red"};
	};
	case "ar_ld";
	case "ar_c";
	case "r_pil": {
		for "_i" from 1 to 4 do { player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag"};
	};
	case "f_pil": {
		for "_i" from 1 to 2 do { player addItemToUniform "rhs_mag_30Rnd_556x45_M855_Stanag"};
	};
};

// add secondary ammo
switch (_loadout) do {
	default {for "_i" from 1 to 2 do { player addItemToUniform "UK3CB_BAF_9_17Rnd"};};
	case "sqd_eng";
	case "sf_eng": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		for "_i" from 1 to 4 do { player addItemToBackpack "rhsusf_200rnd_556x45_mixed_box"};
	};
	case "sup_mmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "UK3CB_BAF_762_200Rnd_T"};
	};
	case "sup_hmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "ace_csw_100Rnd_127x99_mag_red"};
	};
	case "sup_gmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "ace_compat_rhs_usf3_48Rnd_40mm_MK19"};
		for "_i" from 1 to 3 do { player addItemToBackpack "ace_compat_rhs_usf3_48Rnd_40mm_MK19_M430A1"};
	};
	case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_fim92_mag"};
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
		for "_i" from 1 to 3 do { player addItemToBackpack "ace_csw_100Rnd_127x99_mag_red"};
	};
	case "sup_gmg_g": {
		for "_i" from 1 to 4 do { player addItemToBackpack "ace_compat_rhs_usf3_48Rnd_40mm_MK19"};
		for "_i" from 1 to 3 do { player addItemToBackpack "ace_compat_rhs_usf3_48Rnd_40mm_MK19_M430A1"};
	};
	case "sup_aa_g": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_fim92_mag"};
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
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
	};
	case "sqd_ld";
	case "rcn_ld";
	case "sf_ld";
	case "tacp";
	case "plt": {
		for "_i" from 1 to 2 do { player addItemToVest "SmokeShell"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellBlue"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
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
		for "_i" from 1 to 5 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeBlue_Grenade_shell"};
	};

	case "rcn_drone": {
		for "_i" from 1 to 5 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeBlue_Grenade_shell"};
		for "_i" from 1 to 8 do {player addItemToBackpack "ACE_HuntIR_M203"};
	};
	
	case "sqd_gre": {
		for "_i" from 1 to 10 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeBlue_Grenade_shell"};
	};
};