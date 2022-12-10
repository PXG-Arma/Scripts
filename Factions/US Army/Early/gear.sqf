params["_side","_faction","_variant", "_loadout"]; 

// add M79 terminal
switch (_loadout) do {
	default {};	
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {player addItemToBackpack "rhs_weap_m79"};
};