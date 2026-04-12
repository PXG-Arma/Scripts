// Welcome to the Faction Uniforms file, This should be called "Uniforms_FactionName"
// In this file you assign what which role wears. Uniform, Helmet, Vest, Mask and Backpacks.
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// case "plt";
// case "logi";
// case "plt_eod";
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
	default {player forceAddUniform "rhs_uniform_cu_ocp"};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player forceAddUniform "U_B_FullGhillie_ard"};
	case "r_pil": {player forceAddUniform "rhs_uniform_cu_ocp_1stcav"};
	case "f_pil": {player forceAddUniform "U_B_PilotCoveralls"};
};

// add helmet
switch (_loadout) do {
	default {randomOfficerHelmetArray = ["rhsusf_ach_helmet_headset_ocp_alt","rhsusf_ach_helmet_headset_ocp"];
		     player addHeadgear selectRandom randomOfficerHelmetArray;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player addHeadgear "rhsusf_ach_helmet_camo_ocp"};
	case "sf_dmr";
	case "sf_ld";
	case "sf_med";
	case "sf_eng": {player addHeadgear "rhsusf_ach_helmet_camo_ocp"};
    case "ar_ld";
	case "ar_c": {player addHeadgear "rhsusf_cvc_ess"};
	case "r_pil": {randomOfficerHelmetArray1 = ["rhsusf_hgu56p_visor_mask_Empire_black","rhsusf_hgu56p_visor_black","rhsusf_hgu56p_visor_mask_black_skull"];
		           player addHeadgear selectRandom randomOfficerHelmetArray1;};
	case "f_pil": {player addHeadgear "H_PilotHelmetFighter_B"};
};

// add vest
switch (_loadout) do {
	default {player addVest "rhsusf_spcs_ocp_rifleman_alt"};
	case "sup_mmg_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "sup_mor_l";
	case "rcn_ld";
	case "sf_ld";
	case "sqd_ld": {player addVest "rhsusf_spcs_ocp_squadleader"};
	case "plt";
	case "logi";
	case "plt_eod";
	case "tacp": {player addVest "rhsusf_spcs_ocp_teamleader_alt"};
	case "sqd_ar": {player addVest "rhsusf_spcs_ocp_saw"};
	case "sqd_gre": {player addVest "rhsusf_spcs_ocp_grenadier"};
	case "sf_med";
	case "plt_med";
	case "sqd_med": {player addVest "rhsusf_spcs_ocp_medic"};
	case "sup_mmg_g": {player addVest "rhsusf_spcs_ocp_machinegunner"};
	case "sf_dmr";
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone": {player addVest "rhsusf_spcs_ocp_sniper"};
	case "r_pil": {player addVest "rhsusf_spcs_ocp"};
	case "f_pil": {player addVest "UK3CB_V_Invisible"};
};

// add mask
switch (_loadout) do {
	case "r_pil";
	case "f_pil": {player addGoggles "None"};
};

// add backpack 
switch (_loadout) do {
	default {player addBackpack "rhsusf_assault_eagleaiii_ocp"};
	case "plt_med";
	case "sqd_med";
	case "sf_med";
	case "sup_mmg_l";
	case "sup_mmg_g";
	case "sup_aa_l";
	case "sup_aa_g";
	case "sup_hat_l";
	case "sup_hat_g": {player addBackpack "VSM_OCP_carryall"};
	case "sup_mor_l";
	case "sup_mor_g";
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
    case "ar_ld";
	case "ar_c";
	case "r_pil";
	case "f_pil": {player addBackpack "UK3CB_B_Invisible"};
};