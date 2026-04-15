params ["_vehicleMaster", ["_isCalledFromFARP", false]];

// Set variables BEFORE creating dialog to ensure onLoad handlers have access to them
player setVariable ["PXG_Vehicle_Master", _vehicleMaster];
player setVariable ["PXG_IsCalledFromFARP", _isCalledFromFARP];

createDialog "dialog_motorpool"; 
//Opens the vehicle spawn dialog and fills lists.

sidesArray = ["BLUFOR", "OPFOR", "INDEP"];

{
	lbAdd [461504, _x];
}	forEach sidesArray;

{
	_spawnString = (vehicleVarName _x) splitString "_";
	_spawnString = _spawnString joinString " ";
	lbAdd [461500, _spawnString]; 
} forEach synchronizedObjects _vehicleMaster; //Fills list of available spawnpoints

_sideMemory = player getVariable ["PXG_Motorpool_Memory_Side", -1];
_spawnMemory = player getVariable ["PXG_Motorpool_Memory_Spawn", -1];

if (_sideMemory != -1) then {
	lbSetCurSel [461504, _sideMemory];
	// Explicitly call refresh to populate faction tree for first selection
    call compile preprocessfile 'Scripts\Motorpool\Functions\PXG_Refresh_Factions.sqf';
};

if (_spawnMemory != -1) then {
	lbSetCurSel [461500, _spawnMemory];
} else {
	lbSetCurSel [461500, 0]; // Default to first spawnpoint to initialize camera
};

// Force camera update after lists are initialized
if (fileExists "Scripts\Misc\PXG_Handle_Camera.sqf") then {
	[[], "update"] execVM "Scripts\Misc\PXG_Handle_Camera.sqf";
};
