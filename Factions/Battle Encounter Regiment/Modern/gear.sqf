params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "O_UavTerminal";
		[ player, "DRNP_AR2P", 1 ] call pxg_armory_fnc_addToBackpack;
		[ player, "ACE_UAVBattery", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	
};

// add Spotting Scope
switch (_loadout) do {
	case "rcn_dmr": {[ player, "ACE_SpottingScope", 1 ] call pxg_armory_fnc_addToBackpack;
	[ player, "ACE_Tripod", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// attachement randomizer
randomOpticArray = ["rhs_acc_1p87","rhs_acc_okp7_picatinny","rhsusf_acc_mrds","rhsusf_acc_su230","rhsusf_acc_eotech_xps3"];
randomRailArray = ["rhs_acc_2dpzenit_ris","rhs_acc_perst1ik_ris","rhs_acc_perst3","rhs_acc_perst3_2dp_h"];
randomMuzzleArray = ["rhs_acc_ak5","rhs_acc_dtk1","rhs_acc_dtk2","rhs_acc_dtk3","rhs_acc_dtk4short","rhs_acc_dtk4screws","rhs_acc_pbs1","rhs_acc_tgpa"]; 
randomGripArray = ["rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhsusf_acc_rvg_blk","rhsusf_acc_grip2"]; 
randomDMROpticArray = ["rhs_acc_dh520x56"]; 
randomDMRMuzzleArray = ["rhs_acc_tgpv2"]; 

// add attachements
switch (_loadout) do {
	default { 
		player addPrimaryWeaponItem selectRandom randomOpticArray;
		player addPrimaryWeaponItem selectRandom randomRailArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
		player addPrimaryWeaponItem selectRandom randomGripArray;
	};
	case "plt";
	case "sqd_ld";
	case "sqd_gre";
	case "rcn_ld": {
		player addPrimaryWeaponItem selectRandom randomOpticArray;
		player addPrimaryWeaponItem selectRandom randomMuzzleArray;
	};
	case "rcn_dmr": {
		player addPrimaryWeaponItem selectRandom randomDMROpticArray;
		player addPrimaryWeaponItem selectRandom randomDMRMuzzleArray;
	};
};
