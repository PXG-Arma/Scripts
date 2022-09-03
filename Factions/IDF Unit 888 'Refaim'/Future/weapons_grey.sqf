params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "rhs_weap_m4a1";
			  player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
			  player addPrimaryWeaponItem "rhsusf_acc_compm4";
			  player addPrimaryWeaponItem "rhsusf_acc_nt4_black";
			  player addPrimaryWeaponItem "rhsusf_acc_rvg_blk";
	};
	case "plt";
	case "sqd_ld";
	case "sqd_gre":{ player addWeapon "rhs_weap_m4a1_m203s";
			  		 player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
			 		 player addPrimaryWeaponItem "rhsusf_acc_compm4";
			 		 player addPrimaryWeaponItem "rhsusf_acc_nt4_black";
	};
	case "rcn_ld":{ player addWeapon "rhs_weap_m4a1_m203s";
			  		player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
			 		player addPrimaryWeaponItem "rhsusf_acc_acog_rmr";
					player addPrimaryWeaponItem "rhsusf_acc_nt4_black";
	};
	case "rcn_spe";
	case "rcn_drone":{ player addWeapon "rhs_weap_m4a1";
			  		   player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
			  		   player addPrimaryWeaponItem "rhsusf_acc_acog_rmr";
			  		   player addPrimaryWeaponItem "rhsusf_acc_nt4_black";
			  		   player addPrimaryWeaponItem "rhsusf_acc_rvg_blk";
	};
	case "rcn_dmr": { player addWeapon "rhs_weap_sr25_ec";
					  player addPrimaryWeaponItem "rhsusf_acc_nxs_3515x50f1_md";
					  player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
					  player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
					  player addPrimaryWeaponItem "rhsusf_acc_aac_762sd_silencer";

	};
};

// add secondary weapon
switch (_loadout) do {
	default {};
	case "rcn_ld";
	case "rcn_spe";
	case "rcn_dmr";
	case "rcn_drone": {player addWeapon "rhsusf_weap_glock17g4";
					   player addHandgunItem "rhsusf_acc_omega9k";
					   player addHandgunItem "acc_flashlight_pistol";
	};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "BWA3_RGW90_Loaded"};
	case "sup_hat_g": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"};
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};
};