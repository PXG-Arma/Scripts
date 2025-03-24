params["_side","_faction","_variant", "_loadout"]; 




// add uniform
switch (_loadout) do {
	default {player forceAddUniform "m93_d85";
	};
	case "pil" : { player forceAddUniform "rhssaf_uniform_heli_pilot"};
};
	
// add helmet
switch (_loadout) do {
	default {player addHeadgear "pasgt_dc"};
	case "pil": {player addHeadgear "UK3CB_H_Pilot_Helmet"};
};

// add mask
switch (_loadout) do {
	default {};
	case "pil": {player addGoggles "None"};
};

// add vest
switch (_loadout) do {
	default { player addVest "m12_dc"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "UK3CB_B_Kitbag_DPM_95"};
	case "sup_mor_g" : { player addBackpack "I_Mortar_01_weapon_F"};
	case "sup_mor_l" : { player addBackpack "I_Mortar_01_support_F"};
	case "sup_hat_l";
	case "sup_hat_g": { player addBackpack "UK3CB_B_Carryall_DPM_95"};
    case "ar_ld";
	case "ar_c";
	case "pil": {};
};
