params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		for "_i" from 1 to 4 do { player addItemToVest "sfp_30Rnd_556x45_Stanag_plastic"};
		for "_i" from 1 to 4 do { player addItemToBackpack "sfp_30Rnd_556x45_Stanag_tracer_plastic"};
	};
	case "sqd_ar": {
		for "_i" from 1 to 2 do { player addItemToVest "sfp_200Rnd_556x45_ksp90"};
		for "_i" from 1 to 2 do { player addItemToBackpack "sfp_200Rnd_556x45_ksp90_irtracer"};
	};
	case "rcn_dmr": {
		for "_i" from 1 to 4 do { player addItemToBackpack "hlc_5rnd_300WM_AP_AWM"};
		for "_i" from 1 to 4 do { player addItemToBackpack "hlc_5rnd_300WM_T_AWM"}
	};
	case "sup_mmg_g": {
		for "_i" from 1 to 2 do { player addItemToVest "rhsusf_100Rnd_762x51_m80a1epr"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m62_tracer"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m61_ap"};
		
	};
	case "ar_ld";
	case "ar_c";
	case "hpil";
	case "pil": {
		for "_i" from 1 to 4 do { player addItemToVest "hlc_30Rnd_9x19_B_MP5"};
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToUniform "sfp_17Rnd_9x19_Mag"};
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		for "_i" from 1 to 2 do { player addItemToBackpack "sfp_200Rnd_556x45_ksp90"};
		for "_i" from 1 to 2 do { player addItemToBackpack "sfp_200Rnd_556x45_ksp90_irtracer"};
	};
	case "sup_mmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m62_tracer"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m80a1epr"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m61_ap"};
	};
	case "sup_mat_l": {
		for "_i" from 1 to 1 do { player addItemToBackpack "BWA3_CarlGustav_HEDP"};
		for "_i" from 1 to 2 do { player addItemToBackpack "BWA3_CarlGustav_HEAT"};
	};
	case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "BWA3_Fliegerfaust_Mag"};
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		for "_i" from 1 to 1 do { player addItemToBackpack "BWA3_CarlGustav_HEDP"};
		for "_i" from 1 to 2 do { player addItemToBackpack "BWA3_CarlGustav_HEAT"};
	};
};

// add grenades
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "BWA3_DM25"};
		for "_i" from 1 to 1 do { player addItemToVest "BWA3_DM32_Blue"};
		for "_i" from 1 to 1 do { player addItemToVest "BWA3_DM32_Green"};
		for "_i" from 1 to 1 do { player addItemToVest "BWA3_DM32_Red"};
		for "_i" from 1 to 2 do { player addItemToVest "sfp_handgrenade_shgr07"};
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