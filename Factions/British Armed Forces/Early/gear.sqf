params["_side","_faction","_variant", "_loadout"]; 

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