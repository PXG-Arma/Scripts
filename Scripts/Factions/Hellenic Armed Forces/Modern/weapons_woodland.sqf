params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "hlc_rifle_g3a3";
			  player addPrimaryWeaponItem "hlc_optic_STANAGZF2D_G3"
	};
	case "sqd_ar": {player addWeapon "hlc_lmg_MG3_optic";
					player addPrimaryWeaponItem "ACE_optic_MRCO_2D"
	};	
	case "rcn_dmr": {player addWeapon "hlc_rifle_g3sg1ris";
					 player addPrimaryWeaponItem "rhsusf_acc_leupoldmk4";
					 player addPrimaryWeaponItem "hlc_muzzle_SF3P_762R";
	};
	case "sup_mmg_g": {	player addWeapon "hlc_lmg_MG3_optic";
						player addPrimaryWeaponItem "ACE_optic_MRCO_2D"
	};
	case "ar_c";
	case "pil": {player addWeapon "hlc_rifle_g3a3"};
};

// add secondary weapon
switch (_loadout) do {
	default {};
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {player addWeapon "rhs_weap_M320"};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_M136"};
	case "sup_mat_g": {	player addWeapon "rhs_weap_maaws";
						player addSecondaryWeaponItem "rhs_optic_maaws"};
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};						
};