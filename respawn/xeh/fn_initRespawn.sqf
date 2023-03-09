if (isServer) then {
	private _startwaves = RespawnMaster getVariable ["PXG_Respawn_Waves",0];
	missionNamespace setVariable ["PXG_Respawn_Waves", _startwaves,true];
	private _respawnMode = RespawnMaster getVariable ["PXG_Respawn_Mode",0];
	missionNamespace setVariable ["PXG_Respawn_Mode", _respawnMode,true];
	missionNamespace setVariable ["PXG_Respawn_Time", 30,true];

};

if (hasInterface) then {
	0 spawn pxg_respawn_fnc_setRespawnTime; 
	player addEventHandler ["Respawn", {  0 spawn pxg_respawn_fnc_setRespawnTime; } ];
	player addEventHandler ["Killed",{ 0 spawn pxg_respawn_fnc_setRespawnTime2; } ]
};
