params["_side","_faction","_variant", "_loadout"]; 
randomOfficerUniformArray = ["LOP_U_PMC_red_hi","LOP_U_PMC_blue_hi"];
randomUniformArray = ["UK3CB_ADM_B_U_Shirt_Pants_01_BLU_WDL_ALT", "UK3CB_ADM_B_U_Shirt_Pants_01_BLU_WDL", "UK3CB_LNM_B_U_Shirt_Pants_05", "UK3CB_LNM_B_U_Shirt_Pants_06", "UK3CB_LNM_B_U_Shirt_Pants_07", "UK3CB_LNM_B_U_Shirt_Pants_08", "UK3CB_LNM_B_U_Shirt_Pants_09", "UK3CB_LNM_B_U_Shirt_Pants_10", "UK3CB_LNM_B_U_Shirt_Pants_11", "UK3CB_LNM_B_U_Shirt_Pants_12", "UK3CB_ADM_B_U_Shirt_Pants_01_GRN_WDL_ALT", "UK3CB_ADM_B_U_Shirt_Pants_01_GRN_WDL", "UK3CB_LNM_B_U_Shirt_Pants_13", "UK3CB_LNM_B_U_Shirt_Pants_14", "UK3CB_LNM_B_U_Shirt_Pants_15", "UK3CB_LNM_B_U_Shirt_Pants_16", "UK3CB_LNM_B_U_Shirt_Pants_01", "UK3CB_LNM_B_U_Shirt_Pants_02", "UK3CB_LNM_B_U_Shirt_Pants_03", "UK3CB_LNM_B_U_Shirt_Pants_04"];


// add uniform
switch (_loadout) do {
	default { 
		player forceAddUniform selectRandom randomUniformArray;
	};
	case "plt";
	case "logi";
	case "tacp";
	case "sqd_ld";
	case "sup_mmg_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "sup_mor_l";
	case "rcn_ld";
	case "ar_ld";
	case "pil": {player forceAddUniform selectRandom randomOfficerUniformArray};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "rhsusf_opscore_bk_pelt"};
	case "sqd_dmr";
	case "rcn_dmr";
	case "rcn_sni";
	case "rcn_amr": {player addHeadgear "H_Watchcap_blk"};
	case "pil": {player addHeadgear "UK3CB_BAF_H_PilotHelmetHeli_A"};
};

// add vest
switch (_loadout) do {
	default {player addVest "dr_BLKlbt_op"};
	case "plt";
	case "logi";
	case "tacp";
	case "sqd_ld";
	case "sup_mmg_l";
	case "sup_hat_l";
	case "sup_mor_l";
	case "sup_aa_l";
	case "rcn_ld": {player addVest "dr_BLKpar_op"};
	case "sqd_dmr";
	case "rcn_dmr";
	case "rcn_sni";
	case "rcn_amr";
	case "pil": {player addVest "dr_BLKfacp_op"};
	case "sqd_hgre";
	case "sqd_ar";
	case "sup_mmg_g": {player addVest "dr_BLKpar_mg"};
	case "sqd_brc": {player addVest "dr_BLKfacp_br"};	
	case "sqd_aar": {player addVest "dr_BLKfacp_mg"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "Black_Backpack_kitbag"};
	case "sup_mor_l": {player addBackpack "B_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "B_Mortar_01_weapon_F"};
	case "pil": {};
};
