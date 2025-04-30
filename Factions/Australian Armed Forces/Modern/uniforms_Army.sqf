params["_side","_faction","_variant", "_loadout"]; 

randomUniformArray = ["VSM_Multicam_Crye_Camo", "VSM_Multicam_Crye_SS_Camo"],

// add uniform
switch (_loadout) do {
	default { player forceAddUniform selectRandom randomUniformArray};
	case "pil": { player forceAddUniform "rhs_uniform_cu_ocp_1stcav"};
};
	
// add helmet
switch (_loadout) do {
	default { player addHeadgear "VSM_Mich2000_Multicam"};
    case "ar_ld";
	case "ar_c": {player addHeadgear "rhsusf_cvc_ess"};
	case "pil": {randomOfficerHelmetArray1 = ["rhsusf_hgu56p_visor_mask_Empire_black","rhsusf_hgu56p_visor_black","rhsusf_hgu56p_visor_mask_black_skull"];
		player addHeadgear selectRandom randomOfficerHelmetArray1;};
};

// add vest
switch (_loadout) do {
	default { player addVest "VSM_RAV_operator_Multicam"};
	case "ar_ld";
	case "ar_c";
	case "pil": { player addVest "rhsusf_spcs_ocp"};
};

// add backpack 
switch (_loadout) do {
	default { player addBackpack "VSM_Multicam_Backpack_Kitbag"};
	case "sup_mat_g";
	case "sup_mat_l": {player addBackpack "BWA3_CarrVSM_Multicam_carryallyall_Tropen"};
	case "sup_mor_l": {player addBackpack "O_Mortar_01_support_F"};
	case "sup_mor_g": {player addBackpack "O_Mortar_01_weapon_F"};
	case "pil";
	case "ar_ld";
	case "ar_c": {};
};
