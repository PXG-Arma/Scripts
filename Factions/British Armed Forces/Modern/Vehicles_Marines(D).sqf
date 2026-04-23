// Welcome to the Faction Vehicles file, This should be called "Vehicles_FactionName"
// In this file you assign which Vehicles appear in the Motorpool Menu.
// When assigning Vehicles you do so by "[VehicleClassName, CargoSpace],". The last vehicle in a group should not have a "," at the end. -1 Cargo equals no Cargo option.

_availableVehicles =

[

	['Utility', 
		[
			['UK3CB_BAF_MAN_HX60_Repair_Sand_DDPM_RM', 4], 
			['UK3CB_BAF_MAN_HX60_Cargo_Sand_A_DDPM_RM', 4], 
			['UK3CB_BAF_MAN_HX60_Transport_Sand_DDPM_RM', 12],
			['UK3CB_BAF_LandRover_Soft_FFR_Sand_A_DDPM_RM', 4], 
			['UK3CB_BAF_LandRover_Amb_FFR_Sand_A_DDPM_RM', 8]
		]
	],

	['Armed Car/MRAP', 
		[
			['UK3CB_BAF_LandRover_WMIK_HMG_FFR_Sand_A_DDPM_RM', 4], 
			['UK3CB_BAF_LandRover_WMIK_Milan_FFR_Sand_A_DDPM_RM', 4], 
			['UK3CB_BAF_Jackal2_L2A1_D_DDPM_RM', 4], 
			['UK3CB_BAF_Coyote_Passenger_L111A1_D_DDPM_RM', 4], 
			['UK3CB_BAF_Coyote_Logistics_L111A1_D_DDPM_RM', 4]
		]
	],

	['APC', 
		[
			['UK3CB_BAF_FV432_Mk3_GPMG_Sand_DDPM_RM', 6]
		]
	],

	['Artillery', 
		[
			['RHS_M119_D', -1]
		]
	],

	['Rotary Transport', 
		[
			['UK3CB_BAF_Wildcat_HMA2_TRN_8A_DDPM_RM', 6], 
			['UK3CB_BAF_Merlin_HC4_32_DDPM', 8]
		]
	],

	['Rotary Attack', 
		[
			['UK3CB_BAF_Wildcat_AH1_8_Generic_DDPM_RM', 0]
		]
	],

	['Fixed Wing Transport', 
		[
			['UK3CB_BAF_Hercules_C3_DDPM', 24], 
			['UK3CB_BAF_Hercules_C3_cargo_DDPM', 24]
		]
	],

	['Fixed Wing Attack', 
		[
			['UK3CB_BAF_MQ9_Reaper_DDPM_RM', -1]
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
			['UK3CB_BAF_LandRover_Panama_Sand_A_DDPM_RM', 4],
	        ["UK3CB_BAF_MAN_HX60_Container_Sand", 20]
		]
	]
];

_availableVehicles