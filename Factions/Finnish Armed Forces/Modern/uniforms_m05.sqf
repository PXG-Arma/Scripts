params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "m93_fi"};
	case "ar_ld";
	case "ar_c": {player forceAddUniform "m93_fi"};
};

// add helmet random
switch (_loadout) do {
	default {
		randomHelmetArray = ["pasgt_fi" ,"pasgt_fig"];
		player addHeadgear selectRandom randomHelmetArray;
	};
	case "sqd_dmr";
	case "rcn_ld";
	case "rcn_spe";
	case "rcn_amr";
	case "rcn_drone": {player addHeadgear "rhs_beanie_green"};
	case "ar_ld";
	case "ar_c": {player addHeadgear "rhs_6b48"};
};

// add vest
switch (_loadout) do {
	default { player addVest "v6b23fi"};
	case "ar_ld";
	case "ar_c": {player addVest "v6b23fi"};
};

// add backpack 
switch (_loadout) do {
	default {player addBackpack "rhssaf_kitbag_smb"};
	case "sqd_med";
	case "rcn_spe": {player addBackpack "rhssaf_alice_smb"};
	case "sup_hmg_l": {player addBackpack "RHS_NSV_Tripod_Bag"};
	case "sup_hmg_g": {player addBackpack "RHS_NSV_Gun_Bag"};
	case "sup_tow_l": {player addBackpack "rhs_TOW_Tripod_Bag"};
	case "sup_tow_g": {player addBackpack "rhs_Tow_Gun_Bag"};
	case "sup_mor_l": {player addBackpack "I_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "I_Mortar_01_weapon_F"};
	case "ar_ld";
	case "ar_c": {};
};