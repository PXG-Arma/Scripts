params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "rhs_weap_m4a1_blockII_d";
			  player addPrimaryWeaponItem "rhsusf_acc_acog_rmr";
			  player addPrimaryWeaponItem "rhsusf_acc_kac_grip"
	};
	case "plt";
	case "sqd_ld";
	case "rcn_ld";
	case "sqd_gre":{ player addWeapon "rhs_weap_mk18_m320";
					 player addPrimaryWeaponItem "rhsusf_acc_acog_rmr";
	};
	case "sqd_ar": {player addWeapon "hlc_lmg_mk46mod1";
					player addPrimaryWeaponItem "rhsusf_acc_sf3p556";
					player addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	};
	case "rcn_dmr": {player addWeapon "rhs_weap_sr25_ec";
					 player addPrimaryWeaponItem "rhsusf_acc_nxs_3515x50_md";
					 player addPrimaryWeaponItem "rhsusf_acc_harris_bipod"
	};
	case "sup_mmg_g": {player addWeapon "hlc_lmg_mk48mod1";
					   player addPrimaryWeaponItem "rhsusf_acc_acog_mdo";
	};
	case "sqd_hgre": {player addWeapon "rhs_weap_m32"};
};

// add secondary weapon
switch (_loadout) do {
	case "sqd_hgre": {player addWeapon "hgun_Pistol_heavy_01_green_F";
					  player addPrimaryWeaponItem "optic_MRD_black"};
	default { };
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_M136"};
	case "sup_hat_g": {	player addWeapon "launch_I_Titan_short_F"};
};

