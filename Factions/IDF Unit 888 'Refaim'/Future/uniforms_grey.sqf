params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "VSM_OGA_Crye_grey_Camo"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "VSM_OGA_OD_Helmet2"};
	case "ar_c": {player addHeadgear "rhsusf_cvc_green_ess"};
	case "pil": {player addHeadgear "rhsusf_hgu56p_visor"};
};

// add vest
switch (_loadout) do {
	default { player addVest "VSM_OGA_OD_Vest_1"};
	case "rcn_ld";
	case "rcn_spe";
	case "rcn_dmr";
	case "rcn_drone"; {player addVest "VSM_OGA_OD_Vest_2"};
	case "ar_c";
	case "pil": {player addVest "VSM_OGA_OD_Vest_3"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "VSM_OGA_OD_Backpack_Kitbag"};
	case "sup_mor_l": {player addBackpack "B_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "B_Mortar_01_weapon_F"};
	case "ar_c";
	case "pil": {};
};