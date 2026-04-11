// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// Mode "GIVE" (default): Assigns weapon to player
// Mode "LIST": Returns array of selectable weapons for the role
// Mode "SCOPES": Returns array of allowed scopes for a specific weapon

params["_side","_faction","_variant", "_loadout", ["_mode", "GIVE"], ["_weapon", ""]]; 

// ====================================================================================
// MODE: LIST (Selectable Weapons for the UI)
if (_mode == "LIST") exitWith {
	_list = switch (_loadout) do {
		case "plt";
		case "sqd_ld": { ["rhs_weap_ak74m_gp25", "rhs_weap_ak74m"] };
		case "sqd_gre": { ["rhs_weap_ak74m_gp25"] };
		case "sqd_ar": { ["rhs_weap_rpk74m"] };
		case "sf_dmr": { ["rhs_weap_svdp"] };
		case "rcn_sni": { ["rhs_weap_t5000"] };
		case "sup_mmg_g": { ["rhs_weap_pkp"] };
		default { ["rhs_weap_ak74m"] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics for each weapon in this faction)
if (_mode == "SCOPES") exitWith {
	_scopes = switch (_weapon) do {
		case "rhs_weap_ak74m_gp25";
		case "rhs_weap_ak74m": { ["rhs_acc_pkas", "rhs_acc_ekp1", "rhs_acc_1p78"] };
		case "rhs_weap_rpk74m": { ["rhs_acc_pkas", "rhs_acc_ekp1", "rhs_acc_1p78"] };
		case "rhs_weap_svdp": { ["rhs_acc_pso1m2"] };
		case "rhs_weap_t5000": { ["rhs_acc_dh520x56"] };
		case "rhs_weap_pkp": { ["rhs_acc_1p78"] };
		default { [] };
	};
	_scopes
};

// ====================================================================================
// MODE: DEFAULT (Returns the classname of the default weapon for the role)
if (_mode == "DEFAULT") exitWith {
	_default = switch (_loadout) do {
		case "sqd_hgre": { "rhs_weap_m32" };
		case "sf_med";
		case "sqd_ar": { "rhs_weap_rpk74m" };
		case "sqd_brc": { "uk3cb_saiga12k" };
		case "sf_dmr": { "rhs_weap_svdp" };
		case "rcn_sni": { "rhs_weap_t5000" };
		case "sup_mmg_g": { "rhs_weap_pkp" };
		case "r_pil";
		case "f_pil";
		case "ar_ld";
		case "ar_c": { "rhs_weap_aks74u" };
		case "plt";
		case "tacp";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "rcn_ld";
		case "rcn_drone";
		case "sf_ld";
		case "sqd_gre";
		case "sqd_ld":{ "rhs_weap_ak74m_gp25" };
		default { "rhs_weap_ak74m" };
	};
	_default
};

// ====================================================================================
// MODE: DEFAULTSCOPE (Returns the classname of the default scope for the role)
if (_mode == "DEFAULTSCOPE") exitWith {
	_defaultScope = switch (_loadout) do {
		case "sf_dmr": { "rhs_acc_pso1m2" };
		case "rcn_sni": { "rhs_acc_dh520x56" };
		case "sup_mmg_g": { "rhs_acc_1p78" };
		case "sf_med";
		case "sqd_ar";
		case "plt";
		case "sqd_ld";
		default { "rhs_acc_pkas" };
	};
	_defaultScope
};

// ====================================================================================
// MODE: GIVE (Original logic for arming the player)
switch (_loadout) do {
	default { player addWeapon "rhs_weap_ak74m";
			  PrimaryWeaponItemArray = ["rhs_acc_pkas","rhs_acc_ekp1"]; 
		      player addPrimaryWeaponItem selectRandom PrimaryWeaponItemArray;
			  player addPrimaryWeaponItem "rhs_acc_perst1ik";
			  player addPrimaryWeaponItem "rhs_acc_dtk";
	};
	case "plt";
	case "tacp";
	case "sup_mmg_l";
	case "sup_hmg_l";
	case "sup_mat_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "rcn_ld";
	case "rcn_drone";
	case "sf_ld";
	case "sqd_gre";
	case "sqd_ld":{ player addWeapon "rhs_weap_ak74m_gp25";
			  PrimaryWeaponItemArray = ["rhs_acc_pkas","rhs_acc_ekp1"]; 
		      player addPrimaryWeaponItem selectRandom PrimaryWeaponItemArray;
			  player addPrimaryWeaponItem "rhs_acc_perst1ik";
			  player addPrimaryWeaponItem "rhs_acc_dtk";
	};
	case "sqd_hgre": { player addWeapon "rhs_weap_m32"};
	case "sf_med";
	case "sqd_ar": {player addWeapon "rhs_weap_rpk74m";
			  PrimaryWeaponItemArray = ["rhs_acc_pkas","rhs_acc_ekp1"]; 
		      player addPrimaryWeaponItem selectRandom PrimaryWeaponItemArray;
			  player addPrimaryWeaponItem "rhs_acc_perst1ik";
			  player addPrimaryWeaponItem "rhs_acc_dtkrpk";
	};
	case "sqd_brc": { player addWeapon "uk3cb_saiga12k"};
	case "sf_dmr": {player addWeapon "rhs_weap_svdp";
					 player addPrimaryWeaponItem "rhs_acc_pso1m2";
	};
	case "rcn_sni": {player addWeapon "rhs_weap_t5000";
					 player addPrimaryWeaponItem "rhs_acc_dh520x56";
					 player addPrimaryWeaponItem "rhs_acc_harris_swivel";
	};
	case "sup_mmg_g": {	player addWeapon "rhs_weap_pkp";
						player addPrimaryWeaponItem "rhs_acc_1p78";
	};
	case "r_pil";
	case "f_pil";
	case "ar_ld";
	case "ar_c": {	player addWeapon "rhs_weap_aks74u"};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "rhs_weap_pya"};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sf_eng": {player addWeapon "rhs_weap_rpg26";};
	case "sqd_lat": {
		unitBackpack player addItemCargoGlobal["rhs_weap_rpg26",1];
		player addWeapon "rhs_weap_rpg26";
	};
	case "sup_mat_g": {player addWeapon "rhs_weap_rpg7";
					   player addSecondaryWeaponItem "rhs_acc_pgo7v3"};				   
	case "sup_aa_g": {	player addWeapon "rhs_weap_igla"};					
};