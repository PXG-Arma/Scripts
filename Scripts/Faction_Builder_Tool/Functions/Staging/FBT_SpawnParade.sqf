/*
    FBT_SpawnParade.sqf
    -------------------------------
    Spawns/Pools PHANTOM AGENTS (No simulation, No collision) onto logic markers.
*/

private _myID = diag_tickTime + (random 1);
missionNamespace setVariable ["FBT_ActiveSpawn", _myID];

// 0. UI Visual Feedback (Top Right Indicator)
ctrlShow [456999, true]; 

// 1. Setup Local Collection & Pooling
private _newTmpUnits = [];
private _newLeads = [];

// Initialize/Retrieve Global Pool
private _unitPool = missionNamespace getVariable ["FBT_UnitPool", []];
private _poolIdx = 0;

// 2. Get the Spawn Set (The Markers)
private _spawnSet = missionNamespace getVariable ["FBT_SpawnSet", createHashMap];
if (count _spawnSet == 0) then { _spawnSet = [] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_GetSpawnSet.sqf"; };

// 3. Get Faction Data (The Roles)
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
private _groupsList = _masterHash getOrDefault ["ArmoryGroups", []];
private _rolesList  = _masterHash getOrDefault ["ArmoryRoles", []];
private _idList     = _masterHash getOrDefault ["ArmoryIDs", []];

// Pre-compiled Core Functions
private _fnc_dress  = missionNamespace getVariable ["FBT_Fnc_DressDummy", {}];
private _fnc_scrape = missionNamespace getVariable ["FBT_Fnc_ScrapeUnit",  {}];

// Framework Proxies
private _proxy = missionNamespace getVariable ["FBT_FrameworkProxy", createHashMap];
private _uniCode = _proxy getOrDefault ["Uniforms.sqf", {}];
private _wepCode = _proxy getOrDefault ["Weapons.sqf", {}];
private _geaCode = _proxy getOrDefault ["Gear.sqf", {}];

// Faction Context
private _selSide = lbText [456051, lbCurSel 456051];
private _selFaction = lbText [456052, lbCurSel 456052];
private _selCamo = lbText [456054, lbCurSel 456054];

// 4. Iterate through Faction Groups (POOLING & INVISIBLE DRESSING)
{
    // Concurrency Check: If a newer spawn started, exit immediately
    if ((missionNamespace getVariable ["FBT_ActiveSpawn", 0]) != _myID) exitWith {
        ctrlShow [456999, false];
    };

    private _groupIdx = _forEachIndex;
    private _groupName = _x;
    
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
            // --- UNIT REUSE / POOLING ---
            private _agent = objNull;
            if (_poolIdx < count _unitPool) then {
                _agent = _unitPool select _poolIdx;
                _poolIdx = _poolIdx + 1;
            };

            // If no agent in pool or pool agent is dead/null, create new
            if (isNull _agent || !alive _agent) then {
                _agent = createAgent ["B_RangeMaster_F", _spot select 0, [], 0, "CAN_COLLIDE"];
                _agent hideObject true; 
                _agent enableSimulation false;
                _agent allowDamage false;
                _agent disableCollisionWith player;
                if (!isNil "FBT_Anchor") then { _agent disableCollisionWith FBT_Anchor; };
                _unitPool pushBack _agent;
                _poolIdx = count _unitPool;
            };

            // Ensure hidden during dressing
            _agent hideObject true;
            
            _agent setVariable ["FBT_SpawnID", _myID]; // Tag for safety
            _agent setVariable ["FBT_RoleID", _roleID];
            _agent setVariable ["FBT_GroupName", _groupName];
            if (_forEachIndex == 0) then { _agent setVariable ["FBT_IsLead", true]; } else { _agent setVariable ["FBT_IsLead", nil]; };

            private _baseDir = missionNamespace getVariable ["FBT_AnchorRotation", 0];
            _agent setPosWorld (_spot select 0);
            _agent setDir (_baseDir + 180); 
            
            // --- HIGH-PERFORMANCE DRESSING ---
            private _armory = _masterHash getOrDefault ["Armory", createHashMap];
            private _roleSave = _armory getOrDefault [_roleID, createHashMap];

            if (count _roleSave > 0) then {
                [_agent, _roleSave] call _fnc_dress;
            } else {
                [_selSide, _selFaction, _selCamo, _roleID, _agent] call _uniCode;
                [_selSide, _selFaction, _selCamo, _roleID, _agent] call _wepCode;
                [_selSide, _selFaction, _selCamo, _roleID, _agent] call _geaCode;
                private _scraped = [_agent] call _fnc_scrape;
                _armory set [_roleID, _scraped];
            };

            _agent switchMove "AmovPercMstpSlowWrflDnon";

            _newTmpUnits pushBack _agent;
            if (_forEachIndex == 0) then { _newLeads pushBack _agent; };
        };
    } forEach _rolesInGroup;
} forEach _groupsList;

// 5. ATOMIC COMMIT
// Final check before committing: Are we still the active spawn?
if ((missionNamespace getVariable ["FBT_ActiveSpawn", 0]) != _myID) exitWith {
    ctrlShow [456999, false];
    diag_log "[FBT] Atomic Spawn Aborted: Newer script took control.";
};

// Update Global References
missionNamespace setVariable ["FBT_UnitPool", _unitPool];
missionNamespace setVariable ["FBT_ParadeUnits", _newTmpUnits];
missionNamespace setVariable ["FBT_ParadeLeads", _newLeads];

// Hide remaining pool units that aren't used in this faction
for "_i" from _poolIdx to (count _unitPool - 1) do {
    (_unitPool select _i) hideObject true;
};

// 6. TEXTURE BUFFER & ATOMIC REVEAL
uiSleep 0.3; // Allow brief window for hidden dressing textures to settle

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
} forEach _newTmpUnits;

// Clear Loading Status
ctrlShow [456999, false];

if (_activeTab == "Overview") then {
    if (!(missionNamespace getVariable ["FBT_SuppressEvents", false])) then {
        [] call (missionNamespace getVariable ["FBT_Fnc_UpdateBirdEye", {}]);
    };
};

diag_log format ["[FBT] Atomic Spawn Complete: %1 agents active in parade.", count _newTmpUnits];
missionNamespace setVariable ["FBT_SuppressEvents", false];


