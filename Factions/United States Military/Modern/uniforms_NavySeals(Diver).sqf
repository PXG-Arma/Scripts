params["_side","_faction","_variant", "_loadout"]; 

// add uniform
switch (_loadout) do {
	default { 
		player forceAddUniform  "U_B_Wetsuit"};
	case "pil": { player forceAddUniform "Arid_Crye_SS_Camo"};
	case "ar_ld";
	case "ar_c": { player forceAddUniform "Arid_Crye_Camo"};
};
	
// add helmet
switch (_loadout) do {
	default { 
		randomHatArray = ["rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw_cam"];
		player addGoggles "G_B_Diving";
		player addHeadgear selectRandom randomHatArray};
	case "pil": {player addHeadgear "rhsusf_hgu56p_visor_tan"};
};

// add vest

switch (_loadout) do {
	default { player addVest "V_RebreatherB"};
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