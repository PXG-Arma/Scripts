params["_side","_faction","_variant", "_loadout"]; 

_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;

if (_variantEra == "Early") then {
	switch (_loadout) do {
		default {};
		case "plt"; 
		case "logi";
		case "pil";
		case "sqd_ld";
		case "ar_ld";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l": {[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToUniform};
		case "rcn_ld";
		case "tacp": {[ player, "ACRE_PRC117F", 1 ] call pxg_armory_fnc_addToBackpack};
	};
};

if (_variantEra == "Insurgency") then {
	switch (_loadout) do {
		default {[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform};
		case "plt"; 
		case "logi";
		case "sqd_ld";
		case "rcn_ld";
		case "ar_ld";
		case "sup_mmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l":{
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToUniform;
		};
		case "pil": {};
		case "tacp": { 
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC117F", 1 ] call pxg_armory_fnc_addToBackpack;
		};
	};
};

if (_variantEra == "Late") then {
	switch (_loadout) do {
		default {[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform};
		case "plt"; 
		case "logi";
		case "sqd_ld";
		case "ar_ld";
		case "sup_mmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l":{
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToVest;
		};
		case "pil": {[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToUniform};
		case "rcn_ld";
		case "tacp": { 
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC117F", 1 ] call pxg_armory_fnc_addToBackpack;
		};
	};
};

if (_variantEra == "Modern" || _variantEra == "Future") then {
	switch (_loadout) do {
		default {[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform};
		case "plt"; 
		case "logi";
		case "sqd_ld";
		case "ar_ld";
		case "sup_mmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l":{
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToVest;
		};
		case "pil": {[ player, "ACRE_PRC152", 1 ] call pxg_armory_fnc_addToUniform};
		case "rcn_ld";
		case "tacp": { 
			[ player, "ACRE_PRC343", 1 ] call pxg_armory_fnc_addToUniform;
			[ player, "ACRE_PRC117F", 1 ] call pxg_armory_fnc_addToBackpack;
		};
	};
};
