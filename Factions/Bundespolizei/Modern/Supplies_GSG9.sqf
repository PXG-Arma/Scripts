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
			["rhs_mag_30Rnd_556x45_M193_Stanag",30],
			["UK3CB_MP5_30Rnd_9x19_Magazine",30],
			["BWA3_30Rnd_556x45_G36",30],
			["BWA3_40Rnd_46x30_MP7",30],
			["rhsusf_mag_17Rnd_9x19_FMJ",30]
		]
	],
	["DMR Resupply",
		[
			["BWA3_20Rnd_762x51_G28_AP",30],
			["BWA3_20Rnd_762x51_G28_Tracer",10]
		]
	],
	["Sniper Resupply",
		[
			["BWA3_10Rnd_86x70_G29",20],
			["BWA3_10Rnd_86x70_G29_Tracer",20],
			["BWA3_10Rnd_127x99_G82_AP",20],
			["BWA3_10Rnd_127x99_G82_AP_Tracer",20],
			["BWA3_10Rnd_127x99_G82_Raufoss",20],
			["BWA3_10Rnd_127x99_G82_Raufoss_Tracer",20]
		]
	],
	["AMR Extra Resupply",
		[
			["BWA3_10Rnd_127x99_G82",20],
			["BWA3_10Rnd_127x99_G82_AP",20],
			["BWA3_10Rnd_127x99_G82_AP_Tracer",20],
			["BWA3_10Rnd_127x99_G82_Tracer",20],
			["BWA3_10Rnd_127x99_G82_Tracer_Dim",20],
			["BWA3_10Rnd_127x99_G82_Raufoss_Tracer",20],
			["BWA3_10Rnd_127x99_G82_Raufoss",20]
		]
	],
	["Smoke Grenades",
		[
			["BWA3_DM25",10],
			["BWA3_DM32_Red",10],
			["BWA3_DM32_Green",10],
			["BWA3_DM32_Blue",10],
			["BWA3_DM32_Purple",10],
			["BWA3_DM32_Orange",10],
			["BWA3_DM32_Yellow",10]
		]
	],	
	["Chemlights",
		[
			["ACE_Chemlight_HiGreen",30],
			["ACE_Chemlight_HiRed",30],
			["ACE_Chemlight_HiWhite",30],
			["ACE_Chemlight_IR",30],
			["ACE_Chemlight_White",30]
		]
	],	
	["Explosives",
		[
			["ACE_Clacker",2],
			["ACE_M26_Clacker",2],
			["DemoCharge_Remote_Mag",10],
			["SatchelCharge_Remote_Mag",10]
		]
	],
	["Blood IVs",
		[
			["ACE_bloodIV", 25],
			["ACE_bloodIV_500", 25],
			["ACE_bloodIV_250", 25]
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
	["Squad Resupply",
		[
			["BWA3_30Rnd_556x45_G36",20],
			["BWA3_30Rnd_556x45_G36_Tracer",20],
			["BWA3_200Rnd_556x45",5],
			["BWA3_200Rnd_556x45_Tracer",5],
			["BWA3_DM51A1",10],
			["BWA3_DM25",10],
			["1Rnd_Smoke_Grenade_Shell",10],
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
			["B_Parachute", 20]
		]
	]
];

// ===========================================================================================
// SECTION 2: Supply Categories
// ===========================================================================================

_supplyCategories = [
	["Ammo",              ["Primary Resupply", "DMR Resupply", "Sniper Resupply", "AMR Extra Resupply"]],
	["Smokes",  			["Smoke Grenades", "Chemlights"]],
	["Medical",           ["Basic Medical Supplies", "Advanced Medical Supplies", "Misc. Medical Supplies"]],
	["Explosives",        ["Explosives"]],
	["Support & Utility", ["Recon Drones", "EOD Drones", "Parachutes", "EOD Drones", "Squad Resupply"]]
];

[_suppliesConfig, _supplyCategories]