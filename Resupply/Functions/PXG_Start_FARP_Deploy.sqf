params ["_crate"];

_isNearFOB = [30, "PXG_isFOB", _crate] call compile preprocessfile "Scripts\misc\PXG_Check_Radius_Variable.sqf";

if(_isNearFOB) then {
	[10, _crate, {call compile preprocessfile "Scripts\Resupply\Functions\PXG_Spawn_FARP.sqf"},{hint "Construction Cancelled."}, "Building rearm and refuel station"] call ace_common_fnc_progressBar; 
} else {hint "Needs to be built closer to FOB"};