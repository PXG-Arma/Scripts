/*
    FBT_Cleanup.sqf
    -------------------------------
    Cleans up all temporary objects used by the Faction Builder Tool.
*/

// 0. Signal termination for any background spawn scripts
missionNamespace setVariable ["FBT_ActiveSpawn", -1];

// 1. Delete Pool & Parade Units (Registered)
private _unitPool = missionNamespace getVariable ["FBT_UnitPool", []];
{ if (!isNull _x) then { deleteVehicle _x; }; } forEach _unitPool;
missionNamespace setVariable ["FBT_UnitPool", []];
missionNamespace setVariable ["FBT_ParadeUnits", []];

// 1.5. FAIL-SAFE SWEEP (Catch Orphans)
private _anchorPos = if (!isNil "FBT_Anchor") then { getPos FBT_Anchor } else { [0,0,0] };
private _activeID = missionNamespace getVariable ["FBT_ActiveSpawn", -1];

if (count _anchorPos > 0) then {
    {
        private _unitID = _x getVariable ["FBT_SpawnID", -2];
        // Only delete if it's an FBT unit AND it's not part of the active spawn session
        if (!isNil { _x getVariable "FBT_RoleID" } && { _unitID != _activeID }) then { 
            deleteVehicle _x; 
        };
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
