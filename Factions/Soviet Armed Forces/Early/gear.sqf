params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "O_UavTerminal";
		[ player, "ITC_Land_O_AR2i_Packed", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	
};
