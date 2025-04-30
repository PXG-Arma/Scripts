params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		for "_i" from 1 to 4 do { player addItemToVest "hlc_30Rnd_556x45_B_AUG"};
		for "_i" from 1 to 4 do { player addItemToVest "hlc_30Rnd_556x45_T_AUG"};
	};
	case "sqd_ar": {
		for "_i" from 1 to 2 do { player addItemToVest "hlc_200rnd_556x45_B_SAW"};
		for "_i" from 1 to 2 do { player addItemToBackpack "hlc_200rnd_556x45_T_SAW"};
	};
	case "rcn_sni": {
		for "_i" from 1 to 8 do { player addItemToVest "hlc_5rnd_300WM_FMJ_AWM"};
		for "_i" from 1 to 8 do { player addItemToBackpack "hlc_5rnd_300WM_T_AWM"};
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		for "_i" from 1 to 4 do { player addItemToVest "hlc_25Rnd_9x19mm_M882_AUG"};
	};
};


// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		for "_i" from 1 to 2 do { player addItemToBackpack "hlc_200rnd_556x45_B_SAW"};
		for "_i" from 1 to 2 do { player addItemToBackpack "hlc_200rnd_556x45_T_SAW"};
	};
	case "sup_mat_l": {
		for "_i" from 1 to 1 do { player addItemToBackpack "BWA3_CarlGustav_HEDP"};
		for "_i" from 1 to 2 do { player addItemToBackpack "BWA3_CarlGustav_HEAT"};
	};
	case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_fim92_mag"};
	};
	case "sup_hat_l": {
		for "_i" from 1 to 1 do { player addItemToBackpack "rhs_fgm148_magazine_AT"};
	};
};
 
// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		for "_i" from 1 to 1 do { player addItemToBackpack "BWA3_CarlGustav_HEDP"};
		for "_i" from 1 to 2 do { player addItemToBackpack "BWA3_CarlGustav_HEAT"};
	};
	case "sup_aa_g": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_fim92_mag"};
	};
};

// add grenades
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellGreen"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt": {
		for "_i" from 1 to 5 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "UGL_FlareWhite_F"};
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		for "_i" from 1 to 10 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "UGL_FlareWhite_F"};
	};
};