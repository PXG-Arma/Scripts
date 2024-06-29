params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "O_UavTerminal";
		player addItemToBackpack "DRNP_AR2P";
		for "_i" from 1 to 3 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

// NVG swap recon
switch (_loadout) do {
    default {};
	case "rcn_ld";
	case "rcn_spe";
	case "rcn_amr";
	case "rcn_dmr";
	case "rcn_drone": {player linkItem "UK3CB_PVS5A"};
};


// add Spotting Scope
switch (_loadout) do {
	case "rcn_dmr": {player addItemToBackpack "ACE_SpottingScope";
	                player addItemToBackpack "ACE_Tripod"};
};