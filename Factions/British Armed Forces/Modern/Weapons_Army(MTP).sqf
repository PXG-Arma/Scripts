// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// Things of note, PL, TACP, SL, Grenadier, Weapon Team Leads with open backpacks, SF SL, Recon SL and Recon Drone should have grenade launchers. And Backpack deployables go to Uniforms_FactionName isntead.

params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "UK3CB_BAF_L85A2_EMAG";
			  player addPrimaryWeaponItem "RKSL_optic_LDS";
	};
	case "plt";
	case "tacp";
	case "sup_mmg_l";
	case "sup_hmg_l";
	case "sup_mat_l";
	case "sup_hat_l";
	case "sup_aa_l";
	case "sqd_gre";
	case "sqd_ld":{ player addWeapon "UK3CB_BAF_L85A2_UGL";
					player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
					player addPrimaryWeaponItem "RKSL_optic_LDS";
	};
	case "sf_med": {player addWeapon "UK3CB_BAF_L110A3";
					player addPrimaryWeaponItem "RKSL_optic_EOT552";
					player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L110";
					player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
	};
	case "sqd_ar": {player addWeapon "UK3CB_BAF_L110A3";
					player addPrimaryWeaponItem "RKSL_optic_EOT552";
					player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
	};
	case "sqd_brc": { player addWeapon "UK3CB_BAF_L128A1";
					  player addPrimaryWeaponItem "RKSL_optic_EOT552";};
	case "sf_ld": {player addWeapon "UK3CB_BAF_L119A1_UKUGL";
					 player addPrimaryWeaponItem "RKSL_optic_LDS";
					 player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
					 player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L85";
	};
	case "sf_eng": {player addWeapon "UK3CB_BAF_L119A1_RIS";
					 player addPrimaryWeaponItem "RKSL_optic_LDS";
					 player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
					 player addPrimaryWeaponItem "UK3CB_underbarrel_acc_grippod";
					 player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L85";
	};
	case "sf_dmr": {player addWeapon "UK3CB_BAF_L129A1";
					 player addPrimaryWeaponItem "UK3CB_BAF_TA648";
					 player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
					 player addPrimaryWeaponItem "UK3CB_underbarrel_acc_fgrip_bipod";
					 player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L115A3";
	};
	case "rcn_ld";
	case "rcn_drone":{ player addWeapon "UK3CB_BAF_L85A2_UGL";
					player addPrimaryWeaponItem "UK3CB_BAF_LLM_IR_Black";
					player addPrimaryWeaponItem "RKSL_optic_LDS";
					 player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L85";
	};
	case "rcn_sni": {player addWeapon "UK3CB_BAF_L115A3_Ghillie";
					 player addPrimaryWeaponItem "rhsusf_acc_M8541";
					 player addPrimaryWeaponItem "UK3CB_BAF_Silencer_L115A3";
					 player addPrimaryWeaponItem "UK3CB_underbarrel_acc_bipod";
	};
	case "rcn_amr": {player addWeapon "UK3CB_BAF_L135A1";
					 player addPrimaryWeaponItem "rhsusf_acc_M8541";
	};
	case "sup_mmg_g": {	player addWeapon "UK3CB_BAF_L7A2";
	};
	case "r_pil";
	case "f_pil";
	case "ar_ld";
	case "ar_c": {	player addWeapon "UK3CB_BAF_L22A2"};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "UK3CB_BAF_L131A1"};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sf_eng": {player addWeapon "UK3CB_BAF_NLAW_Launcher";};
	case "sqd_lat": {
		unitBackpack player addItemCargoGlobal["UK3CB_BAF_NLAW_Launcher",1];
		player addWeapon "UK3CB_BAF_NLAW_Launcher";
	};
	case "sup_hat_g": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"};
	case "sup_hat_l": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"};
	case "sqd_hgre": {	player addWeapon "UK3CB_BAF_M6"};				   
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};					
};