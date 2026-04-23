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
		case "Assault Rifles": { ["UK3CB_BAF_L85A2_EMAG", "UK3CB_BAF_L85A2_RIS"] };
		case "SF Rifles": { ["UK3CB_BAF_L119A1_RIS"] };
		case "SF Lead Rifles": { ["UK3CB_BAF_L119A1_UKUGL"] };
		case "Lead Rifles": { ["UK3CB_BAF_L85A2_UGL"] };
		case "Machine Guns": { ["UK3CB_BAF_L110A3"] };
		case "DMR": { ["UK3CB_BAF_L129A1"] };
		case "Snipers": { ["UK3CB_BAF_L115A3_DE"] };
		case "AMR": { ["UK3CB_BAF_L135A1"] };
		case "Cavalry Rifles": { ["UK3CB_BAF_L22A2"] };
		case "Shotguns": { ["UK3CB_BAF_L128A1"] };

		//Support Elements
		case "MMG": { ["UK3CB_BAF_L7A2"] };
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
		case "sqd_hgre": { ["Assault Rifles"] };
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
				case "Lead Rifles": { ["RKSL_optic_LDS", "UK3CB_BAF_SUSAT", "RKSL_optic_EOT552"] };
				case "Machine Guns": { ["rhsusf_acc_elcan", "RKSL_optic_EOT552"] };
				case "Shotguns": { ["RKSL_optic_EOT552"] };
				default { [] };
			};
		};
		case "Recon";
		case "Special Forces": {
			switch (_weaponGroup) do {
				case "Assault Rifles";
				case "Lead Rifles": { ["RKSL_optic_LDS", "UK3CB_BAF_SUSAT", "RKSL_optic_EOT552"] };
				case "SF Lead Rifles";
				case "SF Rifles": { ["RKSL_optic_LDS", "UK3CB_BAF_SUSAT", "RKSL_optic_EOT552"] };
				case "DMR": { ["UK3CB_BAF_TA648", "rhsusf_acc_M8541"] };
				case "Snipers": { ["rhsusf_acc_M8541", "rhsusf_acc_premier_low"] };
				case "AMR": { ["rhsusf_acc_M8541", "rhsusf_acc_premier_low"] };
				case "Machine Guns": { ["rhsusf_acc_elcan", "RKSL_optic_EOT552"] };
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
			
		case "Support Elements";	
		case "Squad Members": {
			switch (_weapon) do {
				// --- Individual Classname Overrides ---
				case "UK3CB_BAF_L85A2_RIS": { ["", "UK3CB_BAF_LLM_IR_Black", ""] };
				case "UK3CB_BAF_L85A2_EMAG": { ["", "", ""] };
				case "UK3CB_BAF_L128A1": { ["", "UK3CB_BAF_LLM_IR_Black", ""] };
				default { ["", "", ""] };
			};
        };
		case "Special Forces";
		case "Recon": {
			switch (_weaponGroup) do {
				case "SF Rifles": { ["UK3CB_BAF_Silencer_L85", "UK3CB_BAF_LLM_IR_Black", "UK3CB_underbarrel_acc_grippod"] };
				case "SF Lead Rifles": { ["UK3CB_BAF_Silencer_L85", "UK3CB_BAF_LLM_IR_Black", ""] };
				case "Lead Rifles": { ["", "UK3CB_BAF_LLM_IR_Black", ""] };
				case "Assault Rifles": { ["", "UK3CB_BAF_LLM_IR_Black", ""] };
				case "Machine Guns": { ["UK3CB_BAF_Silencer_L110", "UK3CB_BAF_LLM_IR_Black", ""] };
				case "DMR": { ["UK3CB_BAF_Silencer_L115A3", "UK3CB_BAF_LLM_IR_Black", "UK3CB_underbarrel_acc_fgrip_bipod"] };
				case "Snipers": { ["", "", "UK3CB_underbarrel_acc_bipod"] };
				case "AMR": { ["", "", ""] };
				default { ["", "", ""] };
			};
		};
		default {
			switch (_weaponGroup) do {
				// --- Gun Group Standards ---
				case "Lead Rifles": { ["", "UK3CB_BAF_LLM_IR_Black", ""] };
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
				default { "UK3CB_BAF_L131A1" };
			};
		};
	};
	_secondary
};

// ====================================================================================
// MODE: LAUNCHER (Launcher Assignment)
if (_mode == "LAUNCHER") exitWith {
	_launcher = switch (_loadout) do {
		case "sf_eng": { ["launch_NLAW_F", [""]] };

		case "sqd_lat": {
			unitBackpack player addItemCargoGlobal["launch_NLAW_F",1];
			 ["launch_NLAW_F", [""]] 
		};
		//SQD Mortar
		case "sqd_hgre": { ["UK3CB_BAF_M6", [""]] };
		//HAT
		case "sup_hat_l";
		case "sup_hat_g": { ["UK3CB_BAF_Javelin_Slung_Tube", [""]] };
		//AA
		case "sup_aa_g": { ["rhs_weap_fim92", [""]] };
		//HMG
		case "sup_hmg_l": {	["ace_csw_m3CarryTripod", [""]] };	
		case "sup_hmg_g": {	["ace_csw_staticM2ShieldSightCarry", [""]] };
		//GMG
		case "sup_gmg_l": {	["ace_csw_m3CarryTripodLow", [""]] };	
		case "sup_gmg_g": {	["ace_compat_rhs_usf3_mk19_carry", [""]] };
		//Mortar
		case "sup_mor_l": { ["ace_csw_carryMortarBaseplate", [""]] };
		case "sup_mor_g": { ["ace_csw_staticMortarCarry", [""]] };

		default { ["", [""]] };
	};
	_launcher
};

