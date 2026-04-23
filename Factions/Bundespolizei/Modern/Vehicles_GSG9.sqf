// Welcome to the Faction Vehicles file, This should be called "Vehicles_FactionName"
// In this file you assign which Vehicles appear in the Motorpool Menu.
// When assigning Vehicles you do so by "[VehicleClassName, CargoSpace],". The last vehicle in a group should not have a "," at the end. -1 Cargo equals no Cargo option.

_availableVehicles =

[

	["Cargo Utility", 
		[
			["C_Van_01_box_F", 13], 
			["C_Van_02_vehicle_F", 13]
		]
	],

	["Troop Utility", 
		[
			["C_Van_02_vehicle_F", 5], 
			["UK3CB_ADC_C_SUV_Armoured", 3], 
			["C_SUV_01_F", 3],
			["B_GEN_Offroad_01_gen_F", 3]
		]
	],

	['Rotary Transport', 
		[
			["UK3CB_APD_B_Bell412_FLIR", 12]
		]
	],

	['Boats',
		[
			["B_Boat_Transport_01_F", 2], 
			["UK3CB_TKA_B_RHIB", 6],
			["rhsgref_hidf_rhib", 6],
			["rhsgref_hidf_canoe", 1]
		]
	]
];

_availableVehicles