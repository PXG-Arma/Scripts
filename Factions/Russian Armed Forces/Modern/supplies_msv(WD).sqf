// Welcome to the Faction Supplies file, This should be called "Supplies_FactionName"
//
// This file has two sections:
//
// SECTION 1 - _suppliesConfig
//   Define each supply package: its name and what items go in the crate.
//   Format: ["Supply Name", [ ["classname", quantity], ... ]]
//
// SECTION 2 - _supplyCategories
//   Sort those supply names into UI categories for the resupply tree.
//   Format: ["Category Name", ["Supply Name 1", "Supply Name 2", ...]]
//   A supply name can appear under multiple categories without duplicating its contents.
//
// FOBs, FARPs, Wheels, Tracks and Slingload Crates are added automatically by the engine.

// ===========================================================================================
// SECTION 1: Supply Definitions
// ===========================================================================================

_suppliesConfig = [
	["Primary Resupply",
		[
			["rhs_30Rnd_545x39_7N10_plum_AK",40],
			["rhs_30Rnd_545x39_AK_plum_green",40],
			["uk3cb_saiga_10rnd_12g_buckshot_magazine",40],
			["uk3cb_saiga_10rnd_12g_slug_magazine",40],
			["rhs_mag_9x19_17",40]
		]
	],
	["AR Resupply",
		[
			["rhs_60Rnd_545X39_7N10_AK",20],
			["rhs_60Rnd_545X39_AK_Green",20]
		]
	],
	["Marksman Resupply",
		[
			["UK3CB_SVD_10rnd_762x54",30],
			["UK3CB_SVD_10rnd_762x54_GT",30],
			["rhs_5Rnd_338lapua_t5000",40]
		]
	],
	["MMG Resupply",
		[
			["rhs_100Rnd_762x54mmR_green",20],
			["rhs_100Rnd_762x54mmR_7N13",20]
		]
	],
	["HMG Resupply",
		[
			["ace_csw_50Rnd_127x108_mag",20]
		]
	],
	["GMG Resupply",
		[
			["ace_compat_rhs_afrf3_mag_VOG30_30",20]
		]
	],
	["LAT Resupply",
		[
			["rhs_weap_rpg26",8]
		]
	],
	["MAT Resupply",
		[
			["rhs_rpg7_PG7V_mag",8],
			["rhs_rpg7_OG7V_mag",8],
			["rhs_rpg7_PG7VL_mag",8],
			["rhs_rpg7_PG7VR_mag",4],
			["rhs_rpg7_TBG7V_mag",4]
		]
	],
	["HAT Resupply",
		[
			["ace_compat_rhs_afrf3_mag_9m1331",10],
			["ace_compat_rhs_afrf3_mag_9m133f",10]
		]
	],
	["AA Resupply",
		[
			["rhs_mag_9k38_rocket",8]
		]
	],
	["Mortar Resupply",
		[
			["ACE_1Rnd_82mm_Mo_HE",20],
			["ACE_1Rnd_82mm_Mo_Illum",20],
			["ACE_1Rnd_82mm_Mo_Smoke",20]
		]
	],
	["Grenades",
		[
			["SmokeShell",20],
			["SmokeShellRed",10],
			["SmokeShellYellow",10],
			["SmokeShellBlue",10],
			["rhs_mag_rgd5",20]
		]
	],
	["40mm Grenades",
		[
			["rhs_VOG25",30],
			["rhs_GRD40_White",20],
			["rhs_GRD40_Red",10]
		]
	],
	["Flares",
		[
			["rhs_VG40OP_white",30]
		]
	],		
	["Explosives",
		[
			["ACE_Clacker",2],
			["ACE_M26_Clacker",2],
			["DemoCharge_Remote_Mag",10],
			["SatchelCharge_Remote_Mag",10],
			["ATMine_Range_Mag",15],
			["SLAMDirectionalMine_Wire_Mag",15]
		]
	],
	["Basic Medical Supplies",
		[
			["ACE_elasticBandage", 40],
			["ACE_packingBandage", 40],
			["ACE_quikclot", 40],
			["kat_Painkiller", 20],
			["ACE_tourniquet", 20],
			["ACE_splint", 20]
		]
	],
	["Advanced Medical Supplies",
		[
			["kat_TXA", 8],
			["kat_EACA", 8],
			["kat_IV_16", 40],
			["ACE_epinephrine", 20],
			["ACE_morphine", 20],
			["kat_larynx", 20],
			["kat_IO_FAST", 20],
			["kat_Carbonate", 10],
			["kat_bloodIV_O_N", 20],
			["kat_bloodIV_O_N_500", 20],
			["kat_bloodIV_O_N_250", 20]
		]
	],
	["Misc. Medical Supplies",
		[
			["ACE_bodyBag", 20],
			["ACE_surgicalKit", 2],
			["kat_accuvac", 2],
			["kat_X_AED", 2],
			["kat_Pulseoximeter", 2]
		]
	],
	["CBRN Defense Supplies",
		[
			["kat_atropine", 40],
			["kat_mask_M04", 20],
			["kat_gasmaskFilter", 20]
		]
	],
	["Squad Resupply",
		[
			["rhs_30Rnd_545x39_7N10_plum_AK", 24],
			["rhs_60Rnd_545X39_7N10_AK", 10],
			["rhs_weap_rpg26", 2],
			["rhs_VOG25", 12],
			["rhs_mag_rgd5", 6],
			["SmokeShell", 6],
			["ACE_elasticBandage", 12],
			["ACE_packingBandage", 12],
			["ACE_quikclot", 12],
			["kat_bloodIV_O_N_500", 6]
		]
	],
	["Recon Drones",
	[
			["Rev_darter", 2]
		]
	],
	["EOD Drones",
	[
			["Rev_Pelter", 2]
		]
	],
	["Parachutes",
		[
			["B_Parachute", 20],
			["ACE_Altimeter", 20]
		]
	]
];

// ===========================================================================================
// SECTION 2: Supply Categories
// ===========================================================================================

_supplyCategories = [
	["Ammo",              ["Primary Resupply", "AR Resupply", "Marksman Resupply", "MMG Resupply", "HMG Resupply"]],
	["Anti-Tank",         ["LAT Resupply", "MAT Resupply", "HAT Resupply"]],
	["Anti-Air",          ["AA Resupply"]],
	["Fire Support",      ["Mortar Resupply"]],
	["Grenades & 40mm",   ["Grenades", "40mm Grenades", "GMG Resupply", "Flares"]],
	["Medical",           ["Basic Medical Supplies", "Advanced Medical Supplies", "Misc. Medical Supplies"]],
	["Explosives",        ["Explosives"]],
	["Support & Utility", ["Recon Drones", "EOD Drones", "Parachutes", "CBRN Defense Supplies", "Squad Resupply"]]
];

[_suppliesConfig, _supplyCategories]