params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default {
		randomUniformArray = ["U_BG_Guerrilla_6_1","UK3CB_ION_B_U_CombatSmock_02_WDL","UK3CB_ION_B_U_CombatSmock_04_URB"];
		player forceAddUniform selectRandom randomUniformArray;
	};
};
	
// add helmet
switch (_loadout) do {
	default {
		randomHelmetArray = ["rhsusf_opscore_mar_ut_pelt","rhsusf_opscore_bk_pelt"];
		player addHeadgear selectRandom randomHelmetArray;
	};
};

// add vest
switch (_loadout) do {
	default {
		randomVestArray = ["rhsusf_plateframe_rifleman","rhsusf_mbav_rifleman"];
		player addVest selectRandom randomVestArray;
	};
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		randomGLVestArray = ["rhsusf_plateframe_grenadier","rhsusf_mbav_grenadier"];
		player addVest selectRandom randomGLVestArray;
	};
	case "sqd_med";
	case "rcn_spe": {
		randomMedVestArray = ["rhsusf_plateframe_medic","rhsusf_mbav_medic"];
		player addVest selectRandom randomMedVestArray;
	};
	case "sup_mmg_g": {
		randomMGVestArray = ["rhsusf_plateframe_machinegunner","rhsusf_mbav_mg"];
		player addVest selectRandom randomMGVestArray;
	};
	case "pil": { player addVest "rhsusf_plateframe_light"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "rhsusf_assault_eagleaiii_coy"};
	case "sqd_med";
	case "rcn_spe": {player addBackpack "rhsusf_assault_eagleaiii_coy"};
	case "sup_mmg_l";
	case "sup_mmg_g": {player addBackpack "rhsusf_assault_eagleaiii_coy"};
	case "pil": {};
};