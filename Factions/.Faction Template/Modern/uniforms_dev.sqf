params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { player forceAddUniform "CLASS_ID"};
	case "ar_ld";
	case "ar_c": {player forceAddUniform "CLASS_ID"};
	case "pil": {player forceAddUniform "CLASS_ID"};
};

// add uniform random
// switch (_loadout) do {
// 	default {
// 		randomUniformArray = ["CLASS_ID" ,"CLASS_ID"];
// 		player forceAddUniform selectRandom randomUniformArray;
// 	};
// };
	
// add helmet
switch (_loadout) do {
	default {player addHeadgear "CLASS_ID"};
	case "ar_ld";
	case "ar_c": {player addHeadgear "CLASS_ID"};
	case "pil": {player addHeadgear "CLASS_ID"};
};

// add helmet random
// switch (_loadout) do {
// 	default {
// 		randomHelmetArray = ["CLASS_ID" ,"CLASS_ID"];
// 		player addHeadgear selectRandom randomHelmetArray;
// 	};
// };

// add vest
switch (_loadout) do {
	default { player addVest "CLASS_ID"};
	case "ar_ld";
	case "ar_c": {player addVest "CLASS_ID"};
	case "pil": { player addVest "CLASS_ID"};
};

// add vest random
// switch (_loadout) do {
// 	default {
// 		randomVestArray = ["CLASS_ID" ,"CLASS_ID"];
// 		player addVest selectRandom randomVestArray;
// 	};
// };

// add eyewear random
// switch (_loadout) do {
// 	default {
// 		randomGoggleArray = ["CLASS_ID" ,"CLASS_ID"];
// 		player addGoggles selectRandom randomGoggleArray;
// 	};
// };

// add backpack 
switch (_loadout) do {
	default {player addBackpack "CLASS_ID"};
	case "sup_mor_l": {player addBackpack "I_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "I_Mortar_01_weapon_F"};
	case "ar_ld";
	case "ar_c";
	case "pil": {};
};



// role ID

// Platoon HQ
//case "plt";
//case "logi";
//case "tacp";

//Squad
//case "sqd_ld";
//case "sqd_med";
//case "sqd_lat";
//case "sqd_gre";
//case "sqd_hgre";	
//case "sqd_brc";
//case "sqd_eng";
//case "sqd_ar";
//case "sqd_aar";
//case "sqd_dmr";

//Support
//case "sup_mmg_l";
//case "sup_mmg_g";
//case "sup_hmg_l";
//case "sup_hmg_g";
//case "sup_mat_l";
//case "sup_mat_g";
//case "sup_hat_l";
//case "sup_hat_g";
//case "sup_mor_l";
//case "sup_mor_g";
//case "sup_aa_l";
//case "sup_aa_g";

//Recon
//case "rcn_ld";
//case "rcn_spe";
//case "rcn_dmr";
//case "rcn_amr";
//case "rcn_drone";

//Vehicle
//case "ar_ld";
//case "ar_c";
//case "pil";