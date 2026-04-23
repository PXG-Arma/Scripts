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
	default {randomOfficerUniformArray = ["UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve"];
		     player forceAddUniform selectRandom randomOfficerUniformArray;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player forceAddUniform "UK3CB_BAF_U_CombatUniform_MTP_Ghillie_RM"};
	case "r_pil": {player forceAddUniform "UK3CB_BAF_U_HeliPilotCoveralls_Army"};
	case "f_pil": {player forceAddUniform "U_B_PilotCoveralls"};
};
	
// add helmet
switch (_loadout) do {
	default {randomOfficerHelmetArray = ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F"];
		     player addHeadgear selectRandom randomOfficerHelmetArray;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player addHeadgear "UK3CB_BAF_H_Mk7_Net_A"};
	case "sf_dmr";
	case "sf_ld";
	case "sf_med";
	case "sf_eng": {randomOfficerHelmetArray1 = ["UK3CB_BAF_H_Mk7_Scrim_A","UK3CB_BAF_H_Mk7_Scrim_B","UK3CB_BAF_H_Mk7_Scrim_C","UK3CB_BAF_H_Mk7_Scrim_D","UK3CB_BAF_H_Mk7_Scrim_E","UK3CB_BAF_H_Mk7_Scrim_F"];
		     player addHeadgear selectRandom randomOfficerHelmetArray1;};
    case "ar_ld";
	case "ar_c": {player addHeadgear "UK3CB_BAF_H_CrewHelmet_A"};
	case "r_pil": {randomOfficerHelmetArray2 = ["rhsusf_hgu56p_visor_mask_green_mo","rhsusf_hgu56p_visor_green"];
		           player addHeadgear selectRandom randomOfficerHelmetArray2;};
	case "f_pil": {player addHeadgear "H_PilotHelmetFighter_B"};
};

// add vest
switch (_loadout) do {
	default {player addVest "UK3CB_BAF_V_Osprey_Rifleman_B"};
	case "sup_mmg_l";
	case "sup_hmg_l";
	case "sup_gmg_l";
	case "sup_mat_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "sup_mor_l";
	case "plt";
	case "logi";
	case "tacp";
	case "rcn_ld";
	case "sf_ld";
	case "sqd_ld": {player addVest "UK3CB_BAF_V_Osprey_SL_C"};
	case "sqd_gre": {player addVest "UK3CB_BAF_V_Osprey_Grenadier_B"};
	case "sf_med";
	case "plt_med";
	case "sqd_med": {player addVest "UK3CB_BAF_V_Osprey_Medic_B"};
	case "sqd_ar";
	case "sup_mmg_g": {player addVest "UK3CB_BAF_V_Osprey_MG_B"};
	case "sf_dmr";
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone": {player addVest "UK3CB_BAF_V_Osprey_Rifleman_B"};
	case "r_pil": {player addVest "UK3CB_BAF_V_Osprey_Belt_A"};
	case "f_pil": {player addVest "UK3CB_V_Invisible"};
};

// add mask
switch (_loadout) do {
	case "r_pil";
	case "f_pil": {player addGoggles "None"};
};

// add backpack 
switch (_loadout) do {
	default {player addBackpack "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"};
	case "tacp": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_JTAC_L_A"};
	case "plt_med";
	case "sqd_med";
	case "sf_med": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_Medic_L_B"};
	case "plt_eod";
	case "sqd_eng": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_Sapper_L_A"};
	case "logi": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_Engineer_L_A"};
	case "sqd_brc": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_PointMan_L_A"};
	case "rcn_ld";
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone": {player addBackpack "UK3CB_B_Invisible"};
	case "sup_aa_l";
	case "sup_aa_g";
	case "sup_hat_l";
	case "sup_hat_g": {player addBackpack "UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B"};
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