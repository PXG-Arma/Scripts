// Welcome to the Faction Uniforms file, This should be called "Uniforms_FactionName"
// In this file you assign what which role wears. Uniform, Helmet, Vest, Mask and Backpacks.
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// case "plt";
// case "logi";
// case "plt_med";
// case "tacp";
// case "sqd_ld";
// case "sqd_med";
// case "sqd_eng";
// case "sqd_lat";
// case "sqd_brc";
// case "sqd_gre";
// case "sqd_hgre";
// case "sqd_ar";
// case "sqd_aar";
// case "sf_ld";
// case "sf_med";
// case "sf_dmr";
// case "sf_eng";
// case "rcn_ld";
// case "rcn_sni";
// case "rcn_amr";
// case "rcn_drone";
// case "sup_mmg_l";
// case "sup_mmg_g";
// case "sup_hmg_l";
// case "sup_hmg_g";
// case "sup_mat_l";
// case "sup_mat_g";
// case "sup_hat_l";
// case "sup_hat_g";
// case "sup_aa_l";
// case "sup_aa_g";
// case "sup_mor_l";
// case "sup_mor_g";
// case "ar_ld";
// case "ar_c";
// case "r_pil";
// case "f_pil";

params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default {randomOfficerUniformArray = ["rhs_uniform_vkpo","rhs_uniform_vkpo_gloves"];
		     player forceaddUniform selectRandom randomOfficerUniformArray;};
	case "r_pil": {player forceAddUniform "rhs_uniform_df15"};
	case "f_pil": {player forceAddUniform "rhs_uniform_df15_tan"};
};
	
// add helmet
switch (_loadout) do {
	default {randomOfficerHelmetArray = ["rhs_6b47_emr","rhs_6b47_emr_1"];
		     player addHeadgear selectRandom randomOfficerHelmetArray;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player addHeadgear "rhs_Booniehat_digi"};
	case "sf_dmr";
	case "sf_ld";
	case "sf_med";
	case "sf_eng": {randomOfficerHelmetArray1 = ["rhs_altyn_bala","rhs_altyn","rhs_altyn_visordown"];
		           player addHeadgear selectRandom randomOfficerHelmetArray1;};
    case "ar_ld";
	case "ar_c": {player addHeadgear "rhs_6b48"};
	case "r_pil": {randomOfficerHelmetArray2 = ["rhs_zsh7a_mike_green","rhs_zsh7a_mike_green_alt"];
		           player addHeadgear selectRandom randomOfficerHelmetArray2;};
	case "f_pil": {player addHeadgear "rhs_zsh7a_alt"};
};

// add vest
switch (_loadout) do {
	default {randomOfficerVestArray = ["rhs_6b45_rifleman","rhs_6b45_rifleman_2"];
		     player addVest selectRandom randomOfficerVestArray;};
	case "sup_mmg_l";
	case "sup_hmg_l";
	case "sup_gmg_l";
	case "sup_mat_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "sup_mor_l";
	case "ar_ld";
	case "rcn_ld";
	case "sf_ld";
	case "sqd_ld";
	case "plt";
	case "logi";
	case "tacp": {player addVest "rhs_6b45_off"};
	case "sup_mmg_g";
	case "sup_hmg_g";
	case "sqd_ar": {player addVest "rhs_6b45_mg"};
	case "sqd_gre": {player addVest "rhs_6b45_grn"};
	case "sf_med";
	case "plt_med";
	case "sqd_med": {player addVest "rhs_6b23_digi_medic"};
	case "r_pil";
	case "f_pil": {player addVest "UK3CB_V_Invisible"};
};

// add mask
switch (_loadout) do {
	case "r_pil";
	case "f_pil": {player addGoggles "None"};
};

// add backpack 
switch (_loadout) do {
	default {player addBackpack "rhs_rk_sht_30_emr"};
	case "plt_med";
	case "sqd_med";
	case "sf_med";
	case "sup_mat_l";
	case "sup_mat_g";
	case "sup_mmg_l";
	case "sup_mmg_g";
	case "sup_aa_l";
	case "sup_aa_g": {player addBackpack "rhs_tortila_emr"};
	case "plt_eod";
	case "sqd_eng";
	case "logi": {player addBackpack "rhs_rk_sht_30_emr_engineer_empty"};
	case "sup_mor_l";
	case "sup_mor_g";
	case "sup_hat_l";
	case "sup_hat_g";
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld";
    case "ar_ld";
	case "ar_c";
	case "r_pil";
	case "f_pil": {player addBackpack "UK3CB_B_Invisible"};
};