/*
    FBT_Cleanup.sqf
    -------------------------------
    Cleans up all temporary objects used by the Faction Builder Tool.
*/

// 1. Delete Parade Units
private _existingUnits = missionNamespace getVariable ["FBT_ParadeUnits", []];
{ deleteVehicle _x; } forEach _existingUnits;
missionNamespace setVariable ["FBT_ParadeUnits", []];

// 2. Delete Preview Unit
private _previewUnit = missionNamespace getVariable ["FBT_Preview_Unit", objNull];
if (!isNull _previewUnit) then { deleteVehicle _previewUnit; };
missionNamespace setVariable ["FBT_Preview_Unit", objNull];

// 2.5 Delete Virtual Anchor
private _birdAnchor = missionNamespace getVariable ["FBT_BirdEye_Anchor", objNull];
if (!isNull _birdAnchor) then { deleteVehicle _birdAnchor; };
missionNamespace setVariable ["FBT_BirdEye_Anchor", nil];

// 3. Destroy Camera
[[], "destroy"] execVM "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_HandleCamera.sqf";

diag_log "[FBT] Cleanup sequence complete.";
