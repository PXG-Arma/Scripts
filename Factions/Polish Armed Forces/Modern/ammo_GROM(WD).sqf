params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		for "_i" from 1 to 4 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_Y"};
		for "_i" from 1 to 4 do { player addItemToBackpack "UK3CB_ACR_30rnd_556x45_YT"};
	};
	case "sqd_lat": {
		for "_i" from 1 to 4 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_Y"};
		for "_i" from 1 to 2 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_YT"};
	};
	case "sqd_ar": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_200Rnd_556x45_box"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_200rnd_556x45_mixed_box"};
		for "_i" from 1 to 1 do { player addItemToVest "rhsusf_200rnd_556x45_mixed_box"};
	};
	case "sqd_dmr";
	case "rcn_dmr": {
		for "_i" from 1 to 4 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_Y"};
		for "_i" from 1 to 4 do { player addItemToBackpack "UK3CB_ACR_30rnd_556x45_YT"};
	};
	case "rcn_amr": {
		for "_i" from 1 to 4 do { player addItemToBackpack "rhsusf_mag_10Rnd_STD_50BMG_M33"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_mag_10Rnd_STD_50BMG_mk211"};
		for "_i" from 1 to 2 do { player addItemToVest "rhsusf_mag_10Rnd_STD_50BMG_mk211"};
	};
	case "sup_mmg_g": {
		for "_i" from 1 to 2 do { player addItemToVest "rhsusf_100Rnd_762x51_m61_ap"};
		for "_i" from 1 to 4 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m80a1epr"};
		for "_i" from 1 to 4 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m62_tracer"};
	};
	case "rcn_spe": {
		for "_i" from 1 to 4 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_Y"};
		for "_i" from 1 to 2 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_YT"};
		for "_i" from 1 to 2 do { player addItemToBackpack "UK3CB_ACR_30rnd_556x45_YT"};
	};
	case "sqd_med";
	case "sqd_brc": {
		for "_i" from 1 to 5 do { player addItemToVest "30Rnd_9x21_Mag"};
		for "_i" from 1 to 5 do { player addItemToBackpack "30Rnd_9x21_Yellow_Mag"};
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {
		for "_i" from 1 to 4 do { player addItemToVest "30Rnd_9x21_Mag"};
	};
	case "sup_aa_g";
	case "sup_aa_l": {
		for "_i" from 1 to 3 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_Y"};
		for "_i" from 1 to 3 do { player addItemToVest "UK3CB_ACR_30rnd_556x45_YT"};
	};
};

// add secondary ammo
switch (_loadout) do {
	default {for "_i" from 1 to 2 do { player addItemToUniform "UK3CB_USP_9_15Rnd"};};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_200Rnd_556x45_box"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_200rnd_556x45_mixed_box"};
	};
	case "sup_mmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m61_ap"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m80a1epr"};
		for "_i" from 1 to 2 do { player addItemToBackpack "rhsusf_100Rnd_762x51_m62_tracer"};
	};
		case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_mag_9k38_rocket"};
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_hat_l": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"};
	case "sup_aa_g": {
		for "_i" from 1 to 2 do { player addItemToBackpack "rhs_mag_9k38_rocket"};
	};
};

// add grenades
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_an_m8hc"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellGreen"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
	};
	case "sqd_brc": {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_an_m8hc"};
		for "_i" from 1 to 4 do { player addItemToVest "ACE_M84"};
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
	};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt": {
		for "_i" from 1 to 5 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "UGL_FlareWhite_F"};
	};
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		for "_i" from 1 to 10 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "UGL_FlareWhite_F"};
	};
};