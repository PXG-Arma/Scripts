params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "rhsgref_uniform_altis_lizard"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "rhsgref_helmet_pasgt_altis_lizard"};
	case "rcn_ld";
	case "rcn_spe";
	case "rcn_drone";
	case "rcn_dmr": { player addHeadgear "H_Booniehat_oli"};
	case "ar_ld";
	case "ar_c": {player addHeadgear "H_HelmetCrew_I"};
	case "pil": {player addHeadgear "H_PilotHelmetHeli_B"};
};

// add vest
switch (_loadout) do {
	default { player addVest "rhsgref_otv_khaki"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "B_Kitbag_rgr"};
	case "sqd_med";
	case "sup_mat_l": {player addBackpack "UK3CB_LSM_B_B_CARRYALL_KHK"};
	case "sup_mor_l": {player addBackpack "B_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "B_Mortar_01_weapon_F"};
	case "ar_ld";
    case "ar_ld";
	case "ar_c";
	case "pil": {};
};