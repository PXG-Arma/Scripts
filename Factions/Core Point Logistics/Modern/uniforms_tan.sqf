params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "VSM_OGA_Crye_Camo"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "VSM_OGA_Helmet1"};
	case "ar_c": {player addHeadgear "rhsusf_cvc_helmet"};
	case "pil": {player addHeadgear "rhsusf_hgu56p_visor_mask_skull"};
};

// add vest
switch (_loadout) do {
	default { player addVest "VSM_FAPC_Operator_OGA"};
	case "rcn_spe";
	case "sqd_med": {player addVest "VSM_LBT6094_operator_OGA"};
	case "sqd_ar";
	case "sup_mmg_g": {player addVest "VSM_FAPC_MG_OGA"};
	case "sqd_brc": {player addVest "VSM_FAPC_Breacher_OGA"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "VSM_OGA_Backpack_Kitbag"};
	case "sqd_med";
	case "sup_mmg_l";
	case "sup_mat_l";
	case "sup_mat_g";
	case "sup_hat_l": {player addBackpack "VSM_OGA_carryall"};
	case "sup_mor_l": {player addBackpack "B_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "B_Mortar_01_weapon_F"};
	case "ar_c";
	case "pil": {};
};