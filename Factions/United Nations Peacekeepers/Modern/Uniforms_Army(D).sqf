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
	default {player forceAddUniform "UK3CB_UN_I_U_CombatUniform_TTSKO"};
	case "logi": { player forceAddUniform "UK3CB_UN_I_U_Field_Operative"};
	case "sf_med";
	case "sf_dmr";
	case "sf_ld";
	case "sf_eng";
	case "rcn_drone";
	case "rcn_ld";
	case "rcn_sni";
	case "rcn_amr": { player forceAddUniform "UK3CB_UN_B_U_H_Pilot_TTSKO"};
	case "r_pil": {player forceAddUniform "UK3CB_UN_B_U_H_Pilot_TTSKO"};
	case "f_pil": {player forceAddUniform "U_B_PilotCoveralls"};
};
	
// add helmet
switch (_loadout) do {
	default {randomOfficerHelmetArray = ["UK3CB_UN_B_H_6b27m","UK3CB_UN_B_H_6b27m_Cov"];
		     player addHeadgear selectRandom randomOfficerHelmetArray;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone": {player addHeadgear "UK3CB_BAF_H_Beret_UN"};
	case "rcn_ld": {player addHeadgear "UK3CB_BAF_H_Beret_UN_Officer_PRR"};
    case "ar_ld";
	case "ar_c": {player addHeadgear "rhs_tsh4"};
	case "r_pil": {randomOfficerHelmetArray1 = ["rhs_zsh7a_mike_alt","rhs_zsh7a_mike"];
		           player addHeadgear selectRandom randomOfficerHelmetArray1;};
	case "f_pil": {player addHeadgear "H_PilotHelmetFighter_B"};
};

// add vest
switch (_loadout) do {
	default {player addVest "UK3CB_UN_I_V_6b23_ml_02"};
	case "sup_mmg_l";
	case "sup_aa_l";
	case "rcn_ld";
	case "logi";
	case "plt";
	case "tacp";
	case "sf_ld";
	case "sqd_ld": {player addVest "UK3CB_UN_B_V_6b23_ML_6sh92_radio"};
	case "sqd_gre": {player addVest "UK3CB_UN_B_V_6b23_ml_6sh92_vog"};
	case "sf_med";
	case "plt_med";
	case "sqd_med": {player addVest "UK3CB_UN_B_V_6b23_medic"};
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_hat_l";
	case "sup_hat_g";
	case "sup_mor_l";
	case "sup_mor_g": {player addVest "UK3CB_UN_B_V_6b23_ml_6sh92_vog"};
	case "r_pil": {player addVest "UK3CB_UN_B_V_6b23_vydra_3m"};
	case "f_pil": {player addVest "UK3CB_V_Invisible"};
};

// add mask
switch (_loadout) do {
	case "r_pil";
	case "f_pil": {player addGoggles "None"};
};

// add backpack 
switch (_loadout) do {
	default {player addBackpack "UK3CB_UN_B_B_ASS"};
	case "plt_med";
	case "sqd_med";
	case "sf_med";
	case "sup_mat_l";
	case "sup_mat_g";
	case "sup_mmg_l";
	case "sup_mmg_g";
	case "sup_aa_l";
	case "sup_aa_g": {player addBackpack "B_Carryall_cbr"};
	case "sup_mor_l";
	case "sup_mor_g";
	case "sup_hat_l";
	case "sup_hat_g";
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
	case "logi";
	case "rcn_ld";
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
    case "ar_ld";
	case "ar_c";
	case "r_pil";
	case "f_pil": {player addBackpack "UK3CB_B_Invisible"};
};