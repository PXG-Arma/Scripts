params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M713_red", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhsusf_200Rnd_556x45_M855_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch_coyote", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_dmr";
	case "rcn_dmr": {
		[ player, "rhsusf_20Rnd_762x51_m993_Mag", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_20Rnd_762x51_m62_Mag", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag", 4 ] call pxg_armory_fnc_addToVest;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_15Rnd_9x19_FMJ", 4 ] call pxg_armory_fnc_addToVest;
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_200rnd_556x45_mixed_box", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_mag_maaws_HEDP", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_hat_l": {
		[ player, "rhs_fgm148_magazine_AT", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "rhs_fim92_mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_mag_maaws_HEAT", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_hat_g": {
		[ player, "rhs_fgm148_magazine_AT", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "rhs_fim92_mag", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellGreen", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellRed", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "HandGrenade", 2 ] call pxg_armory_fnc_addToVest;
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
