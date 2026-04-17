/*
    init_Builder.sqf
    Bootstrapper for Faction Builder Tool
*/

if (!hasInterface) exitWith {};

if (isNil "PXG_Anchor") exitWith { systemChat "Error: PXG_Anchor object not found!"; };

// Initialize Data Store
execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_DataInit.sqf";

// Initialization Locks
missionNamespace setVariable ["PXG_Builder_SuppressEvents", true];
missionNamespace setVariable ["PXG_Builder_ActiveSpawn", -1];

// Direction and Base Angle (Anchor dependent)
private _posAnchor = getPos PXG_Anchor;
private _anchorDir = getDir PXG_Anchor;

missionNamespace setVariable ["PXG_Builder_AnchorPos", _posAnchor];
missionNamespace setVariable ["PXG_Builder_AnchorRotation", _anchorDir];

// Create Virtual Bird's Eye Anchor (for dynamic platoon centering)
private _birdAnchor = createAgent ["Logic", _posAnchor, [], 0, "none"];
missionNamespace setVariable ["PXG_Builder_BirdEye_Anchor", _birdAnchor];

closeDialog 0;
createDialog "PXG_Builder_Dialog";

// Wait for display to be ready
waitUntil {!isNull (findDisplay 456000)};
private _display = findDisplay 456000;

// 1. Scan the Spawn Set (Markers)
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_GetSpawnSet.sqf";

// 2. Init Camera (Looking from Anchor to Platoon Center / ALP)
private _initBearing = missionNamespace getVariable ["PXG_Builder_Field_Bearing", _anchorDir];
PXG_Builder_Cam_Dist = 10;
PXG_Builder_Cam_El = 30; 
PXG_Builder_Cam_Az = (_initBearing + 180) % 360; // Opposite placement to face ALP
missionNamespace setVariable ["PXG_Cam_AutoOrbit", false];

// 3. Open Overview by default
["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_TabSwitch.sqf";

// 3. Init Tool-Specific Camera (With Smooth Glide)
[[_display, PXG_Anchor, "NORMAL"], "init"] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleCamera.sqf";

// --- BOOT LOCK PROTOCOL ---
// 1. Populate Dropdowns while suppressed (Silent UI Init)
["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf";

// 2. Spawn Initial Parade
[] spawn {
    systemChat "[PXG Builder] Loading Faction Models...";
    uiSleep 0.5; // Brief buffer for data sync
    execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_SpawnParade.sqf";
    systemChat "[PXG Builder] Tool Ready.";
};
