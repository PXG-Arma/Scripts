params["_side","_faction","_variant", "_loadout"]; 

_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
[ player, "ACE_Flashlight_XL50", 1 ] call pxg_armory_fnc_addToVest;
[ player, "ACE_MapTools", 1 ] call pxg_armory_fnc_addToVest;
[ player, "ACE_CableTie", 4 ] call pxg_armory_fnc_addToVest;

// add Entrenching Tool & Fortify Hammer
switch (_loadout) do {
	default {
		[ player, "ACE_Fortify", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_EntrenchingTool", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil";
	case "sup_hmg_l";
	case "sup_hmg_g";
	case "sup_tow_l";
	case "sup_tow_g";
	case "sup_gmg_l";
	case "sup_gmg_g";
	case "sup_mor_l";
	case "sup_mor_g": {
		[ player, "ACE_Fortify", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "ACE_EntrenchingTool", 1 ] call pxg_armory_fnc_addToVest;
	};
};

// add Logi, EOD, Sapper, Specialist equipement
switch (_loadout) do {
	default {};
	case "logi": {[ player, "ToolKit", 1 ] call pxg_armory_fnc_addToBackpack};
	case "sqd_eng": {
		[ player, "tsp_stickCharge_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "DemoCharge_Remote_Mag", 4 ] call pxg_armory_fnc_addToBackpack;
		player addWeapon "ACE_VMM3";
		[ player, "ACE_M26_Clacker", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_wirecutter", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_DefusalKit", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_SpraypaintBlue", 1 ] call pxg_armory_fnc_addToBackpack;
	};
		case "sqd_sap": {
		[ player, "IEDUrbanBig_Remote_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "DemoCharge_Remote_Mag", 3 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_Clacker", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_wirecutter", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_DefusalKit", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_sap_dms": {
		[ player, "IEDLandBig_Remote_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "IEDLandSmall_Remote_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_Cellphone", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_DeadManSwitch", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_wirecutter", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_DefusalKit", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_brc": {
		[ player, "tsp_popperCharge_mag", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "tsp_stickCharge_mag", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "tsp_frameCharge_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_Clacker", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "tsp_lockpick", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_spe": {
		[ player, "DemoCharge_Remote_Mag", 3 ] call pxg_armory_fnc_addToBackpack;
		player addWeapon "ACE_VMM3";
		[ player, "ACE_M26_Clacker", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_wirecutter", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_DefusalKit", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_SpraypaintBlue", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add Range Card
switch (_loadout) do {
	default {};
	case "sqd_dmr";
	case "rcn_dmr";
	case "rcn_sni";
	case "rcn_amr": {[ player, "ACE_RangeCard", 1 ] call pxg_armory_fnc_addToUniform};
};

// add Mortar Table
switch (_loadout) do {
	default {};
	case "sup_mor_l";
	case "sup_mor_g": {[ player, "ACE_artilleryTable", 1 ] call pxg_armory_fnc_addToUniform};
};

// add Patrachutes to pilots
switch (_loadout) do {
	default {};
	case "pil": {
	removeBackpackGlobal player;
	player addBackpack "B_Parachute";
	};
};


// early loadouts
if (_variantEra == "Early") then { player addWeapon "binocular"};

// insurgency loadouts
if (_variantEra == "Insurgency") then { 
	player addWeapon "binocular";
	player linkItem "ItemGPS";
};

// late loadouts
if (_variantEra == "Late") then {
	
	// add GPS
	switch (_loadout) do {
		default {};
		case "plt";
		case "logi";
		case "tacp";
		case "sqd_ld";
		case "rcn_ld";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_gmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l": {[ player, "ACE_DAGR", 1 ] call pxg_armory_fnc_addToBackpack};
	};

	// add NVG
	//player linkItem "ACE_NVG_Wide_Black";
	[ player, "ACE_IR_Strobe_Item", 1 ] call pxg_armory_fnc_addToUniform;

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "binocular"};
		case "sqd_aar";
		case "sqd_dmr";
		case "rcn_ld";
		case "rcn_dmr";
		case "rcn_sni";
		case "rcn_amr";
		case "sup_mmg_l";
		case "sup_mmg_g";	
		case "sup_mat_l";
		case "sup_mat_g";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_aa_g";
		case "sup_hat_g";
		case "sup_mor_l";
		case "sup_mor_g":{ player addWeapon "ACE_Vector"};
		case "rcn_ld";
		case "sqd_ld";
		case "plt";
		case "tacp": {
			player addWeapon "Laserdesignator";
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToBackpack;
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToBackpack;
		};
	};
};

// modern loadouts
if (_variantEra == "Modern") then {
	
	// add GPS
	player linkItem "ItemGPS";
	[ player, "ACE_microDAGR", 1 ] call pxg_armory_fnc_addToUniform;

	// add NVG
	player linkItem "ACE_NVG_Wide_Black";
	[ player, "ACE_IR_Strobe_Item", 1 ] call pxg_armory_fnc_addToUniform;

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "binocular"};
		case "sqd_aar";
		case "sqd_dmr";
		case "rcn_dmr";
		case "rcn_sni";
		case "rcn_amr";
		case "sup_mmg_l";
		case "sup_mmg_g";	
		case "sup_mat_l";
		case "sup_mat_g";
		case "sup_hat_l";
		case "sup_hat_g";
		case "sup_aa_l";
		case "sup_aa_g";
		case "sup_mor_l";
		case "sup_mor_g":{ player addWeapon "ACE_Vector"};
		case "rcn_ld";
		case "sqd_ld";
		case "plt";
		case "tacp": {
			player addWeapon "Laserdesignator";
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToBackpack;
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToBackpack;
		};
	};
};

// future loadouts
if (_variantEra == "Future") then {
	
	// add GPS
	player linkItem "ItemGPS";
	[ player, "ACE_microDAGR", 1 ] call pxg_armory_fnc_addToUniform;
	[ player, "ACE_IR_Strobe_Item", 1 ] call pxg_armory_fnc_addToUniform;

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "ACE_Vector"};
		case "plt";
		case "tacp": {
			player addWeapon "Laserdesignator";
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "Laserbatteries", 1 ] call pxg_armory_fnc_addToUniform;
		};
	};
};

