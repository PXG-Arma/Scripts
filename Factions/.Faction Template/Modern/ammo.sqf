params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		for "_i" from 1 to 4 do { player addItemToVest "AMMO"};
		for "_i" from 1 to 4 do { player addItemToVest "AMMO_TRACER"};
	};
	// Heavy Grenadier
		case "sqd_hgre": {
		for "_i" from 1 to 3 do { player addItemToVest "rhsusf_mag_6Rnd_M441_HE"};
		for "_i" from 1 to 3 do { player addItemToBackpack "rhsusf_mag_6Rnd_M441_HE"};
		for "_i" from 1 to 1 do { player addItemToBackpack "rhsusf_mag_6Rnd_M713_red"};
		for "_i" from 1 to 1 do { player addItemToBackpack "rhsusf_mag_6Rnd_M714_white"}
	};
	// Breacher
		case "sqd_brc": {
		for "_i" from 1 to 6 do { player addItemToVest "AMMO"};
		for "_i" from 1 to 6 do { player addItemToVest "AMMO_SLUG"};
	};
	// Automatic Rifleman
		case "sqd_ar": {
		for "_i" from 1 to 2 do { player addItemToVest "AMMO"};
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO_TRACER"};
	};
	// MMG Gunner
		case "sup_mmg_g": {
		for "_i" from 1 to 2 do { player addItemToVest "AMMO"};
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO_TRACER"};
	};
	// Recon/Squad Marksman
	case "sqd_dmr";
	case "rcn_dmr": {
		for "_i" from 1 to 4 do { player addItemToVest "AMMO"};
		for "_i" from 1 to 4 do { player addItemToBackpack "AMMO_TRACER"};
	};
	// Armour Crew/Pilot
	case "ar_ld";
	case "ar_c";
	case "pil": {
		for "_i" from 1 to 4 do { player addItemToVest "AMMO"};
	};
};

// add secondary ammo
switch (_loadout) do {
	default {for "_i" from 1 to 2 do { player addItemToVest "AMMO"}};
};
// add assistant ammo 
switch (_loadout) do {
	default {};
	// Asst. Rifleman
		case "sqd_aar": {
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO"};
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO_TRACER"};
	};
	// MMG Leader
	case "sup_mmg_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO"};
		for "_i" from 1 to 2 do { player addItemToBackpack "AMMO_TRACER"};
	};
	// MAT Leader
	case "sup_mat_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "HEAT"};
		for "_i" from 1 to 1 do { player addItemToBackpack "HEDP"};
	};
	// HAT Leader 
	case "sup_hat_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "HEAT"};
		for "_i" from 1 to 1 do { player addItemToBackpack "HEDP"};
	};
	// AA Leader
	case "sup_aa_l": {
		for "_i" from 1 to 2 do { player addItemToBackpack "AA"};
	};
	// HAT Leader Javeling
	case "sup_hat_l": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"};
};

// add other ammo 
switch (_loadout) do {
	default {};
	// MAT Gunner
	case "sup_mat_g": {
		for "_i" from 1 to 1 do { player addItemToBackpack "HEAT"};
		for "_i" from 1 to 1 do { player addItemToBackpack "HEDP"};
	};
	// HAT Gunner 
	case "sup_hat_g": {
		for "_i" from 1 to 1 do { player addItemToBackpack "HEAT"};
		for "_i" from 1 to 1 do { player addItemToBackpack "HEDP"};
	};
	// AA Gunner 
	case "sup_aa_g": {
		for "_i" from 1 to 2 do { player addItemToBackpack "AA"};
	};
};

// add grenades NATO
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_an_m8hc"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellGreen"};
		for "_i" from 1 to 1 do { player addItemToVest "SmokeShellRed"};
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
	};
	case "sqd_brc": {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_an_m8hc"};
		for "_i" from 1 to 2 do { player addItemToVest "ACE_M84"};
		for "_i" from 1 to 2 do { player addItemToVest "HandGrenade"};
	};
};

// add 40mm grenades NATO
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
	case "rcn_ld";
	case "sqd_gre": {
		for "_i" from 1 to 10 do {player addItemToBackpack "1Rnd_HE_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_Smoke_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"};
		for "_i" from 1 to 2 do {player addItemToBackpack "UGL_FlareWhite_F"};
	};
};

// add grenades RU
switch (_loadout) do {
	default {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rdg2_white"};
		for "_i" from 1 to 1 do { player addItemToVest "rhssaf_mag_brd_m83_green"};
		for "_i" from 1 to 1 do { player addItemToVest "rhssaf_mag_brd_m83_red"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rgd5"};
	};
	case "sqd_brc": {
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rdg2_white"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_zarya2"};
		for "_i" from 1 to 2 do { player addItemToVest "rhs_mag_rgd5"};
	};
};

// add 40mm grenades RU
switch (_loadout) do {
	default {};
	case "plt": {
		for "_i" from 1 to 5 do {player addItemToBackpack "rhs_VOG25"}; 
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_White"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Red"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Green"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_VG40OP_white"};
	};
	case "sqd_ld";
	case "rcn_ld";
	case "sqd_gre": {
		for "_i" from 1 to 10 do {player addItemToBackpack "rhs_VOG25"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_White"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Red"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_GRD40_Green"};
		for "_i" from 1 to 2 do {player addItemToBackpack "rhs_VG40OP_white"};
	};
};