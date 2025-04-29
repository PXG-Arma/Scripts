params["_side","_faction","_variant", "_loadout"]; 


randomScopeArray = ["optic_MRCO", "optic_Hamr", "optic_Arco_blk_F"];


// add primary weapon
switch (_loadout) do {
	default { player addWeapon "rhs_weap_m4a1_blockII_bk";
			  player addPrimaryWeaponItem selectRandom randomScopeArray;
			  player addPrimaryWeaponItem "BWA3_acc_VarioRay_irlaser_black";
			  player addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";
			  player addPrimaryWeaponItem "rhsusf_acc_grip1";
	};
	case "plt";
	case "rcn_ld";
	case "sqd_ld";
	case "sqd_gre": {player addWeapon "rhs_weap_m4a1_blockII_M203_bk";	
					 player addPrimaryWeaponItem selectRandom randomScopeArray;
					player addPrimaryWeaponItem "BWA3_acc_VarioRay_irlaser_black";
					player addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";
					player addPrimaryWeaponItem "rhsusf_acc_grip_m203_blk";
	};
	case "sqd_brc": {player addWeapon "rhs_weap_M590_8RD";	
	};
	case "rcn_sni": {player addWeapon "rhs_weap_m24sws";
					 player addPrimaryWeaponItem "rhsusf_acc_premier";
					 player addPrimaryWeaponItem "rhsusf_acc_m24_silencer_black";
					 player addPrimaryWeaponItem "rhsusf_acc_harris_swivel";
	};
	case "pil": {};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "UK3CB_BHP";
	};
};
// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": { player addWeapon "rhs_weap_M136"};		
};