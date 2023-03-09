private _respawnMode = missionNamespace getVariable ["PXG_Respawn_Mode",0];

if (_respawnMode == 2) then {
	
	if ((str player != "C_civ1_civ1") or (str player != "C_civ1_civ2")) then {
		private _respawnWaveTimer = missionNamespace getVariable ["PXG_Respawn_Time",60];

		private _playerRespawnTimer = _respawnWaveTimer - serverTime mod _respawnWaveTimer;
				
		setPlayerRespawnTime _playerRespawnTimer;
	};


};
