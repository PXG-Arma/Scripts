params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "sfp_m90w_uniform"};
	case "plt": {player forceAddUniform "sfp_m90w_uniform_folded"};
	case "ar_ld";
	case "ar_c": {player forceAddUniform "sfp_m90w_uniform_fs18"};
	case "pil";
	case "hpil": {player forceAddUniform "sfp_m87_flying_suit"};

};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "sfp_m90w_helmet"};
	case "logi";
	case "plt": { player addHeadgear "sfp_m90w_booniehat"};
	case "rcn_ld";
	case "sqd_ld": {player addHeadgear "sfp_m90w_helmet_peltor_nvg"};
	case "ar_ld";
	case "ar_c": {player addHeadgear "sfp_telehelmet_2"};
	case "pil": { player addHeadgear "sfp_flighthelmet116"};	
	case "hpil": { player addHeadgear "BWA3_CrewHelmet_NH90"};

};

// add vest
switch (_loadout) do {
	default { player addVest "sfp_kroppsskydd12"};
	case "sqd_ld";
	case "plt";
	case "logi": { player addVest "sfp_kroppsskydd12_tl"};
	case "rcn_spe";
	case "plt_med";
	case "sqd_med": { player addVest "sfp_kroppsskydd12_medic"};
	case "sup_mmg_g";
	case "sqd_ar": { player addVest "sfp_kroppsskydd12_mg"};
	case "ar_ld";
	case "ar_c": { player addVest "sfp_kroppsskydd12_crew"};
	case "hpil";
	case "pil": { player addVest "UK3CB_V_Invisible"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "UK3CB_ION_B_B_RIF_OLI_01"};
	case "plt_med";
	case "sqd_med": {player addBackpack "UK3CB_ION_B_B_RIF_MED_OLI"};
	case "plt";
	case "sqd_ld";
	case "rcn_ld";
	case "sup_mat_l": {player addBackpack "sfp_stridssack2000_ra_ksk90"};
	case "sup_mat_g": {player addBackpack "sfp_backpack_grg_loader"};
	case "sup_mor_l": {player addBackpack "I_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "I_Mortar_01_weapon_F"};
	case "sup_aa_l": {player addBackpack "sfp_rbs70_support_bag"};
	case "sup_aa_g": {player addBackpack "sfp_rbs70_weapon_bag"};
	case "hpil";
	case "pil": {player addBackpack "UK3CB_B_Invisible"};
	case "ar_ld";
	case "ar_c": {player addBackpack "sfp_stridssele_backpack"};
};

// add Facewear
switch (_loadout) do {
	default {};
	case "plt_med";
	case "sqd_med": {player addGoggles "sfp_armband_medic_white"};
}
