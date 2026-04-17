/*
    PXG_Builder_SpawnParade.sqf
    -------------------------------
    Spawns PHANTOM AGENTS (No simulation, No collision) onto logic markers.
    Uses Numeric Mapping (Group Index 0 -> Marker Group 1).
*/

private _myID = diag_tickTime;
missionNamespace setVariable ["PXG_Builder_ActiveSpawn", _myID];

// 1. Cleanup existing agents
private _existingUnits = missionNamespace getVariable ["PXG_Builder_ParadeUnits", []];
{ deleteVehicle _x; } forEach _existingUnits;
missionNamespace setVariable ["PXG_Builder_ParadeUnits", []];
uiSleep 0.1;

// 2. Get the Spawn Set (The Markers)
private _spawnSet = missionNamespace getVariable ["PXG_Builder_SpawnSet", createHashMap];
if (count _spawnSet == 0) then { _spawnSet = [] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_GetSpawnSet.sqf"; };

// 3. Get Faction Data (The Roles)
private _masterHash = missionNamespace getVariable ["PXG_Builder_MasterHash", createHashMap];
private _groupsList = _masterHash getOrDefault ["ArmoryGroups", []];
private _rolesList  = _masterHash getOrDefault ["ArmoryRoles", []];
private _idList     = _masterHash getOrDefault ["ArmoryIDs", []];

// Framework Proxies
private _proxy = missionNamespace getVariable ["PXG_Builder_FrameworkProxy", createHashMap];
private _uniCode = _proxy getOrDefault ["Uniforms.sqf", {}];
private _wepCode = _proxy getOrDefault ["Weapons.sqf", {}];
private _geaCode = _proxy getOrDefault ["Gear.sqf", {}];

// Faction Context
private _selSide = lbText [456051, lbCurSel 456051];
private _selFaction = lbText [456052, lbCurSel 456052];
private _selCamo = lbText [456054, lbCurSel 456054];

private _newUnits = [];
private _newLeads = [];

// 4. Iterate through Faction Groups by Index
{
    if ((missionNamespace getVariable ["PXG_Builder_ActiveSpawn", 0]) != _myID) exitWith {};

    private _groupIdx = _forEachIndex;
    private _groupName = _x;
    
    // MAPPING: Use integer index (+1) to find the Marker Cluster
    private _markerGroupID = _groupIdx + 1;
    private _markerSet = _spawnSet getOrDefault [_markerGroupID, createHashMap];
    
    private _leaderMarker = _markerSet getOrDefault ["Lead", []];
    private _slotMarkers = _markerSet getOrDefault ["Slots", []];

    private _rolesInGroup = _rolesList select _groupIdx;
    private _idsInGroup = _idList select _groupIdx;

    {
        private _roleName = _x;
        private _roleID = _idsInGroup select _forEachIndex;
        
        // Find a spot
        private _spot = [];
        if (_forEachIndex == 0 && count _leaderMarker > 0) then {
            _spot = _leaderMarker;
        } else {
            private _slotIdx = if (count _leaderMarker > 0) then { _forEachIndex - 1 } else { _forEachIndex };
            if (_slotIdx < count _slotMarkers) then {
                _spot = _slotMarkers select _slotIdx;
            };
        };

        if (count _spot > 0) then {
            // SPAWN PHANTOM AGENT (Initially Hidden)
            private _agent = createAgent ["B_RangeMaster_F", _spot select 0, [], 0, "CAN_COLLIDE"];
            _agent hideObject true; // Hide during prep to prevent "pop-in" visuals
            
            // POSITION & DIRECTION (Face the Anchor)
            private _baseDir = missionNamespace getVariable ["PXG_Builder_AnchorRotation", 0];
            _agent setPosWorld (_spot select 0);
            _agent setDir (_baseDir + 180); 
            
            // HARDEN STATE
            _agent enableSimulation false;
            _agent allowDamage false;
            _agent setVariable ["PXG_Builder_RoleID", _roleID];
            _agent setVariable ["PXG_Builder_GroupName", _groupName];
            if (_forEachIndex == 0) then { _agent setVariable ["PXG_Builder_IsLead", true]; };
            
            // COLLISION ISOLATION
            _agent disableCollisionWith player;
            if (!isNil "PXG_Anchor") then { _agent disableCollisionWith PXG_Anchor; };
            
            // DRESS AGENT
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _uniCode;
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _wepCode;
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _geaCode;

            // POSTURE: Gun out but relaxed (Tactical Ready - Weapon Lowered)
            _agent switchMove "AmovPercMstpSlowWrflDnon";

            _newUnits pushBack _agent;
            if (_forEachIndex == 0) then { _newLeads pushBack _agent; };
        };
    } forEach _rolesInGroup;

    // Remove uiSleep 0.05; // Removed to allow instantaneous platoon transition
} forEach _groupsList;

missionNamespace setVariable ["PXG_Builder_ParadeUnits", _newUnits];
missionNamespace setVariable ["PXG_Builder_ParadeLeads", _newLeads];

// 5. SYNCHRONIZED REVEAL
private _activeTab = missionNamespace getVariable ["PXG_Builder_ActiveTab", "Overview"];
private _selectedPath = tvCurSel (findDisplay 456000 displayCtrl 456010);
private _selectedID = (findDisplay 456000 displayCtrl 456010) tvData _selectedPath;

{
    if (_activeTab == "Overview") then {
        _x hideObject false;
    } else {
        // In Armory/Config tabs, only show the unit that matches the selection
        if ((_x getVariable ["PXG_Builder_RoleID", ""]) == _selectedID) then {
            _x hideObject false;
            missionNamespace setVariable ["PXG_Builder_Cam_TargetObj", _x]; // Ensure camera snaps to the new agent
        } else {
            _x hideObject true;
        };
    };
} forEach _newUnits;

// 6. DYNAMIC CAMERA ANCHORING (Overview)
if (_activeTab == "Overview") then {
    if (!(missionNamespace getVariable ["PXG_Builder_SuppressEvents", false])) then {
        [] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateBirdEye.sqf";
    };
};

systemChat format ["[PXG Builder] Instant Batch Complete: %1 agents transitioned.", count _newUnits];

// Release initialization lock (Safe to repeat)
missionNamespace setVariable ["PXG_Builder_SuppressEvents", false];
