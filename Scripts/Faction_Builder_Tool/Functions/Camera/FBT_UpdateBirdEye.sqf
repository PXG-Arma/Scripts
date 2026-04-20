/*
    FBT_UpdateBirdEye.sqf
    -------------------------------
    Moves the camera to the Average Lead Position (ALP) for a birds-eye view.
*/

private _centroid = missionNamespace getVariable ["FBT_Field_Center", [0,0,0]];
if (isNil "_centroid") then { _centroid = [0,0,0]; }; 
private _zoom = missionNamespace getVariable ["FBT_Field_Zoom", 20];
private _bearing = missionNamespace getVariable ["FBT_Field_Bearing", 0];

if (_centroid isEqualTo [0,0,0]) exitWith { systemChat "Error: Field center not calculated."; };

// 1. Create/Update an Invisible Target at the Centroid
private _anchor = missionNamespace getVariable ["FBT_BirdEye_Anchor", objNull];
if (isNull _anchor) then {
    _anchor = "Logic" createVehicleLocal _centroid;
    missionNamespace setVariable ["FBT_BirdEye_Anchor", _anchor];
};
_anchor setPosWorld _centroid;

// 2. Snap Camera to the Centroid
missionNamespace setVariable ["FBT_Cam_TargetObj", _anchor];
FBT_Cam_Dist = _zoom;
FBT_Cam_Az = (_bearing + 180) % 360;

// Reset PanOffset for a clean snap to the platoon overview
FBT_Cam_PanOffset = [0,0,0];
missionNamespace setVariable ["FBT_Cam_Active_PanOffset", [0,0,0]];

diag_log format ["[FBT Camera] Bird-Eye Focus: %1 | Zoom: %2", _centroid, _zoom];
