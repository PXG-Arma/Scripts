params ["_input"];
disableSerialization;

// 0. Re-entrancy Guard
if (missionNamespace getVariable ["FBT_Busy_HandleSlotClick", false]) exitWith {};
missionNamespace setVariable ["FBT_Busy_HandleSlotClick", true];

private _mode = "SlotChanged";
if (typeName _input == "ARRAY") then {
    if (count _input > 0 && {typeName (_input select 0) == "STRING"}) then { _mode = _input select 0; };
};

private _display = findDisplay 456000;
if (isNull _display) exitWith { missionNamespace setVariable ["FBT_Busy_HandleSlotClick", false]; };

private _ctrlSlots = _display displayCtrl 456080; // Bottom Left
private _ctrlList  = _display displayCtrl 456090; // Bottom Right
private _ctrlSearch = _display displayCtrl 456091; // Bottom Search
private _dummy = missionNamespace getVariable ["FBT_Preview_Unit", objNull];

// 1. Resolve State
private _slotType = _ctrlSlots lbData (lbCurSel _ctrlSlots);
private _activeCategory = _display getVariable ["FBT_ActiveCategory", "PRIMARY"];
_display setVariable ["FBT_ActiveSlot", _slotType];

// 2. Fetch Items
private _allItems = [];
if (_slotType in ["optic", "muzzle", "acc", "bipod"]) then {
    _allItems = [_dummy, _slotType] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_GetCompatibleItems.sqf");
} else {
    if (_slotType == "ammo") then {
        _allItems = [_dummy] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_GetCompatibleMags.sqf");
    };
    // Future: Add logic for Medical, Grenades, etc.
};

// 3. Filter Search
private _searchText = toLower (ctrlText _ctrlSearch);
private _filtered = [];

if (_searchText == "") then {
    _filtered = _allItems;
} else {
    private _tokens = _searchText splitString " ";
    {
        private _name = toLower (_x select 0);
        private _class = toLower (_x select 1);
        private _match = true;
        { if (_name find _x == -1 && _class find _x == -1) exitWith { _match = false; }; } forEach _tokens;
        if (_match) then { _filtered pushBack _x; };
    } forEach _allItems;
};

// 4. Update UI with Highlighting
missionNamespace setVariable ["FBT_SuppressEvents", true];
lbClear _ctrlList;

private _equippedItems = [];
if (_activeCategory in ["PRIMARY", "HANDGUN"]) then {
    _equippedItems = if (_activeCategory == "PRIMARY") then { primaryWeaponItems _dummy } else { handgunItems _dummy };
};

private _selectedIdx = -1;
{
    private _idx = _ctrlList lbAdd (_x select 0);
    _ctrlList lbSetPicture [_idx, _x select 2];
    _ctrlList lbSetData [_idx, _x select 1];
    _ctrlList lbSetTooltip [_idx, _x select 1];
    
    // Highlight if currently equipped
    if ((_x select 1) in _equippedItems) then {
        _selectedIdx = _idx;
        _ctrlList lbSetColor [_idx, [0.4, 0.8, 0.8, 1]];
    };
} forEach _filtered;

if (_selectedIdx != -1) then { _ctrlList lbSetCurSel _selectedIdx; };
missionNamespace setVariable ["FBT_SuppressEvents", false];

if (_mode == "SlotChanged") then {
    // systemChat format ["Slot %1 selected.", _slotType];
};

missionNamespace setVariable ["FBT_Busy_HandleSlotClick", false];
