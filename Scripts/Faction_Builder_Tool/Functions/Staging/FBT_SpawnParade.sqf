/*
    FBT_SpawnParade.sqf
    -------------------------------
    Spawns PHANTOM AGENTS (No simulation, No collision) onto logic markers.
*/

private _myID = diag_tickTime;
missionNamespace setVariable ["FBT_ActiveSpawn", _myID];

// 1. Cleanup existing agents
private _existingUnits = missionNamespace getVariable ["FBT_ParadeUnits", []];
{ deleteVehicle _x; } forEach _existingUnits;
missionNamespace setVariable ["FBT_ParadeUnits", []];
uiSleep 0.1;

// 2. Get the Spawn Set (The Markers)
private _spawnSet = missionNamespace getVariable ["FBT_SpawnSet", createHashMap];
if (count _spawnSet == 0) then { _spawnSet = [] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_GetSpawnSet.sqf"; };

// 3. Get Faction Data (The Roles)
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
private _groupsList = _masterHash getOrDefault ["ArmoryGroups", []];
private _rolesList  = _masterHash getOrDefault ["ArmoryRoles", []];
private _idList     = _masterHash getOrDefault ["ArmoryIDs", []];

// Framework Proxies
private _proxy = missionNamespace getVariable ["FBT_FrameworkProxy", createHashMap];
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
    if ((missionNamespace getVariable ["FBT_ActiveSpawn", 0]) != _myID) exitWith {};

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
            private _agent = createAgent ["B_RangeMaster_F", _spot select 0, [], 0, "CAN_COLLIDE"];
            
            // --- ITERATIVE REGISTRATION (Safety) ---
            private _reg = missionNamespace getVariable ["FBT_ParadeUnits", []];
            _reg pushBack _agent;
            missionNamespace setVariable ["FBT_ParadeUnits", _reg];

            _agent hideObject true; 
            
            private _baseDir = missionNamespace getVariable ["FBT_AnchorRotation", 0];
            _agent setPosWorld (_spot select 0);
            _agent setDir (_baseDir + 180); 
            
            _agent enableSimulation false;
            _agent allowDamage false;
            _agent setVariable ["FBT_RoleID", _roleID];
            _agent setVariable ["FBT_GroupName", _groupName];
            if (_forEachIndex == 0) then { _agent setVariable ["FBT_IsLead", true]; };
            
            _agent disableCollisionWith player;
            if (!isNil "FBT_Anchor") then { _agent disableCollisionWith FBT_Anchor; };
            
            // DRESS AGENT
        private _armory = _masterHash getOrDefault ["Armory", createHashMap];
        private _roleSave = _armory getOrDefault [_roleID, createHashMap];

        if (count _roleSave > 0) then {
            // Apply saved session data
            [_agent, _roleSave] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_DressDummy.sqf");
        } else {
            // Fallback to framework proxies (Defaults)
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _uniCode;
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _wepCode;
            [_selSide, _selFaction, _selCamo, _roleID, _agent] call _geaCode;

            // SCRAPE IMMEDIATELY: If this was a legacy unit, capture its gear into the tool's session
            // This enables "Instant Duplication" and "Instant Editing" of legacy 8-file factions.
            private _scraped = [_agent] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_ScrapeUnit.sqf");
            _armory set [_roleID, _scraped];
            _masterHash set ["Armory", _armory];
            diag_log format ["[FBT Scrape] Captured legacy gear for %1 (%2)", _roleID, _roleName];
        };

            _agent switchMove "AmovPercMstpSlowWrflDnon";

            _newUnits pushBack _agent;
            if (_forEachIndex == 0) then { _newLeads pushBack _agent; };
        };
    } forEach _rolesInGroup;
} forEach _groupsList;

missionNamespace setVariable ["FBT_ParadeLeads", _newLeads];


// 5. SYNCHRONIZED REVEAL (Pre-load Assets)
uiSleep 0.5; // Brief wait to allow gear textures/models to settle

private _activeTab = missionNamespace getVariable ["FBT_ActiveTab", "Overview"];
private _selectedPath = tvCurSel (findDisplay 456000 displayCtrl 456010);
private _selectedID = (findDisplay 456000 displayCtrl 456010) tvData _selectedPath;

{
    if (_activeTab == "Overview") then {
        _x hideObject false;
    } else {
        if ((_x getVariable ["FBT_RoleID", ""]) == _selectedID) then {
            _x hideObject false;
            missionNamespace setVariable ["FBT_Cam_TargetObj", _x]; 
        } else {
            _x hideObject true;
        };
    };
} forEach _newUnits;

if (_activeTab == "Overview") then {
    if (!(missionNamespace getVariable ["FBT_SuppressEvents", false])) then {
        [] execVM "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_UpdateBirdEye.sqf";
    };
};

systemChat format ["[FBT] Instant Batch Complete: %1 agents transitioned.", count _newUnits];
missionNamespace setVariable ["FBT_SuppressEvents", false];
