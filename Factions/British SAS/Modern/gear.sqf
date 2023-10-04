params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "B_UavTerminal";
		[ player, "DRNP_AR2P", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	
};

// add Spotting Scope
switch (_loadout) do {
	case "rcn_dmr";
	case "rcn_sni": {[ player, "ACE_SpottingScope", 1 ] call pxg_armory_fnc_addToBackpack;
	[ player, "ACE_Tripod", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};