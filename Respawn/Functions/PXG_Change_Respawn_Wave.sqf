params["_waves"]; 

_currentWaves = missionNamespace getVariable ["PXG_Respawn_Waves",0];

_setWaves = _currentWaves + _waves; 

if (_setWaves < 0) then {
	_setWaves = 0; 	
};

missionNamespace setVariable ["PXG_Respawn_Waves", _setWaves, true];
