params ["_params", "_mode"];

/*
	Generic Camera Handler for PXG - ACE3 Architecture
	Modes:
	"init"         - [_display, _targetSource, _targetMode, _lbIDC, _orbitBtnIDC]
	"update"       - [] (called when spawn point selection changes)
	"orbit_toggle" - []
	"destroy"      - []

	Architecture (mirrors ACE Arsenal camera):
	- cameraHelper: invisible Logic agent attached to target vehicle. Rotated to desired
	  heading/pitch. Camera copies the helper's world-space direction vectors.
	- Draw3D event: fires in sync with EVERY rendered frame (not EachFrame which is
	  simulation-rate). This eliminates the rendering-vs-simulation phase mismatch jitter.
	- mouseButtonState [[], []]: ACE3's proven drag detection. Slot 1 = RMB anchor position.
	  Empty array = button not held. No boolean flags that can go stale.
	- Input applies directly in MouseMoving (not buffered), rendering reads every Draw3D.
*/

switch (_mode) do {
	case "init": {
		diag_log "[PXG Camera] Initializing...";
		_params params ["_display", "_targetSource", ["_targetMode", "SYNC"], ["_lbIDC", -1], ["_orbitBtnIDC", -1]];
		
		// Security Handler: Armory (IDD 431234) does not support the 3D orbit camera logic.
		// Explicitly hide the orbit button and exit if called from Armory.
		if (!isNull _display && {ctrlIDD _display == 431234}) exitWith {
			if (_orbitBtnIDC != -1) then { (_display displayCtrl _orbitBtnIDC) ctrlShow false; };
			diag_log "[PXG Camera] Init Aborted: Armory security check triggered.";
		};

		if (isNull _display) exitWith { diag_log "[PXG Camera] Init Failed: Display is null"; };
		if (isNull _targetSource && _targetMode == "SYNC") exitWith { 
			diag_log "[PXG Camera] Init Aborted: Target Source is null.";
		};

		private _initCount = (missionNamespace getVariable ["PXG_Cam_InitCount", 0]) + 1;
		missionNamespace setVariable ["PXG_Cam_InitCount", _initCount];
		diag_log format ["[PXG Camera] INIT #%1 at t=%2  Display=%3 Source=%4", _initCount, time, _display, _targetSource];

		// Store session config
		uiNamespace setVariable ["PXG_Cam_Active_Display", _display];
		PXG_Cam_Active_Source   = _targetSource;
		PXG_Cam_Active_Mode     = _targetMode;
		PXG_Cam_Active_LB_IDC   = _lbIDC;
		PXG_Cam_Active_Orbit_IDC = _orbitBtnIDC;

		// Camera state scalars - Persistence check
		if (isNil "PXG_Cam_Dist") then { PXG_Cam_Dist = 35; };
		if (isNil "PXG_Cam_Az")   then { PXG_Cam_Az   = 180; };
		if (isNil "PXG_Cam_El")   then { PXG_Cam_El   = 25; };
		
		// Initialize Active/Target states for smoothing
		missionNamespace setVariable ["PXG_Cam_Active_Dist",      PXG_Cam_Dist];
		missionNamespace setVariable ["PXG_Cam_Active_Az",        PXG_Cam_Az];
		missionNamespace setVariable ["PXG_Cam_Active_El",        PXG_Cam_El];
		missionNamespace setVariable ["PXG_Cam_Active_PanOffset", if (isNil "PXG_Cam_PanOffset") then {[0,0,0]} else {PXG_Cam_PanOffset}];

		if (isNil {missionNamespace getVariable "PXG_Cam_ZDelta"})    then { missionNamespace setVariable ["PXG_Cam_ZDelta", 0]; };
		if (isNil {missionNamespace getVariable "PXG_Cam_AutoOrbit"}) then { missionNamespace setVariable ["PXG_Cam_AutoOrbit", true]; };

		// ACE3 mouseButtonState: [LMBanchor, RMBanchor]. [] = not held.
		missionNamespace setVariable ["PXG_Cam_MBS", [[], []]];
		if (isNil "PXG_Cam_PanOffset") then { PXG_Cam_PanOffset = [0, 0, 0]; };

		// -----------------------------------------------------------------------
		// Create camera object (ACE: GVAR(camera) = "camera" camCreate ...)
		// -----------------------------------------------------------------------
		if (isNil "PXG_Motorpool_Camera" || {isNull PXG_Motorpool_Camera}) then {
			PXG_Motorpool_Camera = "camera" camCreate (getPos player);
			PXG_Motorpool_Camera camPrepareFocus [-1, -1];
			PXG_Motorpool_Camera camPrepareFov 0.65;
			PXG_Motorpool_Camera camCommitPrepared 0;
		};
		PXG_Motorpool_Camera cameraEffect ["internal", "back"];
		showCinemaBorder false;

		// -----------------------------------------------------------------------
		// cameraHelper: invisible Logic agent that handles rotation math.
		// ACE: GVAR(cameraHelper) attachTo [center, helperOffset, ""].
		// We attach it to the target vehicle, at its center.
		// The helper is rotated to [azimuth+180, -elevation, 0] each Draw3D.
		// Camera then copies helper's vectorDir/vectorUp = correct, jitter-free orientation.
		// -----------------------------------------------------------------------
		if (!isNil "PXG_Cam_Helper" && {!isNull PXG_Cam_Helper}) then {
			deleteVehicle PXG_Cam_Helper;
		};
		// Helper is created at player pos initially; it will be re-attached on first update
		PXG_Cam_Helper = createAgent ["Logic", getPos player, [], 0, "none"];

		// -----------------------------------------------------------------------
		// Display event handlers
		// -----------------------------------------------------------------------
		if (!isNil "PXG_Cam_EH_Moving") then { _display displayRemoveEventHandler ["MouseMoving",    PXG_Cam_EH_Moving]; };
		if (!isNil "PXG_Cam_EH_Down")   then { _display displayRemoveEventHandler ["MouseButtonDown", PXG_Cam_EH_Down];  };
		if (!isNil "PXG_Cam_EH_Up")     then { _display displayRemoveEventHandler ["MouseButtonUp",   PXG_Cam_EH_Up];   };
		if (!isNil "PXG_Cam_EH_Wheel")  then { _display displayRemoveEventHandler ["MouseZChanged",   PXG_Cam_EH_Wheel]; };

		PXG_Cam_EH_Moving = _display displayAddEventHandler ["MouseMoving", {
			private _mbs = missionNamespace getVariable ["PXG_Cam_MBS", [[], []]];
			private _mousePos = getMousePosition;
			private _mouseX = _mousePos select 0;
			private _mouseY = _mousePos select 1;

			private _LMB = _mbs select 0;
			private _RMB = _mbs select 1;

			// Handle DUAL DRAG (Panning)
			if (count _LMB > 0 && count _RMB > 0) then {
				private _dX = (_RMB select 0) - _mouseX;
				private _dY = (_RMB select 1) - _mouseY;

				// DYNAMIC SENSITIVITY: Scale pan speed by distance
				private _dist = missionNamespace getVariable ["PXG_Cam_Active_Dist", 35];
				private _scale = (_dist * 0.1) max 1.5; 
				private _az = missionNamespace getVariable ["PXG_Cam_Active_Az", 180];

				// Horizontal Pan (Relative to Camera Azimuth)
				private _dirX = sin(_az + 90);
				private _dirY = cos(_az + 90);
				private _hPan = [_dirX * _dX * _scale, _dirY * _dX * _scale, 0];
				
				// Vertical Pan (World Height)
				private _vPan = [0, 0, _dY * _scale];

				PXG_Cam_PanOffset = PXG_Cam_PanOffset vectorAdd _hPan vectorAdd _vPan;

				// USER MOVEMENT: Snap active state to target (Instant response)
				missionNamespace setVariable ["PXG_Cam_Active_PanOffset", PXG_Cam_PanOffset];

				_mbs set [0, [_mouseX, _mouseY]];
				_mbs set [1, [_mouseX, _mouseY]];
				missionNamespace setVariable ["PXG_Cam_MBS", _mbs];
			} else {
				// Handle SINGLE RMB DRAG (Orbit)
				if (count _RMB > 0) then {
					private _dX = (_RMB select 0) - _mouseX;
					private _dY = (_RMB select 1) - _mouseY;
					
					PXG_Cam_Az = (PXG_Cam_Az - (_dX * 150)) % 360;
					PXG_Cam_El = (PXG_Cam_El - (_dY * 100)) max -85 min 85;

					// USER MOVEMENT: Snap active state to target (Instant response)
					missionNamespace setVariable ["PXG_Cam_Active_Az", PXG_Cam_Az];
					missionNamespace setVariable ["PXG_Cam_Active_El", PXG_Cam_El];
					
					_mbs set [1, [_mouseX, _mouseY]];
					missionNamespace setVariable ["PXG_Cam_MBS", _mbs];
				};
			};
			false
		}];

		PXG_Cam_EH_Down = _display displayAddEventHandler ["MouseButtonDown", {
			params ["_display", "_button"];
			private _handled = false;
			if (_button in [0, 1, 2]) then {
				private _mbs = missionNamespace getVariable ["PXG_Cam_MBS", [[], []]];
				private _idx = if (_button == 0) then {0} else {1};
				_mbs set [_idx, getMousePosition];
				missionNamespace setVariable ["PXG_Cam_MBS", _mbs];
				_handled = true;
			};
			_handled
		}];

		PXG_Cam_EH_Up = _display displayAddEventHandler ["MouseButtonUp", {
			params ["_display", "_button"];
			private _handled = false;
			if (_button in [0, 1, 2]) then {
				private _mbs = missionNamespace getVariable ["PXG_Cam_MBS", [[], []]];
				private _idx = if (_button == 0) then {0} else {1};
				_mbs set [_idx, []];
				missionNamespace setVariable ["PXG_Cam_MBS", _mbs];
				_handled = true;
			};
			_handled
		}];

		PXG_Cam_EH_Wheel = _display displayAddEventHandler ["MouseZChanged", {
			params ["_display", "_zDelta"];
			
			// Only allow zoom if RMB is held (to avoid conflict with pylon list scroll)
			private _mbs = missionNamespace getVariable ["PXG_Cam_MBS", [[], []]];
			private _isRmbHeld = (count (_mbs select 1) > 0);
			
			if (_isRmbHeld) then {
				missionNamespace setVariable ["PXG_Cam_ZDelta",
					(missionNamespace getVariable ["PXG_Cam_ZDelta", 0]) + _zDelta];
			};
			true
		}];

		// -----------------------------------------------------------------------
		// Draw3D render loop - fires in sync with every rendered frame.
		// ACE: GVAR(camPosUpdateHandle) = addMissionEventHandler ["Draw3D", {call FUNC(updateCamPos)}]
		// This is the critical difference from EachFrame — Draw3D is rendering-synchronized.
		// -----------------------------------------------------------------------
		if (!isNil "PXG_Cam_Draw3D") then {
			removeMissionEventHandler ["Draw3D", PXG_Cam_Draw3D];
		};
		PXG_Cam_Draw3D = addMissionEventHandler ["Draw3D", {
			if (isNil "PXG_Motorpool_Camera" || {isNull PXG_Motorpool_Camera}) exitWith {};
			if (isNil "PXG_Cam_Helper"       || {isNull PXG_Cam_Helper})       exitWith {};

			private _targetObj = missionNamespace getVariable ["PXG_Cam_TargetObj", objNull];
			if (isNull _targetObj) exitWith {};

			// --- THE ENGINE: Get Target States ---
			private _targetDist = if (isNil "PXG_Cam_Dist") then {35}  else {PXG_Cam_Dist};
			private _targetAz   = if (isNil "PXG_Cam_Az")   then {180} else {PXG_Cam_Az};
			private _targetEl   = if (isNil "PXG_Cam_El")   then {25}  else {PXG_Cam_El};
			private _targetPan  = if (isNil "PXG_Cam_PanOffset") then {[0,0,0]} else {PXG_Cam_PanOffset};

			// --- ZOOM SENSITIVITY ---
			private _zDelta = missionNamespace getVariable ["PXG_Cam_ZDelta", 0];
			if (_zDelta != 0) then {
				// DYNAMIC SENSITIVITY: Scale zoom speed by distance
				private _zoomScale = (_targetDist / 10) max 1.5;
				PXG_Cam_Dist = (_targetDist - (_zDelta * _zoomScale)) max 1 min 150;
				_targetDist = PXG_Cam_Dist;

				// USER MOVEMENT: Snap active state to target (Instant response)
				missionNamespace setVariable ["PXG_Cam_Active_Dist", _targetDist];

				missionNamespace setVariable ["PXG_Cam_ZDelta", 0];
			};

			// --- AUTO-ORBIT ---
			private _rmbHeld = count ((missionNamespace getVariable ["PXG_Cam_MBS", [[], []]]) select 1) > 0;
			if (missionNamespace getVariable ["PXG_Cam_AutoOrbit", false] && !_rmbHeld) then {
				PXG_Cam_Az = (_targetAz + (diag_deltaTime * 1.0)) % 360;
				_targetAz = PXG_Cam_Az;
			};

			// --- INTERPOLATION (SMOOTHING) ---
			private _activeDist = missionNamespace getVariable ["PXG_Cam_Active_Dist", _targetDist];
			private _activeAz   = missionNamespace getVariable ["PXG_Cam_Active_Az",   _targetAz];
			private _activeEl   = missionNamespace getVariable ["PXG_Cam_Active_El",   _targetEl];
			private _activePan  = missionNamespace getVariable ["PXG_Cam_Active_PanOffset", _targetPan];

			// Smooth Factor: 0.15 (Glide) vs 0.5 (Quick)
			private _interpFactor = 0.15; 
			
			_activeDist = _activeDist + ((_targetDist - _activeDist) * _interpFactor);
			_activeEl   = _activeEl   + ((_targetEl - _activeEl) * _interpFactor);
			_activePan  = _activePan vectorAdd ((_targetPan vectorDiff _activePan) vectorMultiply _interpFactor);

			// Azimuth shortest-path interpolation (fixes 360->0 flip)
			private _azDiff = (_targetAz - _activeAz);
			if (abs _azDiff > 180) then {
				if (_azDiff > 0) then { _azDiff = _azDiff - 360; } else { _azDiff = _azDiff + 360; };
			};
			_activeAz = (_activeAz + (_azDiff * _interpFactor)) % 360;

			// Store updated active states
			missionNamespace setVariable ["PXG_Cam_Active_Dist", _activeDist];
			missionNamespace setVariable ["PXG_Cam_Active_Az",   _activeAz];
			missionNamespace setVariable ["PXG_Cam_Active_El",   _activeEl];
			missionNamespace setVariable ["PXG_Cam_Active_PanOffset", _activePan];

			// --- POSITIONING ---
			private _targetPosASL = getPosASL _targetObj;
			_targetPosASL = _targetPosASL vectorAdd _activePan;

			private _bb = boundingBoxReal _targetObj;
			private _centerZ = ((_bb select 1) select 2) / 2;
			_targetPosASL set [2, (_targetPosASL select 2) + _centerZ];

			PXG_Cam_Helper setPosASL _targetPosASL;
			[PXG_Cam_Helper, [_activeAz + 180, -_activeEl, 0]] call BIS_fnc_setObjectRotation;

			PXG_Motorpool_Camera setPosASL (PXG_Cam_Helper modelToWorldWorld [0, -_activeDist, 0]);
			PXG_Motorpool_Camera setVectorDirAndUp [vectorDir PXG_Cam_Helper, vectorUp PXG_Cam_Helper];
		}];

		// 6. Explicitly run one update to ensure immediate focus on target
		[[], "update"] execVM "Scripts\Misc\PXG_Handle_Camera.sqf";
	};

	case "update": {
		diag_log "[PXG Camera] Update called";
		if (isNil "PXG_Motorpool_Camera" || {isNull PXG_Motorpool_Camera}) exitWith {
			diag_log "[PXG Camera] Update aborted: No camera object";
		};

		private _display     = uiNamespace getVariable ["PXG_Cam_Active_Display", displayNull];
		private _targetSource = if (isNil "PXG_Cam_Active_Source") then {objNull} else {PXG_Cam_Active_Source};
		private _modeType    = if (isNil "PXG_Cam_Active_Mode")   then {"SYNC"} else {PXG_Cam_Active_Mode};
		private _lbIDC       = if (isNil "PXG_Cam_Active_LB_IDC") then {-1}    else {PXG_Cam_Active_LB_IDC};

		if (isNull _display) exitWith {};

		private _targetObj = objNull;

		if (_modeType == "SYNC") then {
			if (_lbIDC == -1) exitWith {};
			private _ctrlSpawnList = _display displayCtrl _lbIDC;
			private _index = lbCurSel _ctrlSpawnList;
			if (_index != -1) then {
				private _syncObjects = synchronizedObjects _targetSource;
				if (count _syncObjects > _index) then {
					_targetObj = _syncObjects select _index;
				};
			};
		} else {
			_targetObj = _targetSource;
		};

		if (isNull _targetObj) exitWith {};
		missionNamespace setVariable ["PXG_Cam_TargetObj", _targetObj];
		PXG_Cam_PanOffset = [0, 0, 0]; // Reset pan when target changes
	};

	case "orbit_toggle": {
		private _newOrbit = !(missionNamespace getVariable ["PXG_Cam_AutoOrbit", false]);
		missionNamespace setVariable ["PXG_Cam_AutoOrbit", _newOrbit];
		private _display = uiNamespace getVariable ["PXG_Cam_Active_Display", displayNull];
		private _btnIDC  = if (isNil "PXG_Cam_Active_Orbit_IDC") then {-1} else {PXG_Cam_Active_Orbit_IDC};
		
		if (!isNull _display && _btnIDC != -1) then {
			private _btn = _display displayCtrl _btnIDC;
			if (_newOrbit) then {
				_btn ctrlSetTooltip "Camera: Orbiting (Click to Lock)";
			} else {
				_btn ctrlSetTooltip "Camera: Locked (Click to Orbit)";
			};
		};
	};

	case "destroy": {
		private _isSwapping = missionNamespace getVariable ["PXG_Cam_IsSwapping", false];
		// Force cleanup if not swapping
		if (!_isSwapping) then {
			if (!isNil "PXG_Cam_Draw3D") then {
				removeMissionEventHandler ["Draw3D", PXG_Cam_Draw3D];
				PXG_Cam_Draw3D = nil;
			};

			if (!isNil "PXG_Cam_Helper" && {!isNull PXG_Cam_Helper}) then {
				deleteVehicle PXG_Cam_Helper;
				PXG_Cam_Helper = nil;
			};

			if (!isNil "PXG_Motorpool_Camera" && {!isNull PXG_Motorpool_Camera}) then {
				PXG_Motorpool_Camera cameraEffect ["terminate", "back"];
				camDestroy PXG_Motorpool_Camera;
				PXG_Motorpool_Camera = nil;
			};
			
			uiNamespace setVariable ["PXG_Cam_Active_Display", nil];
			PXG_Cam_Active_Source = nil; PXG_Cam_Active_Mode = nil;
			PXG_Cam_Active_LB_IDC = nil; PXG_Cam_Active_Orbit_IDC = nil;
			
			{ missionNamespace setVariable [_x, nil]; } forEach [
				"PXG_Cam_TargetObj", "PXG_Cam_AutoOrbit",
				"PXG_Cam_MBS", "PXG_Cam_ZDelta"
			];
			PXG_Cam_Dist = nil; PXG_Cam_Az = nil; PXG_Cam_El = nil;
			PXG_Cam_PanOffset = nil;

			// Cleanup Preview Vehicle
			private _previewVic = missionNamespace getVariable ["PXG_Motorpool_Preview_Vic", objNull];
			if (!isNull _previewVic) then { deleteVehicle _previewVic; };
			missionNamespace setVariable ["PXG_Motorpool_Preview_Vic", nil];

			// Cleanup Builder Preview Unit
			private _builderUnit = missionNamespace getVariable ["PXG_Builder_Preview_Unit", objNull];
			if (!isNull _builderUnit) then { deleteVehicle _builderUnit; };
			missionNamespace setVariable ["PXG_Builder_Preview_Unit", nil];
			player setVariable ["PXG_Motorpool_Active_Vehicle", nil];
			player setVariable ["PXG_Motorpool_CustomPylons", nil];
		};

		// Always remove UI handlers from the (closing) display
		private _display = uiNamespace getVariable ["PXG_Cam_Active_Display", displayNull];
		if (!isNull _display) then {
			if (!isNil "PXG_Cam_EH_Moving") then { _display displayRemoveEventHandler ["MouseMoving",    PXG_Cam_EH_Moving]; };
			if (!isNil "PXG_Cam_EH_Down")   then { _display displayRemoveEventHandler ["MouseButtonDown", PXG_Cam_EH_Down];  };
			if (!isNil "PXG_Cam_EH_Up")     then { _display displayRemoveEventHandler ["MouseButtonUp",   PXG_Cam_EH_Up];   };
			if (!isNil "PXG_Cam_EH_Wheel")  then { _display displayRemoveEventHandler ["MouseZChanged",   PXG_Cam_EH_Wheel]; };
			PXG_Cam_EH_Moving = nil; PXG_Cam_EH_Down = nil; PXG_Cam_EH_Up = nil; PXG_Cam_EH_Wheel = nil;
		};
	};
};
