params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		[ player, "UK3CB_M16_20rnd_556x45", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_M16_20rnd_556x45_RT", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_brc": {
		[ player, "6Rnd_00_Buckshot_Magazine", 6 ] call pxg_armory_fnc_addToVest;
		[ player, "6Rnd_Slug_Magazine", 6 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sqd_ar": {
		[ player, "rhsusf_100Rnd_762x51", 3 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "UK3CB_M14_20rnd_762x51", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_M14_20rnd_762x51_RT", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "ar_ld";
	case "ar_c": {[ player, "rhsgref_30rnd_1143x23_M1911B_SMG", 2 ] call pxg_armory_fnc_addToVest};
	case "pil":{};
};

// add secondary ammo
switch (_loadout) do {
	default {};
	case "plt";
	case "logi";
	case "pil" : {[ player, "rhsusf_mag_7x45acp_MHP", 4 ] call pxg_armory_fnc_addToVest};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "rhsusf_100Rnd_762x51", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhsusf_100Rnd_762x51_m62_tracer", 2 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_hat_l": {	player addWeapon "ace_dragon_super"};
};

// add other ammo 
switch (_loadout) do {
	default {};
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
