// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// Things of note, PL, TACP, SL, Grenadier, Weapon Team Leads with open backpacks, SF SL, Recon SL and Recon Drone should have grenade launchers. And Backpack deployables go to Uniforms_FactionName isntead.

params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "rhs_weap_m4a1_carryhandle";
			  PrimaryWeaponItemArray = ["rhsusf_acc_compm4","rhsusf_acc_eotech_xps3"]; 
		      player addPrimaryWeaponItem selectRandom PrimaryWeaponItemArray;
			  player addPrimaryWeaponItem "rhsusf_acc_grip3";
			  player addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk_top";
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
	case "sqd_ld":{ player addWeapon "rhs_weap_m4a1_carryhandle_m203S";
	                PrimaryWeaponItemArray1 = ["rhsusf_acc_compm4","rhsusf_acc_eotech_xps3"];
					player addPrimaryWeaponItem selectRandom PrimaryWeaponItemArray1;
					player addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
					player addPrimaryWeaponItem "rhsusf_acc_grip_m203_blk";
	};
	case "sqd_hgre": { player addWeapon "rhs_weap_m32"};
	case "sf_med";
	case "sqd_ar": {player addWeapon "rhs_weap_m249_pip_L_para";
					player addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	};
	case "sqd_brc": { player addWeapon "rhs_weap_M590_8RD"};
	case "sf_dmr": {player addWeapon "rhs_weap_m14ebrri";
					 player addPrimaryWeaponItem "rhsusf_acc_ACOG_RMR";
					 player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
					 player addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
	};
	case "rcn_sni": {player addWeapon "rhs_weap_m40a5_d";
					 player addPrimaryWeaponItem "rhsusf_acc_M8541_low_d";
					 player addPrimaryWeaponItem "rhsusf_acc_harris_swivel";
	};
	case "rcn_amr": {player addWeapon "rhs_weap_M107";
					 player addPrimaryWeaponItem "rhsusf_acc_M8541";
	};
	case "sup_mmg_g": {	player addWeapon "rhs_weap_m240G";
						player addPrimaryWeaponItem "rhsusf_acc_elcan";
	};
	case "r_pil";
	case "f_pil";
	case "ar_ld";
	case "ar_c": {	player addWeapon "rhs_weap_m4"};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "rhsusf_weap_m9"};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sf_eng": {player addWeapon "rhs_weap_M136";};
	case "sqd_lat": {
		unitBackpack player addItemCargoGlobal["rhs_weap_M136",1];
		player addWeapon "rhs_weap_M136";
	};
	case "sup_mat_g": {player addWeapon "rhs_weap_maaws";
					   player addSecondaryWeaponItem "rhs_optic_maaws"};
	case "sup_hat_g": {	player addWeapon "rhs_weap_fgm148";
						player addSecondaryWeaponItem "rhs_fgm148_magazine_AT";};					   
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};					
};
