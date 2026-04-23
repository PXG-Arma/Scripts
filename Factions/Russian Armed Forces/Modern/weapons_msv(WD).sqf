// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon, scope, and attachments
// MODE "SLOTGROUP": Maps Roles to Groups, those are called SLOTGROUP.
// MODE "GUNGROUP": Maps Guns to Groups, those are called GUNGROUP.
// MODE "WEAPASSIGN": Maps GUNGROUPS to SLOTGROUPS or individual Roles
// MODE "SCOPES": Maps selectable Scopes to SLOTGROUPS and then GUNGROUPS
// MODE "SECONDARY": Maps the secondary Weapon
// MODE "LAUNCHER": Maps the Launcher to a role
// MODE "ATTACHMENTS": Returns standard attachments [Muzzle, Rail, Underbarrel] for a weapon

params["_side","_faction","_variant", "_loadout", ["_mode", "WEAPASSIGN"], ["_weapon", ""], ["_weaponGroup", ""], ["_roleGroup", ""]]; 

// ====================================================================================
// MODE: SLOTGROUP (Maps Roles to Groups.)
if (_mode == "SLOTGROUP") exitWith {
	_group = switch (_loadout) do {
		case "plt";
		case "tacp";
		case "sqd_ld";
		case "sup_mmg_l";
		case "sup_hmg_l";
		case "sup_gmg_l";
		case "sup_mat_l";
		case "sup_hat_l";
		case "sup_aa_l";
		case "sup_mor_l": { "Lead Elements" };

		case "rcn_ld"; //X
		case "rcn_sni"; //X
		case "rcn_amr"; //X
		case "rcn_drone": { "Recon" }; //X

		case "logi";
		case "plt_eod";
		case "plt_med";
		case "sqd_med";
		case "sqd_eng";
		case "sqd_lat"; //X
		case "sqd_brc"; //X
		case "sqd_gre"; //X
		case "sqd_hgre"; //X
		case "sqd_ar"; //X
		case "sqd_aar":{ "Squad Members" };

		case "sf_ld"; //X
		case "sf_med"; //X
		case "sf_dmr"; //X
		case "sf_eng":{ "Special Forces" };

		case "sup_mmg_g";
		case "sup_hmg_g";
		case "sup_gmg_g";
		case "sup_mat_g";
		case "sup_hat_g";
		case "sup_aa_g";
		case "sup_mor_g": { "Support Elements" };

		case "ar_ld";
		case "ar_c";
		case "r_pil";
		case "f_pil": { "Cavalry" };

		default { "" };
	};
	_group
};

// ====================================================================================
// MODE: GUNGROUP (Weapon Groups Mapping)
if (_mode == "GUNGROUP") exitWith {
	_guns = switch (_loadout) do {
		case "Assault Rifles": { ["rhs_weap_ak74m"] };
		case "SF Rifles": { ["rhs_weap_ak74m"] };
		case "SF Lead Rifles": { ["rhs_weap_ak74m_gp25"] };
		case "Lead Rifles": { ["rhs_weap_ak74m_gp25"] };
		case "Machine Guns": { ["rhs_weap_rpk74m"] };
		case "DMR": { ["rhs_weap_svdp"] };
		case "Snipers": { ["rhs_weap_t5000"] };
		case "Cavalry Rifles": { ["rhs_weap_aks74u"] };
		case "Shotguns": { ["uk3cb_saiga12k"] };

		//Support Elements
		case "MMG": { ["rhs_weap_pkp"] };
		default { [] };
	};
	_guns
};

// ====================================================================================
// MODE: WEAPASSIGN (Selectable Weapons for the UI)
if (_mode == "WEAPASSIGN") exitWith {
	_list = switch (_loadout) do {
		case "Lead Elements": { ["Lead Rifles"] };
		case "Squad Members": { ["Assault Rifles"] };
		case "Support Elements": { ["Assault Rifles"] };
		case "Recon": { ["Assault Rifles"] };
		case "Cavalry": { ["Cavalry Rifles"] };
		case "Special Forces": { ["SF Rifles"] };
        
		case "sf_med";
		case "sqd_ar": { ["Machine Guns"] };
		case "rcn_sni": { ["Snipers"] };
		case "rcn_amr": { ["AMR"] };
		case "sqd_hgre": { ["Heavy Weapons"] };
		case "sqd_brc": { ["Shotguns"] };
		case "rcn_ld";
		case "rcn_drone";
		case "sqd_gre": { ["Lead Rifles"] };
		case "sf_ld": { ["SF Lead Rifles"] };
		case "sf_dmr": { ["DMR"] };

		//Support Elements

		case "sup_mmg_g": { ["MMG"] };
		
		default { [] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics for each weapon AND role group)
if (_mode == "SCOPES") exitWith {
	// Nested Hierarchical Switch (Role Group -> Weapon Group)
	_scopes = switch (_roleGroup) do {
		case "Support Elements";
		case "Squad Members";
		case "Lead Elements": {
			switch (_weaponGroup) do {
				case "Assault Rifles";
				case "Lead Rifles": { ["rhs_acc_pkas", "rhs_acc_ekp1"] };
				case "Machine Guns": { ["rhs_acc_pkas", "rhs_acc_ekp1"] };
				case "Shotguns": { ["rhs_acc_ekp1"] };
				case "MMG": { ["rhs_acc_1p78"] };
				default { [] };
			};
		};
		case "Recon";
		case "Special Forces": {
			switch (_weaponGroup) do {
				case "Assault Rifles";
				case "Lead Rifles": { ["rhs_acc_pkas", "rhs_acc_ekp1"] };
				case "SF Lead Rifles";
				case "SF Rifles": { ["rhs_acc_pkas", "rhs_acc_ekp1"] };
				case "DMR": { ["rhs_acc_pso1m2"] };
				case "Snipers": { ["rhs_acc_dh520x56"] };
				case "Machine Guns": { ["rhs_acc_pkas", "rhs_acc_ekp1"] };
				default { [] };
			};
		};
		default { 
			switch (_weaponGroup) do {
				default { [] };
			};
		};
	};
	_scopes
};

// ====================================================================================
// MODE: ATTACHMENTS (Standard Attachments for each weapon or group)
if (_mode == "ATTACHMENTS") exitWith {
	_attachments = switch (_roleGroup) do {
		case "Special Forces";
		case "Recon": {
			switch (_weaponGroup) do {
				case "SF Lead Rifles": { ["rhs_acc_dtk", "", ""] };
				case "SF Rifles": { ["rhs_acc_dtk", "rhs_acc_perst1ik", ""] };
				case "Lead Rifles": { ["rhs_acc_dtk", "", ""] };
				case "Assault Rifles": { ["rhs_acc_dtk", "rhs_acc_perst1ik", ""] };
				case "Machine Guns": { ["rhs_acc_dtkrpk", "rhs_acc_perst1ik", ""] };
				case "Snipers": { ["", "", "rhs_acc_harris_swivel"] };
				default { ["", "", ""] };
			};
		};
		default {
			switch (_weapon) do {
				// --- Gun Group Standards ---
				case "Lead Rifles": { ["rhs_acc_dtk", "", ""] };
				case "Assault Rifles": { ["rhs_acc_dtk", "rhs_acc_perst1ik", ""] };
				case "Machine Guns": { ["rhs_acc_dtkrpk", "rhs_acc_perst1ik", ""] };
				default { ["", "", ""] };
			};
		};
	};
	_attachments
};

// ====================================================================================
// MODE: SECONDARY (Handgun Assignment)
if (_mode == "SECONDARY") exitWith {
	_secondary = switch (_loadout) do {
		// --- Individual Role Overrides ---
//		case "logi";
//		case "plt": {"rhs_weap_pp2000_folded"};					//UNCOMMENT FOR INDIVIDUAL ROLES
		default {
		// ---SLOTGROUP mapping---
			switch (_roleGroup) do {
//				case "Lead Elements": { "rhs_weap_pb_6p9" };	//UNCOMMENT FOR GROUPS
				default { "rhs_weap_pya" };
			};
		};
	};
	_secondary
};

// ====================================================================================
// MODE: LAUNCHER (Launcher Assignment)
if (_mode == "LAUNCHER") exitWith {
	_launcher = switch (_loadout) do {
		case "sf_eng": { ["rhs_weap_rpg26", [""]] };

		case "sqd_lat": {
			unitBackpack player addItemCargoGlobal["rhs_weap_rpg26",1];
			 ["rhs_weap_rpg26", [""]] 
		};
		//MAT
		case "sup_mat_g": { ["rhs_weap_rpg7", ["rhs_acc_pgo7v3"]] };
		//HAT
		case "sup_hat_g": { ["ace_compat_rhs_afrf3_kornet_carry", [""]] };
		//AA
		case "sup_aa_g": { ["rhs_weap_igla", [""]] };
		//HMG
		case "sup_hmg_l": {	["ace_csw_kordCarryTripod", [""]] };	
		case "sup_hmg_g": {	["ace_compat_rhs_afrf3_kord_carry", [""]] };
		//GMG
		case "sup_gmg_l": {	["ace_csw_sag30CarryTripod", [""]] };	
		case "sup_gmg_g": {	["ace_compat_rhs_afrf3_ags30_carry", [""]] };
		//Mortar
		case "sup_mor_l": { ["ace_csw_carryMortarBaseplate", [""]] };
		case "sup_mor_g": { ["ace_csw_staticMortarCarry", [""]] };

		default { ["", [""]] };
	};
	_launcher
};

