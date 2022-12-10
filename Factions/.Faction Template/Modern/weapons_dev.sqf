params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { player addWeapon "CLASS_ID";
			  player addPrimaryWeaponItem "SIGHT";
			  player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
			  player addPrimaryWeaponItem "MUZZLE";
			  player addPrimaryWeaponItem "UNDER-BARREL";
	};
	case "plt";
	case "sqd_ld";
	case "rcn_ld";
	case "sqd_gre": {player addWeapon "CLASS_ID";
					 player addPrimaryWeaponItem "SIGHT";
					 player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
					 player addPrimaryWeaponItem "UNDER-BARREL";
	};
	case "sqd_hgre": {player addWeapon "rhs_weap_m32";
					 player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
	};
	case "sqd_brc": {player addWeapon "CLASS_ID"};
	case "sqd_ar": {player addWeapon "CLASS_ID";
					player addPrimaryWeaponItem "SIGHT";
					player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
					player addPrimaryWeaponItem "MUZZLE";
					player addPrimaryWeaponItem "UNDER-BARREL";
	};
	case "sup_mmg_g": {player addWeapon "CLASS_ID";
					   player addPrimaryWeaponItem "SIGHT";
					   player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
					   player addPrimaryWeaponItem "MUZZLE";
					   player addPrimaryWeaponItem "UNDER-BARREL";
	};
	case "rcn_dmr": {player addWeapon "CLASS_ID";
					 player addPrimaryWeaponItem "SIGHT";
					 player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
					 player addPrimaryWeaponItem "MUZZLE";
					 player addPrimaryWeaponItem "UNDER-BARREL";
	};
	case "rcn_amr": {player addWeapon "CLASS_ID";
					 player addPrimaryWeaponItem "SIGHT";
					 player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser_black";
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {player addWeapon "CLASS_ID"};
};

// add secondary weapon
switch (_loadout) do {
	default { player addWeapon "CLASS_ID"};
};

// add secondary weapon M320
// switch (_loadout) do {
// 	default {};
// 	case "plt";
// 	case "sqd_ld";
// 	case "rcn_ld";
// 	case "sqd_gre": {player addWeapon "rhs_weap_M320"};
// };

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "CLASS_ID"};
	case "sup_mat_g": {	player addWeapon "CLASS_ID";
						player addSecondaryWeaponItem "SIGHT"};
	case "sup_hat_g": {	player addWeapon "CLASS_ID"};
	//case "sup_hat_g": {	player addWeapon "UK3CB_BAF_Javelin_Slung_Tube"}; // Javelin
	case "sup_aa_g": {	player addWeapon "CLASS_ID"};
};