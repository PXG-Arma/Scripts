params ["_input"];
disableSerialization;

private _mode = "SlotChanged";
if (typeName _input == "ARRAY") then {
    if (count _input > 0 && {typeName (_input select 0) == "STRING"}) then { _mode = _input select 0; };
};

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _ctrlSlots = _display displayCtrl 456080; // Bottom Left
private _ctrlList  = _display displayCtrl 456090; // Bottom Right
private _ctrlSearch = _display displayCtrl 456091; // Bottom Search
private _dummy = missionNamespace getVariable ["FBT_Preview_Unit", objNull];

// 1. Resolve State
private _slotType = _ctrlSlots lbData (lbCurSel _ctrlSlots);

// If this is a weapon category, the "Slot" is an attachment slot.
// If this is a baseline category (Uniform/Vest), the "Slot" is a container category (Medical/Ammo).
private _activeCategory = _display getVariable ["FBT_ActiveCategory", "PRIMARY"];
_display setVariable ["FBT_ActiveSlot", _slotType];

// 2. Fetch Items
private _allItems = [];
if (_slotType in ["optic", "muzzle", "acc", "bipod"]) then {
    _allItems = [_dummy, _slotType] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_GetCompatibleItems.sqf");
} else {
    // Basic Item Groups
    if (_slotType == "ammo") then {
        _allItems = call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Armory\FBT_GetCompatibleMags.sqf");
    };
    // Placeholder for other groups...
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

// 4. Update UI
lbClear _ctrlList;
{
    private _idx = _ctrlList lbAdd (_x select 0);
    _ctrlList lbSetPicture [_idx, _x select 2];
    _ctrlList lbSetData [_idx, _x select 1];
} forEach _filtered;

if (_mode == "SlotChanged") then {
    systemChat format ["Slot %1 selected.", _slotType];
};
