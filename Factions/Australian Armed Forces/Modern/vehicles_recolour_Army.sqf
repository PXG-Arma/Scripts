params["_vehicle","_vehicleType"];

switch(_vehicleType) do
{
	case "UK3CB_B_LAV25_US_DES":
	{
		[
			_vehicle,
				["AUS",1], 
				["Duke_Hide",1,"Basket_Hide",0,"Sparewheel_3_Hide",0,"ClanLogo_Hide",1,"ClanSign_Hide",1,"Backpacks_Front_Left_Hide",0,"Backpacks_Front_Right_Hide",0,"Backpacks_Rear_Left_Hide",0,"Backpacks_Rear_Right_Hide",0,"Camonet_Roll_Hide",1,"Jerrycan_Left_Hide",0,"Jerrycan_Right_Hide",0,"Sparewheel_1_Hide",0,"Sparewheel_2_Hide",0,"Shovels_Hide",0,"Tools_Hide",0,"Tow_Rope_Hide",0]
			] call BIS_fnc_initVehicle;
	};
	case "rhsusf_m1a1aimd_usarmy":
	{
		[
			_vehicle,
				["desert",1], 
				["IFF_Panels_Hide",1,"Miles_Hide",1,"showCamonetTurret",0,"showCamonetHull",0]] call BIS_fnc_initVehicle;
	};
	default {};
};

