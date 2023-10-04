params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "rcn_drone";
	case "sqd_med": {
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_brc": {
		[ player, "rhsusf_8Rnd_00Buck", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_8Rnd_Slug", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsusf_5Rnd_762x51_AICS_m993_Mag", 8 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_5Rnd_762x51_AICS_m62_Mag", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag", 2 ] call pxg_armory_fnc_addToVest;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_7x45acp_MHP", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c";
	case "pil";
	case "sup_aa_g";
	case "sup_mat_g";
	case "sup_mmg_g";
	case "sqd_eng";
	case "rcn_spe": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_ar": {
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_mag_smaw_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_SR", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_l": {
		[ player, "rhs_fim92_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_SR", 1 ] call pxg_armory_fnc_addToBackpack;
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
