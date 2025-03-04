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

	case "UK3CB_B_Bell412_Utility_CDF":
	{
		[
		_vehicle,
	["BLK",1], 
	["AddWinch",0,"AddCargohook",0,"AddCargoHook_cover",1,"AddFlareLauncher",0,"AddNoseradar",1,"DoorL2_Hide",0,"DoorR2_Hide",0,"RotorCover_Hide",0]
	] call BIS_fnc_initVehicle;
	};


	default {};
};

