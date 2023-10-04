params["_side","_faction","_variant", "_loadout"]; 

// add personal medical items
[ player, "ACE_elasticBandage", 4 ] call pxg_armory_fnc_addToUniform;
[ player, "ACE_quikclot", 4 ] call pxg_armory_fnc_addToUniform;
[ player, "ACE_packingBandage", 4 ] call pxg_armory_fnc_addToUniform;
[ player, "ACE_morphine", 2 ] call pxg_armory_fnc_addToUniform;
[ player, "ACE_epinephrine", 2 ] call pxg_armory_fnc_addToUniform;
[ player, "ACE_tourniquet", 2 ] call pxg_armory_fnc_addToUniform;

// add medic medical items
switch (_loadout) do {
	default {};
	case "sqd_med": {
		[ player, "ACE_surgicalKit", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_elasticBandage", 12 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_quikclot", 12 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_packingBandage", 12 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_tourniquet", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV_500", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_morphine", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_epinephrine", 6 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add specialist medical items
switch (_loadout) do {
	default {};
	case "rcn_spe": {
		[ player, "ACE_surgicalKit", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_elasticBandage", 8 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_quikclot", 8 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_packingBandage", 8 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV_500", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_morphine", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_epinephrine", 4 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add exo medic medical items
switch (_loadout) do {
	default {};
	case "exo_med": {
		[ player, "ACE_surgicalKit", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_elasticBandage", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_quikclot", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_packingBandage", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_bloodIV_500", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_morphine", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_epinephrine", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
