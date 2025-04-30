params["_vehicle","_vehicleType"];

switch(_vehicleType) do
{
	case "UK3CB_FIA_I_LR_Closed":
	{
		[
			_vehicle,
			["FIA_01",1], 
			["Canvas_Roof_Hide",0,"Radio_Hide",0,"Front_Grill_Hide",0,"Light_Covers_Hide",0,"Fuel_Cans_Hide",0,"Spare_Wheel_Hide",0,"Beacons_Hide",1,"ClanLogo_Hide",1]
		] call BIS_fnc_initVehicle;
	};

	case "UK3CB_FIA_I_LR_M2":
	{
		[
			_vehicle,
			["FIA_01",1], 
			["Radio_Hide",0,"Front_Grill_Hide",0,"Light_Covers_Hide",0,"Fuel_Cans_Hide",0,"Spare_Wheel_Hide",0,"Beacons_Hide",1,"ClanLogo_Hide",1]
]		 call BIS_fnc_initVehicle;
	};

	
	default {};
};

