params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { 
		randomUniformArray = ["VSM_AOR1_Crye_SS_tan_shirt_Camo", "VSM_AOR1_Crye_SS_Camo", "VSM_AOR1_tan_shirt_Camo", "VSM_AOR1_Camo", "VSM_AOR1_tan_shirt_Camo_SS", "VSM_AOR1_Crye_tan_shirt_Camo", "VSM_AOR1_Crye_Camo"];
		player forceAddUniform selectRandom randomUniformArray;};
	case "pil": { player forceAddUniform "Arid_Crye_SS_Camo"};
	case "ar_ld";
	case "ar_c": { player forceAddUniform "Arid_Crye_Camo"};
};
	
// add helmet
switch (_loadout) do {
	default { 
		randomHatArray = ["rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw_cam"];
		player addHeadgear selectRandom randomHatArray};
	case "pil": {player addHeadgear "rhsusf_hgu56p_visor_tan"};
};

// add vest
randomVest = ["dr_ARDfacp_op", "CarrierRig_Operator_Arid", "dr_ARDlbt_op", "dr_ARDpar_op", "VSM_FAPC_Operator_Multicam", "VSM_CarrierRig_Operator_Multicam", "VSM_LBT6094_operator_Multicam", "VSM_RAV_operator_Multicam", "VSM_FAPC_Operator_OGA", "VSM_CarrierRig_Operator_OGA", "VSM_LBT6094_operator_OGA", "VSM_RAV_operator_OGA", "VSM_RAV_operator_OGA_OD", "VSM_LBT6094_operator_OGA_OD", "VSM_CarrierRig_Operator_OGA_OD", "VSM_FAPC_Operator_OGA_OD"];
randomVestMG = ["VSM_FAPC_MG_Multicam", "VSM_LBT6094_MG_Multicam", "VSM_RAV_MG_Multicam", "VSM_FAPC_MG_OGA", "VSM_LBT6094_MG_OGA", "VSM_FAPC_MG_OGA_OD", "VSM_LBT6094_MG_OGA_OD", "VSM_RAV_MG_OGA_OD", "mbavr_mg", "mbavkhk_mg", "rhsusf_spc_mg"];
randomVestMed = ["mbavr_m", "mbavkhk_m", "UK3CB_V_MBAV_MEDIC_MULTI", "rhsusf_mbav_medic"];


switch (_loadout) do {
	default { player addVest selectRandom randomVest};
	case "rcn_spe";
	case "sqd_med" : { player addVest selectRandom randomVestMed};
	case "sqd_ar" : { player addVest selectRandom randomVestMG};
	case "pil": { player addVest "CarrierRig_Operator_Arid"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "UK3CB_B_Invisible"};
	/*case "sup_hat_l";
	case "sup_hat_g";
	case "sup_aa_l": {player addBackpack "Arid_Carryall"};*/
	case "pil": {};
};