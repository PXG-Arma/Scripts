// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// Things of note, PL, TACP, SL, Grenadier, Weapon Team Leads with open backpacks, SF SL, Recon SL and Recon Drone should have grenade launchers. And Backpack deployables go to Uniforms_FactionName isntead.

params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
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
