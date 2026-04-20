params ["_sourceMenu"];

// Set global flag to prevent camera destruction during transition
missionNamespace setVariable ["PXG_Cam_IsSwapping", true];

// Cleanup any existing preview vehicles to prevent conflicts between Motorpool and Resupply logic
private _previewVic = missionNamespace getVariable ["PXG_Motorpool_Preview_Vic", objNull];
if (!isNull _previewVic) then { deleteVehicle _previewVic; missionNamespace setVariable ["PXG_Motorpool_Preview_Vic", objNull]; };

if (_sourceMenu == "motorpool") then {
	private _master = player getVariable ["PXG_Vehicle_Master", objNull];
	
	// Sync current session state from Motorpool to Resupply memory (Pull directly from UI)
	private _sideSel = lbCurSel 461504;
	private _spawnSel = lbCurSel 461500;
	if (_sideSel != -1) then { player setVariable ["PXG_Resupply_Memory_Side", _sideSel]; };
	if (_spawnSel != -1) then { player setVariable ["PXG_Resupply_Memory_Spawn", _spawnSel]; };
	
	// Faction and Camo are already updated by their respective refresh scripts on selection
	player setVariable ["PXG_Resupply_Memory_Faction", player getVariable ["PXG_Motorpool_Memory_Faction", [-1,-1]]];
	player setVariable ["PXG_Resupply_Memory_Camo",    player getVariable ["PXG_Motorpool_Memory_Camo", -1]];
	
	closeDialog 2;
	[_master] execVM "Scripts\Resupply\dialogs\openSupplyDialog.sqf";
} else {
	private _master = player getVariable ["PXG_Resupply_Master", objNull];
	
	// Sync current session state from Resupply to Motorpool memory (Pull directly from UI)
	private _sideSel = lbCurSel 451504;
	private _spawnSel = lbCurSel 451500;
	if (_sideSel != -1) then { player setVariable ["PXG_Motorpool_Memory_Side", _sideSel]; };
	if (_spawnSel != -1) then { player setVariable ["PXG_Motorpool_Memory_Spawn", _spawnSel]; };

	player setVariable ["PXG_Motorpool_Memory_Faction", player getVariable ["PXG_Resupply_Memory_Faction", [-1,-1]]];
	player setVariable ["PXG_Motorpool_Memory_Camo",    player getVariable ["PXG_Resupply_Memory_Camo", -1]];

	closeDialog 2;
	[_master] execVM "Scripts\Motorpool\dialogs\openMotorpoolDialog.sqf";
};

// Reset swapping flag after transition period
[] spawn {
	sleep 1;
	missionNamespace setVariable ["PXG_Cam_IsSwapping", false];
};
