/*
    init_Builder.sqf
    Bootstrapper for Faction Builder Tool (FBT)
*/

if (!hasInterface) exitWith {};

// Support legacy PXG_Anchor name for backward compatibility during migration, but assign to FBT_Anchor
if (isNil "FBT_Anchor" && !isNil "PXG_Anchor") then { FBT_Anchor = PXG_Anchor; };
if (isNil "FBT_Anchor") exitWith { systemChat "Error: FBT_Anchor (or PXG_Anchor) logic object not found!"; };

// Initialize Data Store
execVM "Scripts\Faction_Builder_Tool\Functions\Core\FBT_DataInit.sqf";

// Initialization Locks
missionNamespace setVariable ["FBT_SuppressEvents", true];
missionNamespace setVariable ["FBT_ActiveSpawn", -1];

// Direction and Base Angle (Anchor dependent)
private _posAnchor = getPos FBT_Anchor;
private _anchorDir = getDir FBT_Anchor;

missionNamespace setVariable ["FBT_AnchorPos", _posAnchor];
missionNamespace setVariable ["FBT_AnchorRotation", _anchorDir];

closeDialog 0;
createDialog "FBT_Dialog"; // Updated dialog class name

// Wait for display to be ready
waitUntil {!isNull (findDisplay 456000)};
private _display = findDisplay 456000;
_display setVariable ["FBT_Inventory_Collapsed", true];

// 1. Scan the Spawn Set (Markers)
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_GetSpawnSet.sqf";

// 2. Init Camera Values
missionNamespace setVariable ["FBT_Cam_AutoOrbit", false];
private _initBearing = missionNamespace getVariable ["FBT_Field_Bearing", _anchorDir];
FBT_Cam_Dist = 10;
FBT_Cam_El = 30; 
FBT_Cam_Az = (_initBearing + 180) % 360; 

// 3. Open Overview by default
["Overview"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";

// 4. Init Tool-Specific Camera Handler
[[_display, FBT_Anchor, "NORMAL"], "init"] execVM "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_HandleCamera.sqf";

// --- BOOT LOCK PROTOCOL ---
// 1. Populate Dropdowns
["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";

// 2. Spawn Initial Parade
[] spawn {
    systemChat "[FBT] Loading Faction Models...";
    uiSleep 0.5;
    execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf";
    systemChat "[FBT] Tool Ready.";
};
