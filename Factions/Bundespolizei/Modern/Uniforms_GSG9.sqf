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
	default {
		randomUniformArray = ["VSM_OGA_Crye_grey_tan_pants_Camo","VSM_OGA_Crye_grey_Camo", "VSM_OGA_Crye_SS_Camo"];
		 player forceAddUniform selectRandom randomUniformArray;
		 player addGoggles "VSM_balaclava_Black";
	};
	case "r_pil": {player forceAddUniform "BWA3_Uniform_Helipilot"};
	case "r_pil": {player addGoggles ""};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player forceAddUniform "U_B_FullGhillie_sard"};
};
	
// add helmet
switch (_loadout) do {
	default {
		randomHelmetArray = ["VSM_fast_helmet_covermcblack", "BWA3_OpsCore_FastMT_Peltor", "VSM_fasthelmet_coveraor1"];
		 player addHeadgear selectRandom randomHelmetArray;
	};
	case "pil": {player addHeadgear "H_PilotHelmetHeli_B"};
};

// add vest
switch (_loadout) do {
	default {
		 player addVest "UK3CB_ANP_B_V_TacVest_Tan"};
	case "sqd_med";
	case "plt_med": {player addVest "V_PlateCarrier1_blk"};
	case "rcn_sni";
	case "rcn_amr": {player addVest "VSM_OGA_Vest_2"};
	case "r_pil": { player addVest "UK3CB_V_Invisible"};
};

// add backpack 
switch (_loadout) do {
	default {
		 player addBackpack "VSM_OGA_Backpack_Compact"};
	case "sqd_med";
	case "plt_med";
	case "rcn_spe": {player addBackpack "UK3CB_ION_B_B_RIF_MED_BRN"};
	case "r_pil": {};
	case "plt_eod";
	case "rcn_ld": {player addBackpack "UK3CB_TKA_O_B_RIF_Tan_Radio"};
};

