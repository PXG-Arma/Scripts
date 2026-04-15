params ["_sourceMenu"];

// Set global flag to prevent camera destruction during transition
missionNamespace setVariable ["PXG_Cam_IsSwapping", true];

if (_sourceMenu == "motorpool") then {
	private _master = player getVariable ["PXG_Vehicle_Master", objNull];
	
	// Sync current session state from Motorpool to Resupply memory
	private _sel = lbCurSel 461500;
	if (_sel != -1) then { player setVariable ["PXG_Resupply_Memory_Spawn", _sel]; };
	
	player setVariable ["PXG_Resupply_Memory_Side",    player getVariable ["PXG_Motorpool_Memory_Side", -1]];
	player setVariable ["PXG_Resupply_Memory_Faction", player getVariable ["PXG_Motorpool_Memory_Faction", []]];
	player setVariable ["PXG_Resupply_Memory_Camo",    player getVariable ["PXG_Motorpool_Memory_Camo", -1]];
	
	closeDialog 2;
	[_master] execVM "Scripts\Resupply\dialogs\openSupplyDialog.sqf";
} else {
	private _master = player getVariable ["PXG_Resupply_Master", objNull];
	
	// Sync current session state from Resupply to Motorpool memory
	private _sel = lbCurSel 451500;
	if (_sel != -1) then { player setVariable ["PXG_Motorpool_Memory_Spawn", _sel]; };

	player setVariable ["PXG_Motorpool_Memory_Side",    player getVariable ["PXG_Resupply_Memory_Side", -1]];
	player setVariable ["PXG_Motorpool_Memory_Faction", player getVariable ["PXG_Resupply_Memory_Faction", []]];
	player setVariable ["PXG_Motorpool_Memory_Camo",    player getVariable ["PXG_Resupply_Memory_Camo", -1]];

	closeDialog 2;
	[_master] execVM "Scripts\Motorpool\dialogs\openMotorpoolDialog.sqf";
};

// Reset swapping flag after transition period
[] spawn {
	sleep 1;
	missionNamespace setVariable ["PXG_Cam_IsSwapping", false];
};
