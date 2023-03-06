_respawnMode = RespawnMaster getVariable ["PXG_Respawn_Mode",0];

sleep 5;

switch (_respawnMode) do {
	case 1: {
		setPlayerRespawnTime 7200;
		};
	case 2: {
		setPlayerRespawnTime 7200;
		};
	case 3: {
		setPlayerRespawnTime 30;
		};
	default {
		hint "Respawn Mode is not set correctly";
		};
};