// Welcome to the Faction Vehicles recolour file, This should be called "Vehicles_recolour_FactionName"
// In this file you assign which Vehicle skin appears when spawning through the Motorpool Menu.
// The "switch(_vehicleType) do" can be left empty if randomisation is, or customization is not wanted.
// To get these parameters, Ctrl+C when in the garage with the wanted customization and paste at the bottom, note that this does not give the exact script and needs some manual labour to work
// by copying the camo and customization out of what you just pasted, and then pasting it in a copy of the already existing cases. Don't forget to rename the case either!

params["_vehicle","_vehicleType"];

switch(_vehicleType) do
{
	case "C_Van_01_box_F":
	{
		[
			_vehicle,
			["Black",1]
		] call BIS_fnc_initVehicle;
	};

	case "C_Van_02_vehicle_F":
	{
		[
			_vehicle,
			["Black",1], 
			["Door_1_source",0,"Door_2_source",0,"Door_3_source",0,"Door_4_source",0,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",0,"ladder_hide",0,"spare_tyre_holder_hide",0,"spare_tyre_hide",0,"reflective_tape_hide",0,"roof_rack_hide",0,"LED_lights_hide",0,"sidesteps_hide",0,"rearsteps_hide",0,"side_protective_frame_hide",1,"front_protective_frame_hide",0,"beacon_front_hide",0,"beacon_rear_hide",0]
		] call BIS_fnc_initVehicle;
	};

	case "UK3CB_ADC_C_SUV_Armoured":
	{
		[
			_vehicle,
			["Black",1], 
			["Flag_Hide",1]
		] call BIS_fnc_initVehicle;
	};

	case "C_SUV_01_F":
	{
		[
			_vehicle,
			["Black",1]
		] call BIS_fnc_initVehicle;
	};

	case "B_GEN_Offroad_01_gen_F":
	{
		[
			_vehicle,
			["LOP_Black",1], 
			["HideDoor1",0,"HideDoor2",0,"HideDoor3",0,"HideBackpacks",1,"HideBumper1",1,"HideBumper2",1,"HideConstruction",1,"hidePolice",0,"HideServices",1,"BeaconsStart",0,"BeaconsServicesStart",0]
		] call BIS_fnc_initVehicle;
	};

	case "UK3CB_APD_B_Bell412_FLIR":
	{
		[
			_vehicle,
			["Blue",1], 
			["AddWinch",0,"AddCargohook",0,"AddCargoHook_cover",1,"DoorL2_Hide",0,"DoorR2_Hide",0,"RotorCover_Hide",0]
		] call BIS_fnc_initVehicle;
	};
	default {};
};