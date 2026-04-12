// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// Things of note, PL, TACP, SL, Grenadier, Weapon Team Leads with open backpacks, SF SL, Recon SL and Recon Drone should have grenade launchers. And Backpack deployables go to Uniforms_FactionName isntead.

params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "rhs_weap_akm_zenitco01_b33";
			  player addPrimaryWeaponItem "rhsusf_acc_eotech_552";
			  player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
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
	case "sqd_gre";
	case "sqd_ld":{player addWeapon "rhs_weap_akmn_gp25_npz";
					player addPrimaryWeaponItem "rhsusf_acc_eotech_552";
	};
	
	case "sf_ld": {player addWeapon "rhs_weap_ak103_gp25_npz";
					player addPrimaryWeaponItem "rhsusf_acc_su230a";
	};
	case "sf_eng": {player addWeapon "rhs_weap_ak103_zenitco01_b33";
					   player addPrimaryWeaponItem "rhsusf_acc_su230a";
					   player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
	};
	case "sf_med";
	case "sqd_ar": {player addWeapon "UK3CB_RPK";
	};
	case "sqd_brc": { player addWeapon "rhs_weap_M590_8RD"};
	case "sf_dmr": {player addWeapon "rhs_weap_svd";
					 player addPrimaryWeaponItem "rhs_acc_pso1m21_svd";
	
	};
	case "rcn_sni": {player addWeapon "rhs_weap_t5000";
					 player addPrimaryWeaponItem "rhs_acc_dh520x56";
					 player addPrimaryWeaponItem "rhs_acc_harris_swivel";
	};
	case "rcn_amr": {player addWeapon "rhs_weap_M107";
					 player addPrimaryWeaponItem "rhsusf_acc_M8541";
	};
	case "sup_mmg_g": {player addWeapon "rhs_weap_pkp";
					   player addPrimaryWeaponItem "rhs_acc_1p29_pkp";
	};
	case "r_pil";
	case "f_pil";
	case "ar_ld";
	case "ar_c": {player addWeapon "rhs_weap_akms"};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "UK3CB_BHP"};
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
