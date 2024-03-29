params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "m93_m98"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "opscorem98c"};
    case "ar_ld";
	case "ar_c": {player addHeadgear "H_HelmetCrew_I"};
	case "rcn_spe";
	case "rcn_ld";
	case "rcn_dmr";
	case "rcn_drone": {player addHeadgear "H_Booniehat_oli"};
};

// add vest
switch (_loadout) do {
	default { player addVest "UK3CB_V_MBAV_RIFLEMAN_OLI"};
	case "plt";
	case "logi";
	case "tacp";
	case "sqd_ld";
	case "sqd_gre": {player addVest "UK3CB_V_MBAV_GRENADIER_OLI"};
	case "rcn_spe";
	case "sqd_med": {player addVest "UK3CB_V_MBAV_MEDIC_OLI"};
	case "sqd_ar": {player addVest "UK3CB_V_MBAV_MG_OLI"};
	case "sup_mmg_g": {player addVest "UK3CB_V_MBAV_MG_OLI"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "B_Kitbag_rgr"};
	case "sup_hat_l";
	case "sup_hat_g": {player addBackpack "UK3CB_LSM_B_B_CARRYALL_OLI"};
	case "sup_mor_l": {player addBackpack "I_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "I_Mortar_01_weapon_F"};
	case "ar_ld";
	case "ar_c": {};
};