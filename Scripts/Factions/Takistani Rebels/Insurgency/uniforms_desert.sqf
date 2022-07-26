params["_side","_faction","_variant", "_loadout"]; 

 // add uniform
switch (_loadout) do {
	default { player forceAddUniform "UK3CB_TKM_O_U_01"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "H_ShemagOpen_khk"};
};

// add vest
switch (_loadout) do {
	default { player addVest "UK3CB_V_Belt_Rig_KHK"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "UK3CB_B_Alice_K"};
	case "sup_mor_l": {player addBackpack "B_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "B_Mortar_01_weapon_F"};
	case "ar_c";
	case "pil": {};
};