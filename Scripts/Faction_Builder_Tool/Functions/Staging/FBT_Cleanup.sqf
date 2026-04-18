/*
    FBT_Cleanup.sqf
    -------------------------------
    Cleans up all temporary objects used by the Faction Builder Tool.
*/

// 1. Delete Parade Units (Registered)
private _existingUnits = missionNamespace getVariable ["FBT_ParadeUnits", []];
{ if (!isNull _x) then { deleteVehicle _x; }; } forEach _existingUnits;
missionNamespace setVariable ["FBT_ParadeUnits", []];

// 1.5. FAIL-SAFE SWEEP (Catch Orphans)
// Look for any Agent within 100m of the anchor that has an FBT ID
private _anchorPos = if (!isNil "FBT_Anchor") then { getPos FBT_Anchor } else { [0,0,0] };
if (count _anchorPos > 0) then {
    {
        if (!isNil { _x getVariable "FBT_RoleID" }) then { deleteVehicle _x; };
    } forEach (nearestObjects [_anchorPos, ["CAManBase"], 100]);
};


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
