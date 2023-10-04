params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "UK3CB_FAMAS_25rnd_556x45", 8 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_ar": {
		[ player, "rhsusf_200rnd_556x45_M855_mixed_box", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "UK3CB_G3_20rnd_762x51", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_G3_20rnd_762x51", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_c";
	case "ar_ld": {
		[ player, "UK3CB_FAMAS_25rnd_556x45", 4 ] call pxg_armory_fnc_addToVest;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_200rnd_556x45_M855_mixed_box", 4 ] call pxg_armory_fnc_addToBackpack;
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
		[ player, "rhs_mag_smaw_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
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
