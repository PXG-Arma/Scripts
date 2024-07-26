/*params["_resupplyMaster", ["_isCalledFromFob", false], "_spawn"];





_spawn addAction ["<t color='#fcec03'>Spawn Resupply</t>",{[fobLogicMaster, true] execVM "Scripts\Resupply\dialogs\openSupplyDialog.sqf"}];



//_spawn addAction ["<t color='#fcec03'>Spawn Resupply</t>",{[fobLogicMaster, true] execVM "Scripts\Resupply\dialogs\openSupplyDialog.sqf"}];  
*/

//call compile preprocessFileLineNumbers "Scripts\Resupply\Functions\PXG_Spawn_FOB.sqf";
_resupplyMaster = _this select 3;

createDialog "dialog_supply_spawn"; 
//Opens the supply spawn dialog and fills lists.
sidesArray = ["BLUFOR", "OPFOR", "INDEP"];

_resupplyMaster = fobLogicMaster;
_isCalledFromFob = true;
{
	lbAdd [451504, _x];
}	forEach sidesArray;

{
	_spawnString = (vehicleVarName _x) splitString "_";
	_spawnString = _spawnString joinString " ";
	lbAdd [451500, _spawnString]; 
} forEach synchronizedObjects _resupplyMaster; //Fills list of available spawnpoints

_sideMemory = player getVariable ["PXG_Resupply_Memory_Side", -1];
_spawnMemory = player getVariable ["PXG_Resupply_Memory_Spawn", -1];

player setVariable ["PXG_Resupply_Master", _resupplyMaster];
player setVariable ["PXG_IsCalledFromFOB", _isCalledFromFob];

if (_sideMemory != -1) then {lbSetCurSel [451504, _sideMemory];};
if (_spawnMemory != -1) then {lbSetCurSel [451500, _spawnMemory];};

