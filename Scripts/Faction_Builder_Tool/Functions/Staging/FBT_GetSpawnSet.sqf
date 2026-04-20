/*
    FBT_GetSpawnSet.sqf
    -------------------------------
    Scans the local area for objects with FBT/PXG Group and Role markers.
    Prioritizes FBT_ prefix but maintains backward compatibility with legacy PXG_ markers.
*/

private _anchor = missionNamespace getVariable ["FBT_Anchor", player];
private _radius = 200;
private _objects = nearestObjects [_anchor, ["Logic", "EmptyDetector", "B_Target_F"], _radius];

private _spawnMap = createHashMap;

{
    // --- GROUP DETECTION ---
    // Scan direct variable first, then synchronized parent/linked objects
    private _groupVal = _x getVariable ["FBT_Group", _x getVariable ["PXG_Group", -1]];
    if (_groupVal == -1) then {
        {
            private _linkedGroup = _x getVariable ["FBT_Group", _x getVariable ["PXG_Group", -1]];
            if (_linkedGroup != -1) exitWith { _groupVal = _linkedGroup; };
        } forEach (synchronizedObjects _x);
    };

    private _groupID = if (_groupVal isEqualType "") then { parseNumber _groupVal } else { _groupVal };

    if (_groupID > 0) then {
        // --- ROLE DETECTION ---
        private _roleVal = _x getVariable ["FBT_Role", _x getVariable ["PXG_Role", "1"]];
        private _pos = getPosWorld _x;
        private _dir = getDir _x;
        private _data = [_pos, _dir];

        private _groupEntry = _spawnMap getOrDefault [_groupID, createHashMap];
        
        if (_roleVal isEqualType "" && { _roleVal == "Lead" }) then {
            _groupEntry set ["Lead", _data];
        } else {
            private _slots = _groupEntry getOrDefault ["Slots", []];
            private _order = if (_roleVal isEqualType "") then { parseNumber _roleVal } else { _roleVal };
            if (_order == 0 && !(_roleVal in ["0", 0])) then { _order = 99; }; 
            
            _slots pushBack [_order, _data];
            _groupEntry set ["Slots", _slots];
        };
        
        _spawnMap set [_groupID, _groupEntry];
    };
} forEach _objects;

// Sort slots within each group
{
    private _groupEntry = _y;
    private _slots = _groupEntry getOrDefault ["Slots", []];
    if (count _slots > 0) then {
        _slots sort true;
        private _cleanSlots = _slots apply { _x select 1 };
        _groupEntry set ["Slots", _cleanSlots];
    };
} forEach _spawnMap;

missionNamespace setVariable ["FBT_SpawnSet", _spawnMap];

// --- ONE-TIME CAMERA FIELD CALCULATION ---
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

    missionNamespace setVariable ["FBT_Field_Center", _centroid];
    missionNamespace setVariable ["FBT_Field_Zoom", (_maxRadius * 2.5) max 12];

    private _anchorPosASL = getPosASL (missionNamespace getVariable ["FBT_Anchor", objNull]);
    if (!isNull (missionNamespace getVariable ["FBT_Anchor", objNull])) then {
        _centroid set [2, _anchorPosASL select 2];
        missionNamespace setVariable ["FBT_Field_Center", _centroid];
    };

    diag_log format ["[FBT] Camera Field Calculated. Center: %1 | Zoom: %2 | Bearing: %3", _centroid, (_maxRadius * 2.5) max 12, _bearing];
} else {
    missionNamespace setVariable ["FBT_Field_Center", [0,0,0]];
    missionNamespace setVariable ["FBT_Field_Zoom", 20];
    missionNamespace setVariable ["FBT_Field_Bearing", 0];
};

diag_log format ["[FBT] Spawn Set Scanned: %1 marker groups found.", count _spawnMap];
_spawnMap
