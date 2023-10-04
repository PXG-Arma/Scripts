params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "O_UavTerminal";
					[ player, "DRNP_AR2P", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_ld": {[ player, "ACE_Cellphone", 1 ] call pxg_armory_fnc_addToBackpack;
					[ player, "DRNP_AR2P", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 3 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add IED
switch (_loadout) do {
	default {};
	case "sqd_gre";
	case "sqd_ar";
	case "sqd_aar": {[ player, "IEDLandSmall_Remote_Mag", 1 ] call pxg_armory_fnc_addToBackpack};
	case "sqd_lat": {[ player, "IEDLandSmall_Remote_Mag", 1 ] call pxg_armory_fnc_addToVest};
	case "rcn_ld": {[ player, "IEDLandBig_Remote_Mag", 1 ] call pxg_armory_fnc_addToBackpack};
};

// add DMS
switch (_loadout) do {
	default {};
	case "sqd_ld": {
		[ player, "ACE_DeadManSwitch", 6 ] call pxg_armory_fnc_addToBackpack;
	};
};
