params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		switch (primaryWeapon player) do {
			
			case "uk3cb_auga2_blk";
			case "rhs_weap_hk416d145";
			case "rhs_weap_hk416d145_m320";
			case "rhs_weap_m4a1_blockII_KAC";
			case "rhs_weap_m4a1_blockII_M203": {
					[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_g36kv";
			case "rhs_weap_g36kv_ag36": {
				[ player, "rhssaf_30rnd_556x45_EPR_G36", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhssaf_30rnd_556x45_Tracers_G36", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_SCARH_FDE_STD";
			case "rhs_weap_SCARH_STD": {
				[ player, "rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_mag_20Rnd_SCAR_762x51_m62_tracer_bk", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhsusf_weap_MP7A2": {
				[ player, "rhsusf_mag_40Rnd_46x30_AP", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhsusf_mag_40Rnd_46x30_AP", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_sr25_ec": {
				[ player, "rhsusf_20Rnd_762x51_SR25_m993_Mag", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhsusf_20Rnd_762x51_SR25_m62_Mag", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_XM2010": {
				[ player, "rhsusf_5Rnd_300winmag_xm2010", 8 ] call pxg_armory_fnc_addToVest;
				[ player, "rhsusf_5Rnd_300winmag_xm2010", 8 ] call pxg_armory_fnc_addToBackpack;
			};
			
			default {};
		};
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M713_red", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 1 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_15Rnd_9x19_FMJ", 4 ] call pxg_armory_fnc_addToVest;
	};
	case "sup_aa_g";
	case "sup_mat_g";
	case "sup_mmg_g";
	case "sqd_eng";
	case "rcn_spe": {};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sup_mmg_l": {
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_mag_smaw_HEAA", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_smaw_HEDP", 1 ] call pxg_armory_fnc_addToBackpack;
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
	case "sqd_brc": {
		[ player, "rhs_mag_an_m8hc", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "ACE_M84", 2 ] call pxg_armory_fnc_addToVest;
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
