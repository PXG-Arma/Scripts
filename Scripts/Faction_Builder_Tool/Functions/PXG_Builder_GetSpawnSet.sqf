/*
    PXG_Builder_GetSpawnSet.sqf
    -------------------------------
    Scans the local area (200m) for objects with:
    - PXG_Group (Number: 1, 2, 3...)
    - PXG_Role  ("Lead" or a number "1", "2", "3"...)
    
    SUPPORT: Inheritance via Synchronization (Sync) lines.
    If a marker has no PXG_Group, it inherits from its synced Leader.
*/

private _anchor = missionNamespace getVariable ["PXG_Anchor", player];
private _radius = 200;
private _objects = nearestObjects [_anchor, ["Logic", "EmptyDetector", "B_Target_F"], _radius];

private _spawnMap = createHashMap; // GroupID (Number) -> { "Lead": [pos, dir], "Slots": [[id, pos, dir], ...] }

{
    private _groupVal = _x getVariable ["PXG_Group", -1];
    
    // INHERITANCE LOGIC: If no group set, check synchronized objects for a leader
    if (_groupVal == -1) then {
        {
            private _linkedGroup = _x getVariable ["PXG_Group", -1];
            if (_linkedGroup != -1) exitWith { _groupVal = _linkedGroup; };
        } forEach (synchronizedObjects _x);
    };

    // Support both direct numbers and strings that look like numbers
    private _groupID = if (_groupVal isEqualType "") then { parseNumber _groupVal } else { _groupVal };

    if (_groupID > 0) then {
        private _roleVal = _x getVariable ["PXG_Role", "1"];
        private _pos = getPosWorld _x;
        private _dir = getDir _x;
        private _data = [_pos, _dir];

        private _groupEntry = _spawnMap getOrDefault [_groupID, createHashMap];
        
        if (_roleVal isEqualType "" && { _roleVal == "Lead" }) then {
            _groupEntry set ["Lead", _data];
        } else {
            private _slots = _groupEntry getOrDefault ["Slots", []];
            private _order = if (_roleVal isEqualType "") then { parseNumber _roleVal } else { _roleVal };
            
            // Safety fallback for non-numeric strings
            if (_order == 0 && !(_roleVal in ["0", 0])) then { _order = 99; }; 
            
            _slots pushBack [_order, _data];
            _groupEntry set ["Slots", _slots];
        };
        
        _spawnMap set [_groupID, _groupEntry];
    };
} forEach _objects;

// Sort Slots by Order inside each group
{
    private _groupEntry = _y;
    private _slots = _groupEntry getOrDefault ["Slots", []];
    if (count _slots > 0) then {
        _slots sort true; // Sort by the first element (the number)
        private _cleanSlots = _slots apply { _x select 1 }; // Extract the [pos, dir]
        _groupEntry set ["Slots", _cleanSlots];
    };
} forEach _spawnMap;

missionNamespace setVariable ["PXG_Builder_SpawnSet", _spawnMap];

// --- ONE-TIME CAMERA CALCULATION ---
private _allLeadPositions = [];
{
    private _leadData = _y getOrDefault ["Lead", []];
    if (count _leadData > 0) then { _allLeadPositions pushBack (_leadData select 0); };
} forEach _spawnMap;

if (count _allLeadPositions > 0) then {
    private _sumPos = [0,0,0];
    { _sumPos = _sumPos vectorAdd _x; } forEach _allLeadPositions;
    private _centroid = _sumPos vectorMultiply (1 / (count _allLeadPositions));
    
    private _maxRadius = 0;
    {
        private _dist = _centroid distance _x;
        if (_dist > _maxRadius) then { _maxRadius = _dist; };
    } forEach _allLeadPositions;

    missionNamespace setVariable ["PXG_Builder_Field_Center", _centroid];
    missionNamespace setVariable ["PXG_Builder_Field_Zoom", (_maxRadius * 2.5) max 12];

    // Sync ALP Altitude with Anchor (Flatten View)
    private _anchorPosASL = getPosASL (missionNamespace getVariable ["PXG_Anchor", objNull]);
    if (!isNull (missionNamespace getVariable ["PXG_Anchor", objNull])) then {
        _centroid set [2, _anchorPosASL select 2];
        missionNamespace setVariable ["PXG_Builder_Field_Center", _centroid];
    };

    // Calculate Bearing from Anchor to Center
    private _anchorPos = missionNamespace getVariable ["PXG_Builder_AnchorPos", [0,0,0]];
    private _bearing = [_anchorPos, _centroid] call BIS_fnc_dirTo;
    missionNamespace setVariable ["PXG_Builder_Field_Bearing", _bearing];

    diag_log format ["[PXG Builder] Camera Field Calculated. Center: %1 | Zoom: %2 | Bearing: %3", _centroid, _maxRadius * 1.5, _bearing];
};

diag_log format ["[PXG Builder] Inheritance Spawn Set Scanned: %1 marker groups found.", count _spawnMap];

_spawnMap
