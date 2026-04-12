// This file lists all the gear that is common accross all Factions, This should never be touched!

params["_side","_faction","_variant", "_loadout"]; 

_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player addItemToVest "ACE_Flashlight_XL50"; 
player addItemToVest "ACE_MapTools";
for "_i" from 1 to 4 do {player addItemToVest "ACE_CableTie"};

// add Entrenching Tool & Fortify Hammer
switch (_loadout) do {
	default {player addItemToBackpack "ACE_EntrenchingTool";};
	case "logi";
	case "sf_eng";
	case "sqd_eng": {
		player addItemToBackpack "ACE_Fortify";
		player addItemToBackpack "ACE_EntrenchingTool";
	};
};

// add Logi, EOD, Sapper, Specialist equipement
switch (_loadout) do {
	default {};
	case "logi": {player addItemToBackpack "ToolKit"
	};
	case "sqd_eng": {
		for "_i" from 1 to 4 do { player addItemToBackpack "DemoCharge_Remote_Mag"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SatchelCharge_Remote_Mag"};
		player addWeapon "ACE_VMM3";
		player addItemToBackpack "ACE_Clacker";
		player addItemToBackpack "ACE_wirecutter";
		player addItemToBackpack "ACE_DefusalKit";
		player addItemToUniform "TOMH_Stencil_Eod";
		for "_i" from 1 to 2 do { player addItemToBackpack "iedd_item_notebook"};
	};
	case "plt_eod": {
		for "_i" from 1 to 4 do { player addItemToBackpack "DemoCharge_Remote_Mag"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SatchelCharge_Remote_Mag"};
		player addWeapon "ACE_VMM3";
		player addItemToBackpack "ACE_M26_Clacker";
		player addItemToBackpack "ACE_wirecutter";
		player addItemToBackpack "ACE_DefusalKit";
		player addItemToUniform "TOMH_Stencil_Eod";
		for "_i" from 1 to 2 do { player addItemToBackpack "iedd_item_notebook"};
	};
	case "sf_eng": {
		for "_i" from 1 to 4 do { player addItemToBackpack "DemoCharge_Remote_Mag"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SatchelCharge_Remote_Mag"};
		player addWeapon "ACE_VMM3";
		player addItemToBackpack "ACE_Clacker";
		player addItemToBackpack "ACE_wirecutter";
		player addItemToBackpack "ACE_DefusalKit";
		player addItemToUniform "TOMH_Stencil_Eod";
		for "_i" from 1 to 2 do { player addItemToBackpack "iedd_item_notebook"};
	};
	case "sqd_brc": {
		player addItemToBackpack "ACE_wirecutter";
		player addItemToUniform "TOMH_Stencil_Eod";
	};
};

// add Range Card
switch (_loadout) do {
	default {};
	case "sf_dmr";
	case "rcn_ld";
	case "rcn_sni";
	case "rcn_amr": {player addItemToUniform "ACE_RangeCard"};
};

// add Mortar Table
switch (_loadout) do {
	default {};
	case "sup_mor_l";
	case "sup_mor_g": {player addItemToUniform "ACE_artilleryTable";
	                   player addItemToUniform "ACE_PlottingBoard"};
};

// add spotter/sniper equipment
	switch (_loadout) do {
		default {};
		case "rcn_ld":{player addItemToBackpack "ACE_SpottingScope";};
		case "rcn_amr";
		case "rcn_sni":{player addItemToBackpack "ACE_Tripod";};
	};

// early loadouts
if (_variantEra == "Early") then { 

	// add binocular
	player addWeapon "binocular";

    // add era specific medical items
    switch (_loadout) do {
	    default {};
	    case "plt_med": {for "_i" from 1 to 1 do { player addItemToBackpack "kat_AED"};};
    };
};


// insurgency loadouts
if (_variantEra == "Insurgency") then { 
	player addWeapon "binocular";
	player linkItem "ItemGPS";
};

// late loadouts
if (_variantEra == "Late") then {
	
	    // add era specific medical items
    switch (_loadout) do {
	    default {};
	    case "plt_med": {for "_i" from 1 to 1 do { player addItemToBackpack "kat_X_AED"};};
		case "sf_med";
		case "sqd_med": {for "_i" from 1 to 1 do { player addItemToBackpack "kat_Pulseoximeter"};};
    };

	// add GPS
	switch (_loadout) do {
		default {};
		case "plt";
		case "plt_med"; 
		case "logi";
		case "plt_eod";
		case "tacp";
		case "sqd_ld";
		case "sf_ld";
		case "rcn_ld";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_gmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l": {player addItemToBackpack "ACE_DAGR"};
	};

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "binocular"};
		case "sqd_aar";
		case "plt";
		case "sqd_ld";
		case "rcn_ld";
		case "sf_ld";
		case "sf_med";
		case "sf_dmr";
		case "sf_eng";
		case "sup_mmg_l";
		case "sup_hmg_l";	
		case "sup_gmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l":{ player addWeapon "ACE_Vector"};
		case "rcn_drone";
		case "rcn_sni";
		case "rcn_amr";
		case "tacp": {
			player addWeapon "Laserdesignator";
			player addItemToBackpack "Laserbatteries";
			player addItemToBackpack "Laserbatteries";
		};
	};

	// add spotter equipment
	switch (_loadout) do {
		default {};
		case "sup_mor_l";
		case "rcn_ld":{ player addItemToUniform "ACE_Kestrel4500";};
	};
};

// modern loadouts
if (_variantEra == "Modern") then {
	
	// add era specific medical items
    switch (_loadout) do {
	    default {};
	    case "plt_med": {for "_i" from 1 to 1 do { player addItemToBackpack "kat_X_AED"};};
		case "sf_med";
		case "sqd_med": {for "_i" from 1 to 1 do { player addItemToBackpack "kat_Pulseoximeter"};};
    };

	// add watch
	switch (_loadout) do {
		default {player linkItem "ItemWatch";};
	};

	// add GPS
	player linkItem "ItemGPS";
	player addItemToUniform "ACE_microDAGR";

	// add NVG
	player linkItem "ACE_NVG_Wide_Black";
	player addItemToUniform "ACE_IR_Strobe_Item"; 

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "binocular"};
		case "sqd_aar";
		case "plt";
		case "sqd_ld";
		case "rcn_ld";
		case "sf_ld";
		case "sf_med";
		case "sf_dmr";
		case "sf_eng";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_gmg_l";	
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l":{ player addWeapon "ACE_Vector"};
		case "rcn_drone";
		case "rcn_sni";
		case "rcn_amr";
		case "tacp": {
			player addWeapon "Laserdesignator";
			player addItemToBackpack "Laserbatteries";
			player addItemToBackpack "Laserbatteries";
		};
	};

	// add spotter equipment
	switch (_loadout) do {
		default {};
		case "sup_mor_l":{player addItemToUniform "ACE_Kestrel4500";};
		case "rcn_ld":{player addItemToUniform "ACE_ATragMX";
			           player addItemToUniform "ACE_Kestrel4500";};
	};
};

// future loadouts
if (_variantEra == "Future") then {
	
	// add GPS
	player linkItem "ItemGPS";
	player addItemToUniform "ACE_microDAGR";
	player addItemToUniform "ACE_IR_Strobe_Item"; 

	// add binocular
	switch (_loadout) do {
		default { player addWeapon "ACE_Vector"};
		case "plt";
		case "tacp": {
			player addWeapon "Laserdesignator";
			player addItemToUniform "Laserbatteries";
			player addItemToUniform "Laserbatteries";
		};
	};

	// add spotter equipment
	switch (_loadout) do {
		default {};
		case "rcn_ld":{player addItemToBackpack "ACE_Tripod";
			           player addItemToBackpack "ACE_SpottingScope";
			           player addItemToUniform "ACE_ATragMX";
			           player addItemToUniform "ACE_Kestrel4500";};
	};
};

