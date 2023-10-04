params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};	
};

// remove NVG 
switch (_loadout) do {
    default {player unlinkItem "ACE_NVG_Gen4_Black"};
};

// add Spotting Scope
switch (_loadout) do {
	case "rcn_dmr": {[ player, "ACE_SpottingScope", 1 ] call pxg_armory_fnc_addToBackpack;
	[ player, "ACE_Tripod", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};