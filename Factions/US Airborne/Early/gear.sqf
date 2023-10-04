params["_side","_faction","_variant", "_loadout"]; 

// add M79
switch (_loadout) do {
	default {};	
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {[ player, "rhs_weap_m79", 1 ] call pxg_armory_fnc_addToBackpack};
};

// add Dragon CLU
switch (_loadout) do {
	case "sup_hat_g": {player addWeapon "ace_dragon_sight"};
};
