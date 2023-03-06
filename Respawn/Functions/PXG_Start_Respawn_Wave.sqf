_avialableWaves = missionNamespace getVariable ["PXG_Respawn_Waves",0];

if (_avialableWaves > 0) then {
	['scripts\Respawn\Functions\PXG_Finish_Respawn_Wave.sqf'] remoteExec["execVM",0,false];
	[-1] execVM "scripts\Respawn\Functions\PXG_Change_Respawn_Wave.sqf";
} else { 
	hint "Good Luck Chuck";
};
