/*
Sets respawn time for player. 
This function has to be executed locally on every player's machine.  

Arguments:
 	None

Return Value:
	None

Example:
	call pxg_respawn_fnc_
*/

private _respawnMode = missionNamespace getVariable ["PXG_Respawn_Mode",0];

sleep 5; 

switch (str player) do {
	case "C_civ1_civ1";
	case "C_civ1_civ2": {
		player addAction ["Respawn Menu", {call pxg_respawn_fnc_openDialog;}]
	};
	default { 
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
	};
};

