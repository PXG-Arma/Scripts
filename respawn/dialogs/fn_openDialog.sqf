createDialog "dialog_respawn"; 
//Opens the vehicle spawn dialog and fills lists.

private _currentWaves = missionNamespace getVariable ["PXG_Respawn_Waves", 0];


private _wavesText = "Avialable waves: " + str _currentWaves;

ctrlSetText [471100, _wavesText];

private _allPlayers = call BIS_fnc_listPlayers;

{
	if (!alive _x) then {
		lbAdd [471604, name _x];
		lbSetValue [471604,_forEachIndex, owner _x]; 
	};
} forEach _allPlayers;

