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

// ---------------------------------------------------------
// 1. Pre-Compile Core Function Library (Optimization)
// ---------------------------------------------------------
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Bridge_Init.sqf";
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Pythia_Sync.sqf";

FBT_fnc_PrepareFramework = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_PrepareFramework.sqf";
FBT_fnc_LoadFactionData  = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_LoadFactionData.sqf";
FBT_fnc_DressDummy       = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_DressDummy.sqf";
FBT_fnc_ScrapeUnit       = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_ScrapeUnit.sqf";
FBT_fnc_UpdateBirdEye    = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_UpdateBirdEye.sqf";

// UI Functions
FBT_fnc_UpdateDropdowns  = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";
FBT_fnc_TabSwitch        = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
FBT_fnc_UpdatePreview    = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdatePreview.sqf";
FBT_fnc_SpawnParade      = compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf";

missionNamespace setVariable ["FBT_Fnc_PrepareFramework", FBT_fnc_PrepareFramework];
missionNamespace setVariable ["FBT_Fnc_LoadFactionData",  FBT_fnc_LoadFactionData];
missionNamespace setVariable ["FBT_Fnc_DressDummy",       FBT_fnc_DressDummy];
missionNamespace setVariable ["FBT_Fnc_ScrapeUnit",       FBT_fnc_ScrapeUnit];
missionNamespace setVariable ["FBT_Fnc_UpdateBirdEye",    FBT_fnc_UpdateBirdEye];
missionNamespace setVariable ["FBT_Fnc_UpdateDropdowns",  FBT_fnc_UpdateDropdowns];
missionNamespace setVariable ["FBT_Fnc_TabSwitch",        FBT_fnc_TabSwitch];
missionNamespace setVariable ["FBT_Fnc_UpdatePreview",    FBT_fnc_UpdatePreview];
missionNamespace setVariable ["FBT_Fnc_SpawnParade",      FBT_fnc_SpawnParade];


// 2. Initialize Hardware & Session Data
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

// --- SESSION PERSISTENCE: COMMIT ON UNLOAD ---
_display displayAddEventHandler ["Unload", {
    ["Commit"] call (missionNamespace getVariable ["FBT_fnc_Pythia_Sync", {}]);
    systemChat "[FBT] Session Changes Committed to Disk.";
}];

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

// 2. Pre-Spawn Agents & Load Initial Parade
[] spawn {
    systemChat "[FBT] Booting Engine: Pre-spawning unit pool...";
    uiSleep 0.1;
    
    private _spawnSet = missionNamespace getVariable ["FBT_SpawnSet", createHashMap];
    private _totalRequired = 0;
    
    {
        private _groupEntry = _y;
        private _leadCount = if (count (_groupEntry getOrDefault ["Lead", []]) > 0) then { 1 } else { 0 };
        private _slotCount = count (_groupEntry getOrDefault ["Slots", []]);
        _totalRequired = _totalRequired + _leadCount + _slotCount;
    } forEach _spawnSet;
    
    private _unitPool = missionNamespace getVariable ["FBT_UnitPool", []];
    private _agentsNeeded = _totalRequired - (count _unitPool);
    
    if (_agentsNeeded > 0) then {
        for "_i" from 1 to _agentsNeeded do {
            private _agent = createAgent ["B_RangeMaster_F", [-5000, -5000, 0], [], 0, "NONE"];
            _agent hideObject true; 
            _agent enableSimulation false;
            _agent allowDamage false;
            _agent disableCollisionWith player;
            if (!isNil "FBT_Anchor") then { _agent disableCollisionWith FBT_Anchor; };
            _unitPool pushBack _agent;
            
            // Yield every 5 agents to keep boot smooth
            if (_i % 5 == 0) then { uiSleep 0.05; };
        };
        missionNamespace setVariable ["FBT_UnitPool", _unitPool];
        systemChat format ["[FBT] Allocated %1 new agents to the pool.", _agentsNeeded];
    };

    systemChat "[FBT] Loading Faction Models...";
    uiSleep 0.5;
    systemChat "[FBT] Tool Ready.";
};
