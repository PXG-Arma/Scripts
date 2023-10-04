params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "BWA3_30Rnd_556x45_G36", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_30Rnd_556x45_G36_Tracer", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "BWA3_200Rnd_556x45", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_200Rnd_556x45_Tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "BWA3_20Rnd_762x51_G28_AP", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_20Rnd_762x51_G28_Tracer", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "BWA3_120Rnd_762x51_soft", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_120Rnd_762x51_Tracer_soft", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mor_l": {
		[ player, "BWA3_30Rnd_556x45_G36", 4 ] call pxg_armory_fnc_addToVest;
		for "_i" from 1 to 4 do { player addItemTovest "BWA3_30Rnd_556x45_G36_Tracer"};
	};
	case "sup_mor_g": {
		[ player, "BWA3_30Rnd_556x45_G36", 4 ] call pxg_armory_fnc_addToVest;
		for "_i" from 1 to 4 do { player addItemTovest "BWA3_30Rnd_556x45_G36_Tracer"};
	};
	case "ar_ld";
	case "ar_c": {
		[ player, "BWA3_40Rnd_46x30_MP7", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "pil": {};
};

// add secondary ammo 
switch (_loadout) do {
	default {
		[ player, "BWA3_12Rnd_45ACP_P12", 3 ] call pxg_armory_fnc_addToUniform;
	};
	case "pil": {
		[ player, "BWA3_12Rnd_45ACP_P12", 5 ] call pxg_armory_fnc_addToVest;
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "BWA3_200Rnd_556x45", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "BWA3_200Rnd_556x45_Tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "BWA3_120Rnd_762x51_soft", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_120Rnd_762x51_Tracer_soft", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "BWA3_CarlGustav_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "BWA3_CarlGustav_HEAT", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "BWA3_Fliegerfaust_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "BWA3_CarlGustav_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "BWA3_CarlGustav_HEAT", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "BWA3_Fliegerfaust_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "BWA3_DM25", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_DM32_Green", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_DM32_Red", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "BWA3_DM51A1", 2 ] call pxg_armory_fnc_addToVest;
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt": {
		[ player, "1Rnd_HE_Grenade_shell", 5 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeRed_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeGreen_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UGL_FlareWhite_F", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		[ player, "1Rnd_HE_Grenade_shell", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeRed_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeGreen_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UGL_FlareWhite_F", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
