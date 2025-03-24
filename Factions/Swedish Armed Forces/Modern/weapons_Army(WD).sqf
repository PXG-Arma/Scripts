params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "sfp_ak5c";
			  player addPrimaryWeaponItem "sfp_optic_aimpoint"
	};
	case "rcn_ld";
	case "plt";
	case "sqd_gre";
	case "sqd_ld": {player addWeapon "sfp_ak5c_m203";
					player addPrimaryWeaponItem "sfp_optic_aimpoint";
	};
	case "sqd_ar": {player addWeapon "sfp_ksp90c";
					player addPrimaryWeaponItem "sfp_optic_aimpoint";
	};
	case "rcn_dmr": {player addWeapon "hlc_rifle_awMagnum_OD_ghillie";
					 player addPrimaryWeaponItem "sfp_optic_kikarsikte90b_10x";
					 player addPrimaryWeaponItem "rhsusf_acc_aac_scarh_silencer";
	};
	case "sup_mmg_g": {	player addWeapon "sfp_ksp58B2";
	};
	case "logi": {player addWeapon "sfp_ak5dmk2";
				player addPrimaryWeaponItem "sfp_optic_aimpoint";
	};
	case "ar_ld";
	case "ar_c";
	case "hpil";
	case "pil": {player addWeapon "hlc_smg_mp5k_PDW";
	};
	case "rcn_spe";
	case "rcn_drone": {player addWeapon "sfp_ak5c";
					player addPrimaryWeaponItem "sfp_optic_aimpoint";
					player addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
	};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "sfp_p88";
			 player addHandgunItem "sfp_tlr2";
	};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_M136";};
	case "sup_mat_g": {	player addWeapon "BWA3_CarlGustav";
						player addSecondaryWeaponItem "bwa3_optic_carlgustav"};
};