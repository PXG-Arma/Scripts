params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "I_UavTerminal";
		[ player, "DRNP_AR2P", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	
};

// remove NVG 
switch (_loadout) do {
    default {player unlinkItem "ACE_NVG_Gen4_Black"};
};
