params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "hlc_rifle_L1A1SLR";};
	case "rcn_spe";
	case "plt_med";
	case "logi";
	case "sup_hat_g";
	case "sqd_med" : { player addWeapon "UK3CB_Sten"};
	case "sqd_ld";
	case "rcn_ld";
	case "tacp";
	case "sqd_gre";
	case "plt": {player addWeapon "UK3CB_M16A2_UGL";

	};
	case "sqd_ar": {player addWeapon "rhs_weap_fnmag";
	};
	case "rcn_sni": {player addWeapon "uk3cb_enfield_l42_walnut";
					 player addPrimaryWeaponItem "uk3cb_optic_no32_distressed";
	};
	case "ar_ld";
	case "ar_c";
	case "pil": { player addWeapon "UK3CB_Sten";
	};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": { player addWeapon "rhs_weap_m72a7"};
	case "sup_hat_g": {	player addWeapon "BWA3_CarlGustav"};
	case "sup_aa_g": {	player addWeapon "UK3CB_Blowpipe"};					
};
