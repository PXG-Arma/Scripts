params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
		default {
		randomUniformArray = ["UK3CB_NAP_B_U_Officer_Uniform_GRN","UK3CB_NAP_B_U_Officer_Uniform_GRN_BLK","UK3CB_ION_B_U_SF_Uniform_Short_Shirt_08_WDL","rhs_uniform_gorka_r_g_gloves","rhs_uniform_gorka_r_y_gloves"];
		player forceAddUniform selectRandom randomUniformArray;
	};
};
	
// add helmet
switch (_loadout) do {
	default default {
		randomHelmetArray = ["rhs_altyn_visordown","rhs_altyn","rhsusf_opscore_fg","rhsusf_opscore_fg_pelt","rhs_beanie_green","rhs_6m2_1"];
		player addHeadgear selectRandom randomHelmetArray;
	};
};

// add vest
switch (_loadout) do {
	default { player addVest "UK3CB_V_MBAV_RIFLEMAN_OLI"};
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": { player addVest "UK3CB_V_MBAV_GRENADIER_OLI"};
	case "sqd_med";
	case "rcn_spe": { player addVest "UK3CB_V_MBAV_MEDIC_OLI"};
	case "sup_mmg_g": { player addVest "UK3CB_V_MBAV_MG_OLI"};
	case "pil": { player addVest "UK3CB_V_MBAV_LIGHT_OLI"};
};

// add eyewear
switch (_loadout) do {
	default {
		randomGoggleArray = ["UK3CB_G_Tactical_Black_Shemagh_Green_Headset","UK3CB_G_Tactical_Black_Shemagh_Tan","UK3CB_G_Ballistic_Black_Shemagh_Green","UK3CB_G_Tactical_Black"];
		player addGoggles selectRandom randomGoggleArray;
	};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "rhs_assault_umbts"};
	case "logi";
	case "sqd_eng";
	case "rcn_spe": {player addBackpack "rhs_assault_umbts_engineer_empty"};
	case "sup_mmg_l";
	case "sup_mmg_g": {player addBackpack "rhs_tortila_olive"};
	case "pil": {};
};