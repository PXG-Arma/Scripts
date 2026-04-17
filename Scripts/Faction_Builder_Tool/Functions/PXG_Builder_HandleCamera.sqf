params ["_params", "_mode"];

/*
	Generic Camera Handler FOR FACTION BUILDER
	Upgraded to Advanced "Reference" Architecture
*/

switch (_mode) do {
	case "init": {
		diag_log "[PXG Builder Camera] Initializing Advanced Mode...";
		_params params ["_display", "_targetSource", ["_targetMode", "NORMAL"]];
		
		if (isNull _display) exitWith { diag_log "[PXG Builder Camera] Init Failed: Display is null"; };
		if (isNull _targetSource) exitWith { diag_log "[PXG Builder Camera] Init Aborted: Target Source is null."; };

		// Store session config
		uiNamespace setVariable ["PXG_Builder_Cam_Active_Display", _display];
		missionNamespace setVariable ["PXG_Builder_Cam_TargetObj", _targetSource];

		// Camera state scalars - Persistence check
		if (isNil "PXG_Builder_Cam_Dist") then { PXG_Builder_Cam_Dist = 10; };
		if (isNil "PXG_Builder_Cam_Az")   then { PXG_Builder_Cam_Az   = 180; };
		if (isNil "PXG_Builder_Cam_El")   then { PXG_Builder_Cam_El   = 30; };
		if (isNil "PXG_Builder_Cam_PanOffset") then { PXG_Builder_Cam_PanOffset = [0,0,0]; };
		
		// Initialize Active/Target states for smoothing
		missionNamespace setVariable ["PXG_Builder_Cam_Active_Dist", PXG_Builder_Cam_Dist];
		missionNamespace setVariable ["PXG_Builder_Cam_Active_Az",   PXG_Builder_Cam_Az];
		missionNamespace setVariable ["PXG_Builder_Cam_Active_El",   PXG_Builder_Cam_El];
		missionNamespace setVariable ["PXG_Builder_Cam_Active_PanOffset", PXG_Builder_Cam_PanOffset];
		missionNamespace setVariable ["PXG_Builder_Cam_ZDelta", 0];

		// ACE3 mouseButtonState: [LMBanchor, RMBanchor]
		missionNamespace setVariable ["PXG_Builder_Cam_MBS", [[], []]];

		if (isNil "PXG_Builder_Camera" || {isNull PXG_Builder_Camera}) then {
			PXG_Builder_Camera = "camera" camCreate (getPos player);
			PXG_Builder_Camera camPrepareFocus [-1, -1];
			PXG_Builder_Camera camPrepareFov 0.65;
			PXG_Builder_Camera camCommitPrepared 0;
		};
		PXG_Builder_Camera cameraEffect ["internal", "back"];
		showCinemaBorder false;

		if (!isNil "PXG_Builder_Cam_Helper" && {!isNull PXG_Builder_Cam_Helper}) then {
			deleteVehicle PXG_Builder_Cam_Helper;
		};
		PXG_Builder_Cam_Helper = createAgent ["Logic", getPos player, [], 0, "none"];

		// Handlers
		if (!isNil "PXG_Builder_Cam_EH_Moving") then { _display displayRemoveEventHandler ["MouseMoving", PXG_Builder_Cam_EH_Moving]; };
		if (!isNil "PXG_Builder_Cam_EH_Down")   then { _display displayRemoveEventHandler ["MouseButtonDown", PXG_Builder_Cam_EH_Down];  };
		if (!isNil "PXG_Builder_Cam_EH_Up")     then { _display displayRemoveEventHandler ["MouseButtonUp", PXG_Builder_Cam_EH_Up];   };
		if (!isNil "PXG_Builder_Cam_EH_Wheel")  then { _display displayRemoveEventHandler ["MouseZChanged", PXG_Builder_Cam_EH_Wheel]; };

		PXG_Builder_Cam_EH_Moving = _display displayAddEventHandler ["MouseMoving", {
			private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
			private _LMB = _mbs select 0;
			private _RMB = _mbs select 1;
			
			private _mousePos = getMousePosition;
			private _mouseX = _mousePos select 0;
			private _mouseY = _mousePos select 1;

			// --- CASE 1: DUAL DRAG (Advanced Panning & Height) ---
			if (count _LMB > 0 && count _RMB > 0) then {
				private _dX = (_RMB select 0) - _mouseX;
				private _dY = (_RMB select 1) - _mouseY;

				private _dist = missionNamespace getVariable ["PXG_Builder_Cam_Active_Dist", 12];
				private _scale = (_dist * 0.2) max 0.8; // Increased base and slope
				private _az = missionNamespace getVariable ["PXG_Builder_Cam_Active_Az", 180];

				// Planar Panning (Relative to Camera)
				private _dirX = sin(_az + 90);
				private _dirY = cos(_az + 90);
				private _hPan = [_dirX * _dX * _scale * 10, _dirY * _dX * _scale * 10, 0];
				
				// Vertical Pan (World Z)
				private _vPan = [0, 0, _dY * _scale * 10];

				private _offset = missionNamespace getVariable ["PXG_Builder_Cam_PanOffset", [0,0,0]];
				PXG_Builder_Cam_PanOffset = _offset vectorAdd _hPan vectorAdd _vPan;

				// Instant response for user movement
				missionNamespace setVariable ["PXG_Builder_Cam_Active_PanOffset", PXG_Builder_Cam_PanOffset];

				_mbs set [0, [_mouseX, _mouseY]];
				_mbs set [1, [_mouseX, _mouseY]];
			} else {
				// --- CASE 2: SINGLE LMB (Planar Pan) ---
				if (count _LMB > 0) then {
					private _dX = (_LMB select 0) - _mouseX;
					private _dY = (_LMB select 1) - _mouseY;

					private _dist = missionNamespace getVariable ["PXG_Builder_Cam_Active_Dist", 12];
					private _scale = (_dist * 0.1) max 0.5;
					private _az = missionNamespace getVariable ["PXG_Builder_Cam_Active_Az", 180];

					// View Vectors
					private _cam = missionNamespace getVariable ["PXG_Builder_Camera", objNull];
					if (!isNull _cam) then {
						private _fwd = vectorDir _cam; _fwd set [2,0]; _fwd = vectorNormalized _fwd;
						private _side = _fwd vectorCrossProduct [0,0,1];

						private _moveVec = (_side vectorMultiply (_dX * _scale * 10)) vectorAdd (_fwd vectorMultiply (-_dY * _scale * 10));
						
						private _offset = missionNamespace getVariable ["PXG_Builder_Cam_PanOffset", [0,0,0]];
						PXG_Builder_Cam_PanOffset = _offset vectorAdd _moveVec;
						missionNamespace setVariable ["PXG_Builder_Cam_Active_PanOffset", PXG_Builder_Cam_PanOffset];
					};
					_mbs set [0, [_mouseX, _mouseY]];
				};

				// --- CASE 3: SINGLE RMB (Orbit) ---
				if (count _RMB > 0) then {
					private _dX = (_RMB select 0) - _mouseX;
					private _dY = (_RMB select 1) - _mouseY;
					
					PXG_Builder_Cam_Az = (PXG_Builder_Cam_Az - (_dX * 150)) % 360;
					PXG_Builder_Cam_El = (PXG_Builder_Cam_El - (_dY * 100)) max -85 min 85;

					missionNamespace setVariable ["PXG_Builder_Cam_Active_Az", PXG_Builder_Cam_Az];
					missionNamespace setVariable ["PXG_Builder_Cam_Active_El", PXG_Builder_Cam_El];
					
					_mbs set [1, [_mouseX, _mouseY]];
				};
			};

			missionNamespace setVariable ["PXG_Builder_Cam_MBS", _mbs];
			false
		}];

		PXG_Builder_Cam_EH_Down = _display displayAddEventHandler ["MouseButtonDown", {
			params ["_display", "_button"];
			private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
			if (_button == 0) then { _mbs set [0, getMousePosition]; };
			if (_button == 1) then { _mbs set [1, getMousePosition]; };
			missionNamespace setVariable ["PXG_Builder_Cam_MBS", _mbs];
			false
		}];

		PXG_Builder_Cam_EH_Up = _display displayAddEventHandler ["MouseButtonUp", {
			params ["_display", "_button"];
			private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
			if (_button == 0) then { _mbs set [0, []]; };
			if (_button == 1) then { _mbs set [1, []]; };
			missionNamespace setVariable ["PXG_Builder_Cam_MBS", _mbs];
			false
		}];

		PXG_Builder_Cam_EH_Wheel = _display displayAddEventHandler ["MouseZChanged", {
			params ["_display", "_zDelta"];
			private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
			private _isRmbHeld = (count (_mbs select 1) > 0);
			
			if (_isRmbHeld) then {
				missionNamespace setVariable ["PXG_Builder_Cam_ZDelta",
					(missionNamespace getVariable ["PXG_Builder_Cam_ZDelta", 0]) + _zDelta];
			};
			true
		}];

		if (!isNil "PXG_Builder_Cam_Draw3D") then { removeMissionEventHandler ["Draw3D", PXG_Builder_Cam_Draw3D]; };
		PXG_Builder_Cam_Draw3D = addMissionEventHandler ["Draw3D", {
			if (isNil "PXG_Builder_Camera" || {isNull PXG_Builder_Camera}) exitWith {};
			if (isNil "PXG_Builder_Cam_Helper" || {isNull PXG_Builder_Cam_Helper}) exitWith {};

			private _targetObj = missionNamespace getVariable ["PXG_Builder_Cam_TargetObj", objNull];
			if (isNull _targetObj) exitWith {};

			// --- THE ENGINE: Get Target States ---
			private _targetDist = if (isNil "PXG_Builder_Cam_Dist") then {10} else {PXG_Builder_Cam_Dist};
			private _targetAz   = if (isNil "PXG_Builder_Cam_Az")   then {180} else {PXG_Builder_Cam_Az};
			private _targetEl   = if (isNil "PXG_Builder_Cam_El")   then {30}  else {PXG_Builder_Cam_El};
			private _targetPan  = if (isNil "PXG_Builder_Cam_PanOffset") then {[0,0,0]} else {PXG_Builder_Cam_PanOffset};

			// --- ZOOM SENSITIVITY ---
			private _zDelta = missionNamespace getVariable ["PXG_Builder_Cam_ZDelta", 0];
			if (_zDelta != 0) then {
				private _zoomScale = (_targetDist / 10) max 1.0;
				PXG_Builder_Cam_Dist = (_targetDist - (_zDelta * _zoomScale)) max 1 min 150;
				_targetDist = PXG_Builder_Cam_Dist;
				missionNamespace setVariable ["PXG_Builder_Cam_Active_Dist", _targetDist];
				missionNamespace setVariable ["PXG_Builder_Cam_ZDelta", 0];
			};

			// --- INTERPOLATION (SMOOTHING) ---
			private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
			private _isInteracting = (count (_mbs select 0) > 0) || (count (_mbs select 1) > 0);
			
			// If interacting, snap faster. If gliding, move smoothly.
			private _interpFactor = if (_isInteracting) then { 0.4 } else { 0.1 };

			private _activeDist = missionNamespace getVariable ["PXG_Builder_Cam_Active_Dist", _targetDist];
			private _activeAz   = missionNamespace getVariable ["PXG_Builder_Cam_Active_Az",   _targetAz];
			private _activeEl   = missionNamespace getVariable ["PXG_Builder_Cam_Active_El",   _targetEl];
			private _activePan  = missionNamespace getVariable ["PXG_Builder_Cam_Active_PanOffset", _targetPan];

			_activeDist = _activeDist + ((_targetDist - _activeDist) * _interpFactor);
			_activeEl   = _activeEl   + ((_targetEl - _activeEl) * _interpFactor);
			_activePan  = _activePan vectorAdd ((_targetPan vectorDiff _activePan) vectorMultiply _interpFactor);

			// Azimuth shortest-path interpolation
			private _azDiff = (_targetAz - _activeAz);
			if (abs _azDiff > 180) then {
				if (_azDiff > 0) then { _azDiff = _azDiff - 360; } else { _azDiff = _azDiff + 360; };
			};
			_activeAz = (_activeAz + (_azDiff * _interpFactor)) % 360;

			missionNamespace setVariable ["PXG_Builder_Cam_Active_Dist", _activeDist];
			missionNamespace setVariable ["PXG_Builder_Cam_Active_Az",   _activeAz];
			missionNamespace setVariable ["PXG_Builder_Cam_Active_El",   _activeEl];
			missionNamespace setVariable ["PXG_Builder_Cam_Active_PanOffset", _activePan];

			// --- UNIT / TARGET SMOOTHING ---
			private _rawTargetPos = getPosASL _targetObj;
			private _bb = boundingBoxReal _targetObj;
			private _centerZ = ((_bb select 1) select 2) / 2;
			_rawTargetPos set [2, (_rawTargetPos select 2) + _centerZ];

			private _actualFocalPos = missionNamespace getVariable ["PXG_Builder_Cam_ActualFocalPos", _rawTargetPos];
			_actualFocalPos = _actualFocalPos vectorAdd ((_rawTargetPos vectorDiff _actualFocalPos) vectorMultiply 0.1); 
			missionNamespace setVariable ["PXG_Builder_Cam_ActualFocalPos", _actualFocalPos];

			// Apply final positioning
			private _renderFocalPos = _actualFocalPos vectorAdd _activePan;
			PXG_Builder_Cam_Helper setPosASL _renderFocalPos;
			[PXG_Builder_Cam_Helper, [_activeAz + 180, -_activeEl, 0]] call BIS_fnc_setObjectRotation;

			PXG_Builder_Camera setPosASL (PXG_Builder_Cam_Helper modelToWorldWorld [0, -_activeDist, 0]);
			PXG_Builder_Camera setVectorDirAndUp [vectorDir PXG_Builder_Cam_Helper, vectorUp PXG_Builder_Cam_Helper];
		}];
	};

	case "destroy": {
		if (!isNil "PXG_Builder_Cam_Draw3D") then { removeMissionEventHandler ["Draw3D", PXG_Builder_Cam_Draw3D]; PXG_Builder_Cam_Draw3D = nil; };
		if (!isNil "PXG_Builder_Cam_Helper" && {!isNull PXG_Builder_Cam_Helper}) then { deleteVehicle PXG_Builder_Cam_Helper; PXG_Builder_Cam_Helper = nil; };
		if (!isNil "PXG_Builder_Camera" && {!isNull PXG_Builder_Camera}) then { PXG_Builder_Camera cameraEffect ["terminate", "back"]; camDestroy PXG_Builder_Camera; PXG_Builder_Camera = nil; };
		uiNamespace setVariable ["PXG_Builder_Cam_Active_Display", nil];
		{ missionNamespace setVariable [_x, nil]; } forEach [
			"PXG_Builder_Cam_TargetObj", "PXG_Builder_Cam_MBS", "PXG_Builder_Cam_ZDelta",
			"PXG_Builder_Cam_Active_Dist", "PXG_Builder_Cam_Active_Az", "PXG_Builder_Cam_Active_El", 
			"PXG_Builder_Cam_Active_PanOffset", "PXG_Builder_Cam_PanOffset", "PXG_Builder_Cam_ActualFocalPos"
		];
		PXG_Builder_Cam_Dist = nil; PXG_Builder_Cam_Az = nil; PXG_Builder_Cam_El = nil;
		private _previewVic = missionNamespace getVariable ["PXG_Builder_Preview_Unit", objNull];
		if (!isNull _previewVic) then { deleteVehicle _previewVic; };
		missionNamespace setVariable ["PXG_Builder_Preview_Unit", nil];
	};
};
