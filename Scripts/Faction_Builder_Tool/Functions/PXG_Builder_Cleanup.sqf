/*
    PXG_Builder_Cleanup.sqf
    -------------------------------
    Cleans up all temporary objects used by the Faction Builder Tool.
*/

// 1. Delete Parade Units
private _existingUnits = missionNamespace getVariable ["PXG_Builder_ParadeUnits", []];
{ deleteVehicle _x; } forEach _existingUnits;
missionNamespace setVariable ["PXG_Builder_ParadeUnits", []];

// 2. Delete Preview Unit
private _previewUnit = missionNamespace getVariable ["PXG_Builder_Preview_Unit", objNull];
if (!isNull _previewUnit) then { deleteVehicle _previewUnit; };
missionNamespace setVariable ["PXG_Builder_Preview_Unit", objNull];

// 2.5 Delete Virtual Anchor
private _birdAnchor = missionNamespace getVariable ["PXG_Builder_BirdEye_Anchor", objNull];
if (!isNull _birdAnchor) then { deleteVehicle _birdAnchor; };
missionNamespace setVariable ["PXG_Builder_BirdEye_Anchor", nil];

// 3. Destroy Camera
[[], "destroy"] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleCamera.sqf";

diag_log "[PXG Builder] Cleanup sequence complete.";
