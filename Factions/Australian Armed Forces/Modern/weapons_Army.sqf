params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "hlc_rifle_auga3";
			  player addPrimaryWeaponItem "rhsusf_acc_su230";
			  player addPrimaryWeaponItem "rhsusf_acc_anpeq15";
			  player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";

	};
	case "rcn_ld";
	case "plt";
	case "sqd_gre";
	case "sqd_ld": {player addWeapon "hlc_rifle_auga3_GL";
					player addPrimaryWeaponItem "rhsusf_acc_su230";
			        player addPrimaryWeaponItem "rhsusf_acc_anpeq15"
	};
	case "sqd_ar": {player addWeapon "hlc_lmg_minimi_railed";
					player addPrimaryWeaponItem "rhsusf_acc_su230";
	};
	case "rcn_sni": {player addWeapon "hlc_rifle_awmagnum";
					 player addPrimaryWeaponItem "rhsusf_acc_premier_low";
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {player addWeapon "hlc_rifle_augpara"};
};

// add secondary weapon
switch (_loadout) do {
	default {};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_m72a7";
	                 unitBackpack player addItemCargoGlobal["rhs_weap_m72a7",1]};
	case "sup_aa_g": {player addWeapon "rhs_weap_fim92"};
	case "sup_mat_g": {	player addWeapon "BWA3_CarlGustav";
						player addSecondaryWeaponItem "bwa3_optic_carlgustav"};
	case "sup_hat_g": {	player addWeapon "rhs_weap_fgm148";
						player addSecondaryWeaponItem "rhs_fgm148_magazine_AT";
						};		
};