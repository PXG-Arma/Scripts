params["_side","_faction","_variant", "_loadout"]; 

// weapon arrays
randomPrimaryArray = ["uk3cb_auga2_blk","rhs_weap_g36kv","rhs_weap_SCARH_FDE_STD","rhs_weap_SCARH_STD","rhs_weap_hk416d145","rhs_weap_m4a1_blockII_KAC","rhsusf_weap_MP7A2"];
randomGLArray = ["rhs_weap_g36kv_ag36","rhs_weap_hk416d145_m320","rhs_weap_m4a1_blockII_M203"]; 
randomDMRArray = ["rhs_weap_sr25_ec","rhs_weap_XM2010"]; 

// attachement arrays
randomOpticArray = ["rhsusf_acc_acog_usmc","rhsusf_acc_g33_xps3","rhsusf_acc_compm4","rhsusf_acc_t1_high","rhsusf_acc_eotech_xps3"];
randomRailArray = ["rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_anpeq15_bk","rhsusf_acc_wmx_bk"];
randomMuzzleArray = ["rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","rhsusf_acc_aac_762sdn6_silencer","rhsusf_acc_rotex_mp7"]; 
randomGripArray = ["rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_grip3"]; 

randomDMROpticArray = ["rhsusf_acc_m8541_mrds","rhsusf_acc_nxs_3515x50_md"]; 
randomDMRMuzzleArray = ["rhsusf_acc_sr25s"]; 

// add primary weapon
switch (_loadout) do {
	default { 
		player addWeapon selectRandom randomPrimaryArray;
		player addPrimaryWeaponItem selectRandom randomOpticArray;
		player addPrimaryWeaponItem selectRandom randomRailArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
		player addPrimaryWeaponItem selectRandom randomGripArray;
	};
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		player addWeapon selectRandom randomGLArray;
		player addPrimaryWeaponItem selectRandom randomOpticArray;
		player addPrimaryWeaponItem selectRandom randomRailArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
	};
	case "rcn_dmr": {
		player addWeapon selectRandom randomDMRArray;
		player addPrimaryWeaponItem selectRandom randomDMROpticArray;
		player addPrimaryWeaponItem selectRandom randomRailArray;
		player addPrimaryWeaponItem selectRandom randomDMRMuzzleArray;
		player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
	};
	case "sqd_hgre": {player addWeapon "rhs_weap_m32"};
	case "sup_mmg_g": {player addWeapon "rhs_weap_m240B";
					   player addPrimaryWeaponItem "rhsusf_acc_acog_mdo";
	};
	case "pil": {};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "rhsusf_weap_m9"};
	case "sup_aa_g";
	case "sup_mat_g";
	case "sup_mmg_g";
	case "sqd_eng";
	case "rcn_spe": {};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_m72a7"};
	case "sup_mat_g": {	player addWeapon "rhs_weap_smaw";
						player addSecondaryWeaponItem "rhs_weap_optic_smaw"};
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};	
};