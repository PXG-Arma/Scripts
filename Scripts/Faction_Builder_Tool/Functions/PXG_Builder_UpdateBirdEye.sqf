/*
    PXG_Builder_UpdateBirdEye.sqf
    -------------------------------
    Sets the camera to the pre-calculated Platoon Centroid.
    Optimized: No loops, direct reference to static field data.
*/

private _birdAnchor = missionNamespace getVariable ["PXG_Builder_BirdEye_Anchor", objNull];
if (isNull _birdAnchor) exitWith {};

// 1. Get Pre-Calculated Field Data
private _fieldCenter = missionNamespace getVariable ["PXG_Builder_Field_Center", [0,0,0]];
private _fieldZoom = missionNamespace getVariable ["PXG_Builder_Field_Zoom", 12];

// 2. INTERLOCK: If user is actively dragging, skip the centroid snap to prevent "fighting"
private _mbs = missionNamespace getVariable ["PXG_Builder_Cam_MBS", [[], []]];
private _isInteracting = (count (_mbs select 0) > 0) || (count (_mbs select 1) > 0);

if (!_isInteracting) then {
    // Snap the anchor to the static field center (ALP)
    _birdAnchor setPosWorld _fieldCenter;
    // Apply static zoom and bearing
    PXG_Builder_Cam_Dist = _fieldZoom;
    PXG_Builder_Cam_Az = ((missionNamespace getVariable ["PXG_Builder_Field_Bearing", 0]) + 180) % 360;
    PXG_Builder_Cam_PanOffset = [0,0,0]; // Reset any manual pan offsets
    missionNamespace setVariable ["PXG_Builder_Cam_Active_PanOffset", [0,0,0]];
};

// 3. Set Target
missionNamespace setVariable ["PXG_Builder_Cam_TargetObj", _birdAnchor];
