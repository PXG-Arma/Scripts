params["_side","_faction","_variant", "_loadout"]; 

// weapon arrays
randomPrimaryArray = ["rhs_weap_ak103_zenitco01_b33","rhs_weap_ak104_zenitco01_b33","rhs_weap_ak105_zenitco01_b33","rhs_weap_ak74m_zenitco01_b33","rhs_weap_rpk74m_npz","rhs_weap_asval_grip_npz","rhs_weap_vss_grip_npz"];
randomGLArray = ["rhs_weap_ak103_gp25_npz","rhs_weap_ak74m_gp25_npz","rhs_weap_ak74mr_gp25"]; 
randomDMRArray = ["rhs_weap_svdp_npz","rhs_weap_svds_npz","rhs_weap_t5000"]; 

// attachement arrays
randomOpticArray = ["rhs_acc_1p87","rhs_acc_okp7_picatinny","rhsusf_acc_mrds","rhsusf_acc_su230","rhsusf_acc_eotech_xps3"];
randomRailArray = ["rhs_acc_2dpzenit_ris","rhs_acc_perst1ik_ris","rhs_acc_perst3","rhs_acc_perst3_2dp_h"];
randomMuzzleArray = ["rhs_acc_ak5","rhs_acc_dtk1","rhs_acc_dtk2","rhs_acc_dtk3","rhs_acc_dtk4short","rhs_acc_dtk4screws","rhs_acc_pbs1","rhs_acc_tgpa"]; 
randomGripArray = ["rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhsusf_acc_rvg_blk","rhsusf_acc_grip2"]; 

randomDMROpticArray = ["rhs_acc_dh520x56"]; 
randomDMRMuzzleArray = ["rhs_acc_tgpv2"]; 

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
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
	};
	case "rcn_dmr": {
		player addWeapon selectRandom randomDMRArray;
		player addPrimaryWeaponItem selectRandom randomDMROpticArray;
		player addPrimaryWeaponItem selectRandom randomDMRMuzzleArray;
	};
	case "sup_mmg_g": {player addWeapon "rhs_weap_pkp";
					   player addPrimaryWeaponItem "rhs_acc_1p78";
	};
	case "pil": {};
};

// add secondary weapon
switch (_loadout) do {
	default {player addWeapon "rhs_weap_6p53"};
	case "sup_aa_g";
	case "sup_mat_g";
	case "sup_mmg_g";
	case "sqd_eng";
	case "rcn_spe": {};
};

// add launcher
switch (_loadout) do {
	default {};
	case "sqd_lat": {player addWeapon "rhs_weap_rpg75"};
	case "sup_mat_g": {	player addWeapon "rhs_weap_rpg7";
						player addSecondaryWeaponItem "rhs_acc_pgo7v3"};
	case "sup_aa_g": {	player addWeapon "rhs_weap_igla"};	
};