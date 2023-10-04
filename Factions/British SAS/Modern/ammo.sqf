params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_ar": {
		[ player, "rhsusf_100Rnd_556x45_mixed_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_556x45_mixed_soft_pouch_coyote", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsusf_20Rnd_762x51_SR25_m62_Mag", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_20Rnd_762x51_SR25_m993_Mag", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_sni": {
		[ player, "rhsusf_5Rnd_300winmag_xm2010", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_5Rnd_300winmag_xm2010", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "pil": {
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_MP5_30Rnd_9x19_Magazine_RT", 4 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_17Rnd_9x19_FMJ", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_brc";
	case "rcn_sni": {
		[ player, "rhsusf_mag_40Rnd_46x30_AP", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_eng";
	case "rcn_spe": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_100Rnd_556x45_mixed_soft_pouch_coyote", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
		case "sup_aa_l": {
		[ player, "rhs_fim92_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_hat_l": {
		[ player, "rhs_fgm148_magazine_AT", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_aa_g": {
		[ player, "rhs_fim92_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "HandGrenade", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellRed", 1 ] call pxg_armory_fnc_addToVest;
		[ player, "SmokeShellGreen", 1 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_brc": {
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "ACE_M84", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "HandGrenade", 2 ] call pxg_armory_fnc_addToVest;
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt";
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
