params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "rhs_mag_30Rnd_556x45_m855_Stanag", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhsusf_200Rnd_556x45_M855_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_hgre": {
		[ player, "rhsusf_mag_6Rnd_M441_HE", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_mag_6Rnd_M441_HE", 6 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_mag_6Rnd_M714_white", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "rhsusf_20Rnd_762x51_m80_Mag", 6 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_20Rnd_762x51_m80_Mag", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "rhsusf_100Rnd_762x51_m80a1epr", 2 ] call pxg_armory_fnc_addToVest;
		[ player, "rhsusf_100Rnd_762x51_m61_ap", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l";
	case "sup_mat_g": {
		[ player, "rhs_mag_30Rnd_556x45_m855_Stanag", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "pil": {};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhsusf_mag_7x45acp_MHP", 2 ] call pxg_armory_fnc_addToUniform;
	};
	case "pil";
	case "sqd_hgre": {
		[ player, "rhsusf_mag_7x45acp_MHP", 5 ] call pxg_armory_fnc_addToVest;
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_200Rnd_556x45_M855_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch_coyote", 2 ] call pxg_armory_fnc_addToBackpack;
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
};
