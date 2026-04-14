// Welcome to the Faction Uniforms file, This should be called "Uniforms_FactionName"
// In this file you assign what which role wears. Uniform, Helmet, Vest, Mask and Backpacks.
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;

params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default {private _uniformPool = ["rhs_uniform_vkpo","rhs_uniform_vkpo_gloves"];
		     player forceaddUniform selectRandom _uniformPool;};
	case "r_pil": {player forceAddUniform "rhs_uniform_df15"};
	case "f_pil": {player forceAddUniform "rhs_uniform_df15_tan"};
};
	
// add helmet
switch (_loadout) do {
	default {private _helmetPool = ["rhs_6b47_emr","rhs_6b47_emr_1"];
		     player addHeadgear selectRandom _helmetPool;};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld": {player addHeadgear "rhs_Booniehat_digi"};
	case "sf_dmr";
	case "sf_ld";
	case "sf_med";
	case "sf_eng": {private _helmetPoolSF = ["rhs_altyn_bala","rhs_altyn","rhs_altyn_visordown"];
		           player addHeadgear selectRandom _helmetPoolSF;};
    case "ar_ld";
	case "ar_c": {player addHeadgear "rhs_6b48"};
	case "r_pil": {private _helmetPoolPilot = ["rhs_zsh7a_mike_green","rhs_zsh7a_mike_green_alt"];
		           player addHeadgear selectRandom _helmetPoolPilot;};
	case "f_pil": {player addHeadgear "rhs_zsh7a_alt"};
};

// add vest
switch (_loadout) do {
	default {private _vestPool = ["rhs_6b45_rifleman","rhs_6b45_rifleman_2"];
		     player addVest selectRandom _vestPool;};
	case "sup_mmg_l";
	case "sup_hmg_l";
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
	case "sup_mor_l": {player addBackpack "I_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "I_Mortar_01_weapon_F"};
	case "sup_hmg_l": {player addBackpack "RHS_Kord_Tripod_Bag"};
	case "sup_hmg_g": {player addBackpack "RHS_Kord_Gun_Bag"};
	case "sup_hat_l": {player addBackpack "RHS_Kornet_Tripod_Bag"};
	case "sup_hat_g": {player addBackpack "RHS_Kornet_Gun_Bag"};
	case "plt_med";
	case "sqd_med";
	case "sf_med";
	case "sup_mat_l";
	case "sup_mat_g";
	case "sup_mmg_l";
	case "sup_mmg_g";
	case "sup_aa_l";
	case "sup_aa_g";
	case "sup_hat_l";
	case "sup_hat_g": {player addBackpack "rhs_tortila_emr"};
	case "sqd_eng";
	case "logi": {player addBackpack "rhs_rk_sht_30_emr_engineer_empty"};
	case "rcn_sni";
	case "rcn_amr";
	case "rcn_drone";
	case "rcn_ld";
    case "ar_ld";
	case "ar_c";
	case "r_pil";
	case "f_pil": {player addBackpack "UK3CB_B_Invisible"};
};
