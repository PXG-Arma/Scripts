params["_side","_faction","_variant", "_loadout"]; 
		randomWeaponArray = ["rhs_weap_m4a1_blockII_d","hlc_rifle_RU5562", "hlc_rifle_RU556", "hlc_rifle_416D10_st6", "hlc_rifle_416D10_ptato", "hlc_rifle_416D145_tan", "rhs_weap_hk416d145_d", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_d", "rhs_weap_m4a1_d_mstock", "rhs_weap_mk18_d", "rhs_weap_mk18_KAC_d", "rhs_weap_mk18_KAC"]; 
		randomGLArray = ["hlc_rifle_m4m203", "rhs_weap_m4_m203S", "rhs_weap_m4a1_blockII_M203_d", "rhs_weap_m4a1_blockII_M203", "rhs_weap_m4a1_m203s_d", "arifle_SPAR_01_GL_snd_F", "arifle_SPAR_01_GL_blk_F", "rhs_weap_hk416d145_m320"];
		randomLLMArray = ["BWA3_acc_VarioRay_irlaser","BWA3_acc_VarioRay_irlaser_black", "rhsusf_acc_anpeq15side", "rhsusf_acc_anpeq15_top", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_anpeq15_bk_top", "rhsusf_acc_anpeq15", "rhsusf_acc_anpeq15_bk"]; 
		randomSightArray = ["rhsusf_acc_su230_c","rhsusf_acc_su230", "rhsusf_acc_ACOG_d", "rhsusf_acc_eotech_xps3", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_ACOG", "optic_MRCO", "rhsusf_acc_g33_xps3", "rhsusf_acc_g33_xps3_tan", "rhsusf_acc_EOTECH", "rhsusf_acc_ACOG2_USMC"]; 
		randomMuzzleArray = ["rhsusf_acc_rotex5_tan","rhsusf_acc_rotex5_grey", "BWA3_muzzle_snds_Rotex_IIIC_tan", "BWA3_muzzle_snds_QDSS_tan", "BWA3_muzzle_snds_QDSS", "hlc_muzzle_556NATO_rotexiiic_grey", "hlc_muzzle_556NATO_rotexiiic_tan"]; 
// add primary weapon
switch (_loadout) do {
	default {
		player addWeapon selectRandom randomWeaponArray;
		switch (primaryWeapon player) do {
		player addPrimaryWeaponItem selectRandom randomLLMArray;
		player addPrimaryWeaponItem selectRandom randomSightArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
		};
	/*switch (primaryWeapon player) do {
		
			case "rhs_weap_mk18_d": {
					player addPrimaryWeaponItem selectRandom randomLLMArray;
					player addPrimaryWeaponItem selectRandom randomSightArray;
					player addPrimaryWeaponItem selectRandom randomMuzzleArray;
			};

			case "rhs_weap_m4a1_blockII_KAC_bk": {
					player addPrimaryWeaponItem "rhsusf_acc_su230";
			        player addPrimaryWeaponItem "bwa3_muzzle_snds_qdss_tan";
			        player addPrimaryWeaponItem "rhsusf_acc_tdstubby_tan";
			        player addPrimaryWeaponItem "bwa3_acc_varioray_irlaser"
			};
			
			default {};
		};
	*/
	};
	case "plt";
	case "sqd_ld";
	case "rcn_ld";
	case "sqd_gre":{ player addWeapon selectRandom randomGLArray;
		player addPrimaryWeaponItem selectRandom randomLLMArray;
		player addPrimaryWeaponItem selectRandom randomSightArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
	};
	case "sqd_ar": {player addWeapon "rhs_weap_m249_pip_ris";
		player addPrimaryWeaponItem selectRandom randomLLMArray;
		player addPrimaryWeaponItem selectRandom randomSightArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
	};
	case "rcn_dmr": {player addWeapon "rhs_weap_sr25_d";
					 player addPrimaryWeaponItem "hlc_optic_ATACR";
					 player addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
					 player addPrimaryWeaponItem "rhsusf_acc_SR25S_d";
					 player addPrimaryWeaponItem "HLC_bipod_UTGShooters"
	};
	case "ar_ld";
	case "ar_c";
	case "pil": {player addWeapon "rhs_weap_m4a1_carryhandle"};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "rhsusf_weap_glock17g4";
			 player addHandgunItem "rhsusf_acc_omega9k";}; 
};
// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {
		unitBackpack player addItemCargoGlobal["rhs_weap_M136",1];
		player addWeapon "rhs_weap_M136";
	};
	case "sup_hat_g": {	player addWeapon "rhs_weap_fgm148";
						player addSecondaryWeaponItem "rhs_fgm148_magazine_AT";
						};
	case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};					
};