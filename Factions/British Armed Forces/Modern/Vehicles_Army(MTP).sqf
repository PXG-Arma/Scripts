// Welcome to the Faction Vehicles file, This should be called "Vehicles_FactionName"
// In this file you assign which Vehicles appear in the Motorpool Menu.
// When assigning Vehicles you do so by "[VehicleClassName, CargoSpace],". The last vehicle in a group should not have a "," at the end. -1 Cargo equals no Cargo option.

_availableVehicles =

[

	['Utility Desert', 
		[
			['UK3CB_BAF_MAN_HX58_Repair_Sand_MTP', 4], 
			['UK3CB_BAF_MAN_HX58_Cargo_Sand_A_MTP', 4], 
			['UK3CB_BAF_MAN_HX58_Transport_Sand_MTP', 12],
			['UK3CB_BAF_LandRover_Soft_FFR_Sand_A_MTP', 4], 
			['UK3CB_BAF_LandRover_Amb_FFR_Sand_A_MTP', 8]
		]
	],

	['Utility Woodland', 
		[
			['UK3CB_BAF_MAN_HX58_Repair_Green_MTP', 4], 
			['UK3CB_BAF_MAN_HX58_Cargo_Green_A_MTP', 4], 
			['UK3CB_BAF_MAN_HX58_Transport_Green_MTP', 12],
			['UK3CB_BAF_LandRover_Soft_FFR_Green_A_MTP', 4], 
			['UK3CB_BAF_LandRover_Amb_FFR_Green_A_MTP', 8]
		]
	],

	['Armed Car/MRAP Desert', 
		[
			['UK3CB_BAF_LandRover_WMIK_HMG_FFR_Sand_A_MTP', 4], 
			['UK3CB_BAF_LandRover_WMIK_Milan_FFR_Sand_A_MTP', 4], 
			['UK3CB_BAF_Panther_GPMG_Sand_A_MTP', 4], 
			['UK3CB_BAF_Husky_Passenger_HMG_Sand_MTP', 4], 
			['UK3CB_BAF_Husky_Logistics_HMG_Sand_MTP', 4]
		]
	],

	['Armed Car/MRAP Woodland', 
		[
			['UK3CB_BAF_LandRover_WMIK_HMG_FFR_Green_A_MTP', 4], 
			['UK3CB_BAF_LandRover_WMIK_Milan_FFR_Green_A_MTP', 4], 
			['UK3CB_BAF_Panther_GPMG_Green_A_MTP', 4], 
			['UK3CB_BAF_Husky_Passenger_HMG_Green_MTP', 4], 
			['UK3CB_BAF_Husky_Logistics_HMG_Green_MTP', 4]
		]
	],

	['APC Desert', 
		[
			['UK3CB_BAF_FV432_Mk3_RWS_Sand_MTP', 6]
		]
	],

	['APC Woodland', 
		[
			['UK3CB_BAF_FV432_Mk3_RWS_Green_MTP', 6]
		]
	],

	['IFV Desert', 
		[
			['UK3CB_BAF_Warrior_A3_D_Cage_Camo_MTP', 4]
		]
	],

	['IFV Woodland', 
		[
			['UK3CB_BAF_Warrior_A3_W_Cage_Camo_MTP', 4]
		]
	],

	['Artillery', 
		[
			['RHS_M119_D', -1]
		]
	],

	['Rotary Transport', 
		[
			['UK3CB_BAF_Merlin_HC3_18_GPMG_MTP', 6], 
			['UK3CB_BAF_Chinook_HC2_MTP', 8], 
			['UK3CB_BAF_Chinook_HC2_cargo_MTP', 8]
		]
	],

	['Rotary Attack', 
		[
			['UK3CB_BAF_Apache_AH1_Generic_MTP', 0]
		]
	],

	['Fixed Wing Transport', 
		[
			['UK3CB_BAF_Hercules_C4_MTP', 24], 
			['UK3CB_BAF_Hercules_C4_cargo_MTP', 24]
		]
	],

	['Fixed Wing Attack', 
		[
			['UK3CB_BAF_MQ9_Reaper_MTP', -1]
		]
	],

	['Boat', 
		[
			['UK3CB_BAF_RHIB_HMG_MTP', 8],
			['B_Boat_Transport_01_F', 4],
			['B_SDV_01_F', 4]
		]
	],

	['Misc.', 
		[
			['UK3CB_KRG_B_Quadbike', 4],
			['UK3CB_BAF_LandRover_Panama_Sand_A_MTP', 4],
			['UK3CB_BAF_LandRover_Panama_Green_A_MTP', 4],
	        ["UK3CB_BAF_MAN_HX58_Container_Sand", 30],
	        ["UK3CB_BAF_MAN_HX58_Container_Green", 30]
		]
	]
];

_availableVehicles