params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};	
};

// Recon Lead spotter
switch (_loadout) do {
	case "rcn_ld": {player addItemToBackpack "ACE_SpottingScope";
	                player addItemToBackpack "ACE_Tripod";
					player addWeapon "ACE_Vector"};
};

// Recon AMR
switch (_loadout) do {
	case "rcn_amr": {player addItemToUniform "ACE_RangeCard"};
};