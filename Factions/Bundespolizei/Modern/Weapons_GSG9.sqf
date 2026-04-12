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
		case "logi";
		case "plt_eod";
		case "plt_med";
		case "tacp": { "Lead Elements" };
	//	case "sup_mmg_l";
	//	case "sup_hmg_l";
	//	case "sup_mat_l";
	//	case "sup_hat_l";
	//	case "sup_aa_l";
	//	case "sup_mor_l":

		case "rcn_ld"; //X
		case "rcn_sni"; //X
		case "rcn_amr"; //X
		case "rcn_drone": { "Recon" }; //X

		case "sqd_ld";
		case "sqd_med";
		case "sqd_eng";
		case "sf_dmr"; //X
		case "sqd_brc": { "Squad Members" }; //X
	//	case "sqd_lat";
	//	case "sqd_gre";
	//	case "sqd_hgre";
	//	case "sqd_ar";
	//	case "sqd_aar"

	//	case "sf_ld";
	//	case "sf_med";
	//	case "sf_dmr";
	//	case "sf_eng":{ "Special Forces" };

	//	case "sup_mmg_g";
	//	case "sup_hmg_g";
	//	case "sup_mat_g";
	//	case "sup_hat_g";
	//	case "sup_aa_g";
	//	case "sup_mor_g": { "Support Elements" };

	//	case "ar_ld";
	//	case "ar_c";
		case "r_pil": { "Cavalry" };
	//	case "f_pil":

		default { "" };
	};
	_group
};

// ====================================================================================
// MODE: GUNGROUP (Weapon Groups Mapping)
if (_mode == "GUNGROUP") exitWith {
	_guns = switch (_loadout) do {
		case "Assault Rifles": { ["arifle_SPAR_01_snd_F","rhs_weap_hk416d10_LMT_d","arifle_SPAR_01_blk_F","BWA3_G36KA4", "BWA3_G38C_tan", "BWA3_G38C"] };
		case "MP": { ["UK3CB_MP5A3","BWA3_MP7"] };
		case "Snipers": { ["BWA3_G29"] };
		case "AMR": { ["BWA3_G82"] };
		case "Shotguns": { ["rhs_weap_M590_5RD"] };
		case "DMR": { ["BWA3_G28"] };

		//Support Elements
		default { [] };
	};
	_guns
};

// ====================================================================================
// MODE: WEAPASSIGN (Selectable Weapons for the UI)
if (_mode == "WEAPASSIGN") exitWith {
	_list = switch (_loadout) do {
		case "Lead Elements";
		case "Cavalry": { ["MP"] };
		case "Squad Members": { ["Assault Rifles"] };
		case "Recon": { ["Assault Rifles"] };

        
		case "rcn_sni": { ["Snipers"] };
		case "rcn_amr": { ["AMR"] };
		case "sqd_brc": { ["Shotguns"] };
		case "sf_dmr": { ["DMR"] };

		//Support Elements
		
		default { [] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics for each weapon AND role group)
if (_mode == "SCOPES") exitWith {
	// Nested Hierarchical Switch (Role Group -> Weapon Group)
	_scopes = switch (_roleGroup) do {
		case "Cavalry";
		case "Squad Members";
		case "Lead Elements": {
			switch (_weaponGroup) do {
				case "Assault Rifles": { ["BWA3_optic_EOTech552", "rhsusf_acc_compm4", "rhsusf_acc_eotech_xps3"] };
				case "MP": { ["BWA3_optic_MicroT2", "BWA3_optic_EOTech552", "BWA3_optic_EOTech"] };
				case "DMR": { ["BWA3_optic_PMII_DMR_MicroT1_rear","BWA3_optic_PMII_DMR_MicroT1_front"] };
				default { [] };
			};
		};
		case "Recon": {
			switch (_weaponGroup) do {
				case "Assault Rifles": { ["BWA3_optic_EOTech552", "rhsusf_acc_compm4", "rhsusf_acc_eotech_xps3","rhsusf_acc_g33_xps3_flip", "rhsusf_acc_ACOG_RMR"] };

				case "AMR";
				case "Snipers": { ["BWA3_optic_M5Xi_MSR_MicroT2"] };
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
		case "Lead Elements": {
			switch (_weapon) do {
				case "UK3CB_MP5A3": { ["", "uk3cb_acc_surefiregrip", ""] };
				case "BWA3_MP7": { ["", "BWA3_acc_VarioRay_irlaser_black", ""] };

				default { ["", "", ""] };
			};
		};

		case "Squad Members": {
			switch (_weaponGroup) do {
				case "Assault Rifles": { ["", "BWA3_acc_LLM01_irlaser", ""] };

				default { ["", "", ""] };
			};
		};

		case "Recon": {
			switch (_weaponGroup) do {
				case "Snipers": { ["", "BWA3_bipod_Harris_tan", ""] };

				default { ["", "", ""] };
			};
		};
		default {
			switch (_weapon) do {
				// --- Gun Group Standards ---
				case "MP": { ["", "", ""] };
				case "Assault Rifles": { ["", "", ""] };
				
				// --- Individual Classname Overrides ---
		//		case "rhs_weap_m4a1_carryhandle_m203S": { ["", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_grip_m203_blk"] };

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
				default { "rhsusf_weap_glock17g4" };
			};
		};
	};
	_secondary
};

// ====================================================================================
// MODE: LAUNCHER (Launcher Assignment)
if (_mode == "LAUNCHER") exitWith {
	_launcher = switch (_loadout) do {
		default { ["", [""]] };
	};
	_launcher
};

