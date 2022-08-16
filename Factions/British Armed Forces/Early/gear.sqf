params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "B_UavTerminal";
		player addItemToBackpack "ITC_Land_B_AR2i_Packed";
		for "_i" from 1 to 2 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

// Grenade Launcher
switch (_loadout) do {
	case "plt";
	case "sqd_gre";
	case "rcn_ld";
	case "sqd_ld": {player addItemToBackpack "UK3CB_M79"};
};

// Recon Lead spotter
switch (_loadout) do {
	case "rcn_ld": {player addItemToBackpack "ACE_SpottingScope";
	                player addItemToBackpack "ACE_Tripod"
					};
};

// Recon Sniper
switch (_loadout) do {
	case "rcn_dmr": {player addItemToBackpack "ACE_RangeCard"
					};
};