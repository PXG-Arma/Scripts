params["_side","_faction","_variant", "_loadout"]; 

// add primary weapon
switch (_loadout) do {
	default { 
		randomWeaponArray = ["rhs_weap_akm","rhs_weap_m38"]; 
		player addWeapon selectRandom randomWeaponArray;
	};
};

// add secondary weapon
//switch (_loadout) do {
//	default {};
//};

// add launcher
//switch (_loadout) do {
//	default {};
//};