params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "plt";
	case "logi";
	case "sqd_ld": {player linkItem "B_UavTerminal"};
	case "rcn_drone": {player linkItem "B_UavTerminal";
		player addItemToBackpack "ITC_Land_B_AR2i_Packed";
		for "_i" from 1 to 2 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

// add Javelin CLU
switch (_loadout) do {
	case "sup_hat_g": {player addWeapon "UK3CB_BAF_Javelin_CLU"};
};