params["_side","_faction","_variant", "_loadout"]; 

// add M79
switch (_loadout) do {
	default {};	
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {[ player, "rhs_weap_m79", 1 ] call pxg_armory_fnc_addToBackpack};
};

// add Spotting Scope
switch (_loadout) do {
	case "rcn_dmr": {[ player, "ACE_SpottingScope", 1 ] call pxg_armory_fnc_addToBackpack;
	[ player, "ACE_Tripod", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};
// remove NVG 
switch (_loadout) do {
    default {player unlinkItem "ACE_NVG_Gen4_Black"};
};
