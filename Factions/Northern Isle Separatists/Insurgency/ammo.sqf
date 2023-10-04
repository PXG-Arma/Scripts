params["_side","_faction","_variant", "_loadout"]; 

// add primary ammo 
switch (_loadout) do {
	default {
		switch (primaryWeapon player) do {
		
			case "uk3cb_stgw57_5104": {
					[ player, "UK3CB_STGW57_AMT_20Rnd_762x51", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "UK3CB_STGW57_AMT_20Rnd_762x51", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_m14": {
					[ player, "rhsusf_20Rnd_762x51_m80_Mag", 4 ] call pxg_armory_fnc_addToVest;
					[ player, "rhsusf_20Rnd_762x51_m80_Mag", 2 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_m1garand_sa43": {
				[ player, "rhsgref_8Rnd_762x63_M2B_M1rifle", 8 ] call pxg_armory_fnc_addToVest;
				[ player, "rhsgref_8Rnd_762x63_M2B_M1rifle", 8 ] call pxg_armory_fnc_addToBackpack;
			};
			case "rhs_weap_aks74": {
				[ player, "rhs_30Rnd_545x39_7N6_AK", 4 ] call pxg_armory_fnc_addToVest;
				[ player, "rhs_30Rnd_545x39_7N6_AK", 4 ] call pxg_armory_fnc_addToBackpack;
			};
			
			default {};
		};
	};
	case "sqd_ar": {
		[ player, "UK3CB_Bren_30Rnd_762x51_Magazine_GT", 4 ] call pxg_armory_fnc_addToVest;
		[ player, "UK3CB_Bren_30Rnd_762x51_Magazine", 8 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_dmr": {
		[ player, "UK3CB_M14_20rnd_762x51", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_M14_20rnd_762x51_RT", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_g": {
		[ player, "UK3CB_M60_100rnd_762x51", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "rcn_amr": {
		[ player, "rhsusf_mag_10Rnd_STD_50BMG_M33", 6 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add secondary ammo
switch (_loadout) do {
	default {
		[ player, "rhs_mag_762x25_8", 3 ] call pxg_armory_fnc_addToVest;
	};
};

// add assistant ammo 
switch (_loadout) do {
	default {};
	case "sqd_aar": {
		[ player, "UK3CB_Bren_30Rnd_762x51_Magazine", 4 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UK3CB_Bren_30Rnd_762x51_Magazine_GT", 4 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mmg_l": {
		[ player, "UK3CB_M60_100rnd_762x51", 3 ] call pxg_armory_fnc_addToBackpack;
	};
	case "sup_mat_l": {
		[ player, "rhs_rpg7_OG7V_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add other ammo 
switch (_loadout) do {
	default {};
	case "sup_mat_g": {
		[ player, "rhs_rpg7_PG7VM_mag", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_rpg7_PG7VR_mag", 1 ] call pxg_armory_fnc_addToBackpack;
	};
};

// add grenades
switch (_loadout) do {
	default {
		[ player, "rhs_mag_f1", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "rhs_mag_rdg2_white", 2 ] call pxg_armory_fnc_addToVest;
	};
	case "sqd_sap": {};
};

// add 40mm grenades
switch (_loadout) do {
	default {};
	case "plt";
	case "sqd_ld";
	case "sqd_gre": {
		[ player, "1Rnd_HE_Grenade_shell", 10 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_Smoke_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeRed_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "1Rnd_SmokeGreen_Grenade_shell", 2 ] call pxg_armory_fnc_addToBackpack;
		[ player, "UGL_FlareWhite_F", 2 ] call pxg_armory_fnc_addToBackpack;
	};
};
