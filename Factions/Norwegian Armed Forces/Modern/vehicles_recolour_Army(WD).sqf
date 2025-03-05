params["_vehicle","_vehicleType"];

switch(_vehicleType) do
{
	case "rhsusf_mrzr4_d":
	{
		[
			_vehicle,
			["mud_olive",1], 
	        ["tailgateHide",0,"tailgate_open",0,"cage_fold",0]
	] call BIS_fnc_initVehicle;
	};

	case "rhsusf_m113_usarmy_supply":
	{
		[
			_vehicle,
			["standard",1], 
	        ["IFF_Panels_Hide",0,"hatchGunner",0]
	] call BIS_fnc_initVehicle;
	};

	case "RHS_MELB_MH6M":
	{
		[_vehicle, 4] call ace_cargo_fnc_setSpace;
	};

	case "RHS_MELB_AH6M":
	{
		[_vehicle, 2] call ace_cargo_fnc_setSpace;
	};
	

	case "UK3CB_ION_B_Woodland_Bell412_FLIR";
	{
		[
			_vehicle,
			["Luxury",1], 
			["AddWinch",0,"AddCargohook",0,"AddCargoHook_cover",1,"DoorL2_Hide",0,"DoorR2_Hide",0,"RotorCover_Hide",0]		
			] call BIS_fnc_initVehicle;
	};
	default {};
};
