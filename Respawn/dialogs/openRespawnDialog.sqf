createDialog "dialog_respawn"; 
//Opens the vehicle spawn dialog and fills lists.

_currentWaves = missionNamespace getVariable ["PXG_Respawn_Waves", 0];


_wavesText = "Avialable waves: " + str _currentWaves;

ctrlSetText [471100, _wavesText];


