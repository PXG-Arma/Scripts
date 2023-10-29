params ["_vehicleMaster", "_flagpole" ,["_isCalledFromFARP", false]];
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

player setVariable ["PXG_Vehicle_Master", _vehicleMaster];
player setVariable ["PXG_IsCalledFromFARP", _isCalledFromFARP];

if (_sideMemory != -1) then {lbSetCurSel [461504, _sideMemory];};
if (_spawnMemory != -1) then {lbSetCurSel [461500, _spawnMemory];};

private _flag = _flagpole select 0;

PXG_Motorpool_cam = "camera" camCreate (_flag modelToWorld [0, 25, 25]);
PXG_Motorpool_cam camSetTarget _flag; 
PXG_Motorpool_cam cameraEffect ["Internal", "back"];
PXG_Motorpool_cam camCommit 1; 

