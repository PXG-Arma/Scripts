params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "B_UavTerminal";
		player addItemToBackpack "DRNP_AR2P";
		for "_i" from 1 to 3 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

switch (_loadout) do {
	default { 
			player addItemToUniform "ACE_Flashlight_XL50"; 
			player addItemToUniform "ACE_MapTools";
			for "_i" from 1 to 4 do {player addItemToUniform "ACE_CableTie"};
	};
	case "plt";
	case "logi";
	case "plt_med";
	case "tacp";
	case "sqd_ld";
	case "rcn_ld";
	case "sup_hat_l";
	case "sup_aa_l";
	case "pil": {
			player addItemToUniform "ACE_Flashlight_XL50"; 
			player addItemToUniform "ACE_MapTools";
			player addItemToUniform "ACRE_PRC152";
			for "_i" from 1 to 4 do {player addItemToUniform "ACE_CableTie"};
	};
};


// NVG swap
switch (_loadout) do {
    default {player linkItem "JAS_GPNVG18_blk"};
	case "rcn_spe";
	case "rcn_dmr";
	case "rcn_drone";
	case "rcn_ld": {player linkItem "UK3CB_PVS5A"};
};