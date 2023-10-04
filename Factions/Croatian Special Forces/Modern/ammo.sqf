params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhsgref_30rnd_556x45_vhs2", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsgref_30rnd_556x45_vhs2_t", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhsusf_200Rnd_556x45_mixed_soft_pouch", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_200Rnd_556x45_mixed_soft_pouch", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsusf_5Rnd_762x51_AICS_m993_Mag", 8 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_5Rnd_762x51_AICS_m62_Mag", 8 ] call pxg_armory_fnc_addToVest;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhsgref_30rnd_556x45_vhs2", 4 ] call pxg_armory_fnc_addToVest;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_17Rnd_9x19_FMJ", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_eng";
	case "rcn_spe": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_200Rnd_556x45_mixed_soft_pouch", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_hat_l": {
		[ player, "Vorona_HEAT", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "Vorona_HE", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "rhs_fim92_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_hat_g": {
		[ player, "Vorona_HEAT", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "Vorona_HE", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "rhs_fim92_mag", 1 ] call pxg_armory_fnc_addToBackpack;
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
