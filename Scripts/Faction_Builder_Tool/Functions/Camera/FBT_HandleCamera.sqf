params ["_params", "_mode"];

/*
	FBT_HandleCamera.sqf
	-------------------------------
	Generic Camera Handler FOR FACTION BUILDER (FBT)
	Handles initialization, mouse interaction, real-time rendering, and status toggles.
*/

switch (_mode) do {
	case "init": {
		diag_log "[FBT Camera] Initializing...";
		_params params ["_display", "_targetSource", ["_targetMode", "NORMAL"]];
		
		if (isNull _display) exitWith { diag_log "[FBT Camera] Init Failed: Display is null"; };
		if (isNull _targetSource) exitWith { diag_log "[FBT Camera] Init Aborted: Target Source is null."; };

		// Store session config
		uiNamespace setVariable ["FBT_Cam_Active_Display", _display];
		missionNamespace setVariable ["FBT_Cam_TargetObj", _targetSource];

		// Camera state scalars - Persistence check
		if (isNil "FBT_Cam_Dist") then { FBT_Cam_Dist = 12; };
		if (isNil "FBT_Cam_Az")   then { FBT_Cam_Az   = 180; };
		if (isNil "FBT_Cam_El")   then { FBT_Cam_El   = 30; };
		if (isNil "FBT_Cam_PanOffset") then { FBT_Cam_PanOffset = [0,0,0]; };
		
		// Initialize Active/Target states for smoothing
		missionNamespace setVariable ["FBT_Cam_Active_Dist",      FBT_Cam_Dist];
		missionNamespace setVariable ["FBT_Cam_Active_Az",        FBT_Cam_Az];
		missionNamespace setVariable ["FBT_Cam_Active_El",        FBT_Cam_El];
		missionNamespace setVariable ["FBT_Cam_Active_PanOffset", FBT_Cam_PanOffset];
		
		missionNamespace setVariable ["FBT_Cam_ZDelta", 0];
		if (isNil {missionNamespace getVariable "FBT_Cam_FocusOffsetZ"}) then { missionNamespace setVariable ["FBT_Cam_FocusOffsetZ", 0]; };
		if (isNil {missionNamespace getVariable "FBT_Cam_AutoOrbit"}) then { missionNamespace setVariable ["FBT_Cam_AutoOrbit", true]; };

		// ACE3 mouseButtonState: [LMBanchor, RMBanchor]
		missionNamespace setVariable ["FBT_Cam_MBS", [[], []]];

		if (isNil "FBT_Camera" || {isNull FBT_Camera}) then {
			FBT_Camera = "camera" camCreate (getPos player);
			FBT_Camera camPrepareFocus [-1, -1];
			FBT_Camera camPrepareFov 0.65;
			FBT_Camera camCommitPrepared 0;
		};
		FBT_Camera cameraEffect ["internal", "back"];
		showCinemaBorder false;

		if (!isNil "FBT_Cam_Helper" && {!isNull FBT_Cam_Helper}) then {
			deleteVehicle FBT_Cam_Helper;
		};
		FBT_Cam_Helper = createAgent ["Logic", getPos player, [], 0, "none"];

		// Handlers
		if (!isNil "FBT_Cam_EH_Moving") then { _display displayRemoveEventHandler ["MouseMoving", FBT_Cam_EH_Moving]; };
		if (!isNil "FBT_Cam_EH_Down")   then { _display displayRemoveEventHandler ["MouseButtonDown", FBT_Cam_EH_Down];  };
		if (!isNil "FBT_Cam_EH_Up")     then { _display displayRemoveEventHandler ["MouseButtonUp", FBT_Cam_EH_Up];   };
		if (!isNil "FBT_Cam_EH_Wheel")  then { _display displayRemoveEventHandler ["MouseZChanged", FBT_Cam_EH_Wheel]; };

		FBT_Cam_EH_Moving = _display displayAddEventHandler ["MouseMoving", {
			private _mbs = missionNamespace getVariable ["FBT_Cam_MBS", [[], []]];
			private _LMB = _mbs select 0;
			private _RMB = _mbs select 1;
			
			private _mousePos = getMousePosition;
			private _mouseX = _mousePos select 0;
			private _mouseY = _mousePos select 1;

			// --- CASE 1: DUAL DRAG (Advanced Panning & Height) ---
			if (count _LMB > 0 && count _RMB > 0) then {
				private _dX = (_RMB select 0) - _mouseX;
				private _dY = (_RMB select 1) - _mouseY;

				private _dist = missionNamespace getVariable ["FBT_Cam_Active_Dist", 12];
				private _scale = (_dist * 0.2) max 0.8; 
				private _az = missionNamespace getVariable ["FBT_Cam_Active_Az", 180];

				private _dirX = sin(_az + 90);
				private _dirY = cos(_az + 90);
				private _hPan = [_dirX * _dX * _scale * 10, _dirY * _dX * _scale * 10, 0];
				private _vPan = [0, 0, _dY * _scale * 10];

				private _offset = missionNamespace getVariable ["FBT_Cam_PanOffset", [0,0,0]];
				FBT_Cam_PanOffset = _offset vectorAdd _hPan vectorAdd _vPan;
				missionNamespace setVariable ["FBT_Cam_Active_PanOffset", FBT_Cam_PanOffset];

				_mbs set [0, [_mouseX, _mouseY]];
				_mbs set [1, [_mouseX, _mouseY]];
			} else {
				// --- CASE 2: SINGLE LMB (DISABLED to avoid scrollbar conflict) ---
				// Panning now requires RMB + LMB as requested.

				// --- CASE 3: SINGLE RMB (Orbit) ---
				if (count _RMB > 0) then {
					private _dX = (_RMB select 0) - _mouseX;
					private _dY = (_RMB select 1) - _mouseY;
					
					FBT_Cam_Az = (FBT_Cam_Az - (_dX * 150)) % 360;
					FBT_Cam_El = (FBT_Cam_El - (_dY * 100)) max -85 min 85;

					missionNamespace setVariable ["FBT_Cam_Active_Az", FBT_Cam_Az];
					missionNamespace setVariable ["FBT_Cam_Active_El", FBT_Cam_El];
					
					_mbs set [1, [_mouseX, _mouseY]];
				};
			};

			missionNamespace setVariable ["FBT_Cam_MBS", _mbs];
			false
		}];

		FBT_Cam_EH_Down = _display displayAddEventHandler ["MouseButtonDown", {
			params ["", "_button"];
			private _mbs = missionNamespace getVariable ["FBT_Cam_MBS", [[], []]];
			if (_button == 0) then { _mbs set [0, getMousePosition]; };
			if (_button == 1) then { _mbs set [1, getMousePosition]; };
			missionNamespace setVariable ["FBT_Cam_MBS", _mbs];
			false
		}];

		FBT_Cam_EH_Up = _display displayAddEventHandler ["MouseButtonUp", {
			params ["", "_button"];
			private _mbs = missionNamespace getVariable ["FBT_Cam_MBS", [[], []]];
			if (_button == 0) then { _mbs set [0, []]; };
			if (_button == 1) then { _mbs set [1, []]; };
			missionNamespace setVariable ["FBT_Cam_MBS", _mbs];
			false
		}];

		FBT_Cam_EH_Wheel = _display displayAddEventHandler ["MouseZChanged", {
			params ["", "_zDelta"];
			private _mbs = missionNamespace getVariable ["FBT_Cam_MBS", [[], []]];
			private _isRmbHeld = (count (_mbs select 1) > 0);
			
			if (_isRmbHeld) then {
				missionNamespace setVariable ["FBT_Cam_ZDelta", (missionNamespace getVariable ["FBT_Cam_ZDelta", 0]) + _zDelta];
				true // Consume event only when zooming
			} else {
				false // Allow scrollbar interaction
			};
		}];

		if (!isNil "FBT_Cam_Draw3D") then { removeMissionEventHandler ["Draw3D", FBT_Cam_Draw3D]; };
		FBT_Cam_Draw3D = addMissionEventHandler ["Draw3D", {
			if (isNil "FBT_Camera" || {isNull FBT_Camera}) exitWith {};
			if (isNil "FBT_Cam_Helper" || {isNull FBT_Cam_Helper}) exitWith {};

			private _targetObj = missionNamespace getVariable ["FBT_Cam_TargetObj", objNull];
			if (isNull _targetObj) exitWith {};

			private _targetDist = if (isNil "FBT_Cam_Dist") then {12} else {FBT_Cam_Dist};
			private _targetAz   = if (isNil "FBT_Cam_Az")   then {180} else {FBT_Cam_Az};
			private _targetEl   = if (isNil "FBT_Cam_El")   then {30}  else {FBT_Cam_El};
			private _targetPan  = if (isNil "FBT_Cam_PanOffset") then {[0,0,0]} else {FBT_Cam_PanOffset};

			// --- ZOOM PROCESSING ---
			private _zDelta = missionNamespace getVariable ["FBT_Cam_ZDelta", 0];
			if (_zDelta != 0) then {
				private _zoomScale = (_targetDist / 10) max 1.0;
				FBT_Cam_Dist = (_targetDist - (_zDelta * _zoomScale)) max 1 min 150;
				_targetDist = FBT_Cam_Dist;
				missionNamespace setVariable ["FBT_Cam_Active_Dist", _targetDist];
				missionNamespace setVariable ["FBT_Cam_ZDelta", 0];
			};

			// --- AUTO-ORBIT PROCESSING ---
			private _mbs = missionNamespace getVariable ["FBT_Cam_MBS", [[], []]];
			private _lmbHeld = count (_mbs select 0) > 0;
			private _rmbHeld = count (_mbs select 1) > 0;
			
			if (missionNamespace getVariable ["FBT_Cam_AutoOrbit", false] && {!_rmbHeld}) then {
				FBT_Cam_Az = (FBT_Cam_Az + (diag_deltaTime * 5.0)) % 360;
				_targetAz = FBT_Cam_Az;
			};

			// --- SMOOTHING ---
			private _isInteracting = _lmbHeld || _rmbHeld;
			private _interpFactor = if (_isInteracting) then { 0.4 } else { 0.1 };

			private _activeDist = missionNamespace getVariable ["FBT_Cam_Active_Dist", _targetDist];
			private _activeAz   = missionNamespace getVariable ["FBT_Cam_Active_Az",   _targetAz];
			private _activeEl   = missionNamespace getVariable ["FBT_Cam_Active_El",   _targetEl];
			private _activePan  = missionNamespace getVariable ["FBT_Cam_Active_PanOffset", _targetPan];

			_activeDist = _activeDist + ((_targetDist - _activeDist) * _interpFactor);
			_activeEl   = _activeEl   + ((_targetEl - _activeEl) * _interpFactor);
			_activePan  = _activePan vectorAdd ((_targetPan vectorDiff _activePan) vectorMultiply _interpFactor);

			private _azDiff = (_targetAz - _activeAz);
			if (abs _azDiff > 180) then {
				if (_azDiff > 0) then { _azDiff = _azDiff - 360; } else { _azDiff = _azDiff + 360; };
			};
			_activeAz = (_activeAz + (_azDiff * _interpFactor)) % 360;

			missionNamespace setVariable ["FBT_Cam_Active_Dist", _activeDist];
			missionNamespace setVariable ["FBT_Cam_Active_Az",   _activeAz];
			missionNamespace setVariable ["FBT_Cam_Active_El",   _activeEl];
			missionNamespace setVariable ["FBT_Cam_Active_PanOffset", _activePan];

			// --- POSITIONING ---
			private _rawTargetPos = getPosASL _targetObj;
			private _bb = boundingBoxReal _targetObj;
			private _centerZ = ((_bb select 1) select 2) / 2;
			private _zOffset = missionNamespace getVariable ["FBT_Cam_FocusOffsetZ", 0];
			_rawTargetPos set [2, (_rawTargetPos select 2) + _centerZ + _zOffset];

			private _actualFocalPos = missionNamespace getVariable ["FBT_Cam_ActualFocalPos", _rawTargetPos];
			_actualFocalPos = _actualFocalPos vectorAdd ((_rawTargetPos vectorDiff _actualFocalPos) vectorMultiply 0.1); 
			missionNamespace setVariable ["FBT_Cam_ActualFocalPos", _actualFocalPos];

			private _renderFocalPos = _actualFocalPos vectorAdd _activePan;
			FBT_Cam_Helper setPosASL _renderFocalPos;
			[FBT_Cam_Helper, [_activeAz + 180, -_activeEl, 0]] call BIS_fnc_setObjectRotation;

			FBT_Camera setPosASL (FBT_Cam_Helper modelToWorldWorld [0, -_activeDist, 0]);
			FBT_Camera setVectorDirAndUp [vectorDir FBT_Cam_Helper, vectorUp FBT_Cam_Helper];
		}];
	};

	case "update": {
		_params params [["_targetObj", objNull]];
		if (isNil "_targetObj" || {isNull _targetObj}) exitWith {};
		missionNamespace setVariable ["FBT_Cam_TargetObj", _targetObj];
		FBT_Cam_PanOffset = [0,0,0];
		missionNamespace setVariable ["FBT_Cam_Active_PanOffset", [0,0,0]];
	};

	case "orbit_toggle": {
		private _newOrbit = !(missionNamespace getVariable ["FBT_Cam_AutoOrbit", false]);
		missionNamespace setVariable ["FBT_Cam_AutoOrbit", _newOrbit];
		
		private _display = uiNamespace getVariable ["FBT_Cam_Active_Display", displayNull];
		if (!isNull _display) then {
			private _btn = _display displayCtrl 456007; // IDC for Orbit Toggle
			if (_newOrbit) then {
				_btn ctrlSetTooltip "Camera Orbit: Enabled (Automated)";
			} else {
				_btn ctrlSetTooltip "Camera Orbit: Locked (Manual)";
			};
		};
	};

	case "destroy": {
		if (!isNil "FBT_Cam_Draw3D") then { removeMissionEventHandler ["Draw3D", FBT_Cam_Draw3D]; FBT_Cam_Draw3D = nil; };
		if (!isNil "FBT_Cam_Helper" && {!isNull FBT_Cam_Helper}) then { deleteVehicle FBT_Cam_Helper; FBT_Cam_Helper = nil; };
		if (!isNil "FBT_Camera" && {!isNull FBT_Camera}) then { FBT_Camera cameraEffect ["terminate", "back"]; camDestroy FBT_Camera; FBT_Camera = nil; };
		uiNamespace setVariable ["FBT_Cam_Active_Display", nil];
		{ missionNamespace setVariable [_x, nil]; } forEach [
			"FBT_Cam_TargetObj", "FBT_Cam_MBS", "FBT_Cam_ZDelta", "FBT_Cam_AutoOrbit",
			"FBT_Cam_Active_Dist", "FBT_Cam_Active_Az", "FBT_Cam_Active_El", 
			"FBT_Cam_Active_PanOffset", "FBT_Cam_PanOffset", "FBT_Cam_ActualFocalPos",
			"FBT_Cam_FocusOffsetZ"
		];
		FBT_Cam_Dist = nil; FBT_Cam_Az = nil; FBT_Cam_El = nil;
	};
};
