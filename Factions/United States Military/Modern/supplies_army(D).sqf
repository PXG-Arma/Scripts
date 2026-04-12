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
			["rhs_mag_30Rnd_556x45_M855_Stanag",40],
			["rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red",40],
			["rhsusf_8Rnd_00Buck",40],
			["rhsusf_8Rnd_Slug",40],
			["rhsusf_mag_15Rnd_9x19_FMJ",40]
		]
	],
	["AR Resupply",
		[
			["rhsusf_200rnd_556x45_mixed_box",20]
		]
	],
	["Marksman Resupply",
		[
			["rhsusf_20Rnd_762x51_m62_Mag",20],
			["rhsusf_20Rnd_762x51_m993_Mag",20],
			["rhsusf_10Rnd_762x51_m62_Mag",20],
			["rhsusf_20Rnd_762x51_m993_Mag",20],
			["ACE_10Rnd_127x99_AMAX_Mag",20],
			["ACE_10Rnd_127x99_API_Mag",20]
		]
	],
	["MMG Resupply",
		[
			["rhsusf_100Rnd_762x51_m61_ap",20],
			["rhsusf_100Rnd_762x51_m62_tracer",20]
		]
	],
	["HMG Resupply",
		[
			["ace_csw_100Rnd_127x99_mag_red",20]
		]
	],
	["GMG Resupply",
		[
			["ace_compat_rhs_usf3_48Rnd_40mm_MK19",20],
			["ace_compat_rhs_usf3_48Rnd_40mm_MK19_M430A1",20]
		]
	],
	["LAT Resupply",
		[
			["rhs_weap_M136",8]
		]
	],
	["MAT Resupply",
		[
			["rhs_mag_maaws_HEAT",8],
			["rhs_mag_maaws_HEDP",8]
		]
	],
	["HAT Resupply",
		[
			["rhs_fgm148_magazine_AT",8]
		]
	],
	["AA Resupply",
		[
			["rhs_fim92_mag",8]
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
			["HandGrenade",20]
		]
	],
	["40mm Grenades",
		[
			["1Rnd_HE_Grenade_Shell",30],
			["1Rnd_Smoke_Grenade_Shell",20],
			["1Rnd_SmokeRed_Grenade_Shell",10],
			["1Rnd_SmokeYellow_Grenade_Shell",10],
			["1Rnd_SmokeBlue_Grenade_Shell",10]
		]
	],
	["40mm Heavy",
		[
			["rhsusf_mag_6Rnd_M441_HE",10],
			["rhsusf_mag_6Rnd_M714_white",4],
			["rhsusf_mag_6Rnd_M713_red",4]
		]
	],
	["Flares",
		[
			["UGL_FlareWhite_F",30],
			["UGL_FlareCIR_F",20]
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
			["rhs_mag_30Rnd_556x45_M855_Stanag", 24],
			["rhsusf_200rnd_556x45_mixed_box", 6],
			["rhs_weap_M136", 2],
			["1Rnd_HE_Grenade_Shell", 12],
			["rhsusf_mag_6Rnd_M441_HE", 2],
			["HandGrenade", 6],
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
	["Grenades & 40mm",   ["Grenades", "40mm Grenades", "40mm Heavy", "GMG Resupply", "Flares"]],
	["Medical",           ["Basic Medical Supplies", "Advanced Medical Supplies", "Misc. Medical Supplies"]],
	["Explosives",        ["Explosives"]],
	["Support & Utility", ["Recon Drones", "EOD Drones", "Parachutes", "CBRN Defense Supplies", "Squad Resupply"]]
];

[_suppliesConfig, _supplyCategories]