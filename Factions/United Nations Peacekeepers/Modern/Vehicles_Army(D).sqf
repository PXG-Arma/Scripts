// Welcome to the Faction Vehicles file, This should be called "Vehicles_FactionName"
// In this file you assign which Vehicles appear in the Motorpool Menu.
// When assigning Vehicles you do so by "[VehicleClassName, CargoSpace],". The last vehicle in a group should not have a "," at the end. -1 Cargo equals no Cargo option.

_availableVehicles =

[

	['Utility', 
		[
			["UK3CB_UN_I_Landcruiser", 4], 
	        ["UK3CB_UN_I_M1151", 4],
	        ["UK3CB_BAF_LandRover_Amb_FFR_UN_A", 6], 
	        ["UK3CB_UN_I_Kamaz_Open", 12], 
	        ["UK3CB_UN_I_Kamaz_Fuel", 4],  
	        ["UK3CB_UN_B_Ural_Recovery", 4], 
	        ["UK3CB_UN_I_Ural_Ammo", 4], 
	        ["UK3CB_UN_I_Ural_Repair", 4]
		]
	],

	['Armed Car/MRAP', 
		[
			["UK3CB_UN_I_M1151_GPK_PKM", 4], 
	        ["UK3CB_UN_I_Hilux_Dshkm", 4],  
	        ["UK3CB_UN_I_Hilux_GMG", 4],  
	        ["UK3CB_UN_I_Hilux_Spg9", 4]
		]
	],

	['APC', 
		[
			["UK3CB_UN_I_BTR70", 4],  
	        ["UK3CB_UN_B_BTR90", 4], 
	        ["UK3CB_UN_I_M1117", 4], 
	        ["UK3CB_UN_I_M113_M2", 4],  
	        ["UK3CB_UN_I_M113_supply", 4]
		]
	],

	['IFV', 
		[
			["UK3CB_UN_I_BMP1", 4], 
            ["UK3CB_UN_I_BMP2K", 4]
		]
	],

	['MBT', 
		[
			["UK3CB_UN_I_T72BM", 4]
		]
	],

	['Anti-Air', 
		[
			["UK3CB_UN_I_Hilux_Zu23", 4], 
	        ["UK3CB_UN_B_ZsuTank", 4]
		]
	],

	['Artillery', 
		[
			['UK3CB_UN_I_D30', -1]
		]
	],

	['Rotary Transport', 
		[
			["UK3CB_UN_I_Bell412_Utility", 4], 
	        ["UK3CB_UN_I_Mi8AMT", 8]
		]
	],

	['Rotary Attack', 
		[
			["UK3CB_UN_I_Bell412_Armed", 4], 
	        ["UK3CB_UN_I_Mi_24V", 4]
		]
	],

	['Fixed Wing Transport', 
		[
			["UK3CB_UN_I_C130J", 24], 
	        ["UK3CB_UN_I_C130J_CARGO", 24]
		]
	],

	['Fixed Wing Attack', 
		[
			["UK3CB_UN_I_Cessna_T41_Armed", 4]
		]
	],

	['Boat', 
		[
			['UK3CB_BAF_RHIB_HMG', 8],
			['B_Boat_Transport_01_F', 4],
			['B_SDV_01_F', 4]
		]
	],

	['Misc.', 
		[
			["B_G_Quadbike_01_F", 2], 
	        ["UK3CB_O_G_YAVA", -1]
		]
	]
];

_availableVehicles