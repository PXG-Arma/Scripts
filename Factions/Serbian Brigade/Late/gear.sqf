params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "I_UavTerminal";
		player addItemToBackpack "DRNP_AR2P";
		for "_i" from 1 to 3 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

// remove NVG 
switch (_loadout) do {
    default {player unlinkItem "ACE_NVG_Gen4_Black"};
};