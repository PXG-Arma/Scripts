/*
    FBT_HandleCategory.sqf
    -------------------------------
    Fired when:
    - User clicks a category icon
    - User types in the search box
*/
params ["_input"];
disableSerialization;

private _mode = "CategoryChanged";
if (typeName _input == "ARRAY") then {
    if (typeName (_input select 0) == "STRING") then { _mode = _input select 0; };
};

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _ctrlLoadout = _display displayCtrl 456020; // Top List
private _ctrlPicker  = _display displayCtrl 456090; // Bottom List (Selector)
private _ctrlSearch  = _display displayCtrl 456022; // Top Search (Now filters the picker)

// 1. Resolve Category
private _category = "";
if (_mode == "CategorySelected") then {
    _category = _ctrlLoadout lbData (lbCurSel _ctrlLoadout);
} else {
    // If fired from category icon list
    private _ctrlCat = _display displayCtrl 456070;
    _category = _ctrlCat lbData (lbCurSel _ctrlCat);
};

if (_category == "") exitWith {};
_display setVariable ["FBT_ActiveCategory", _category];

// 2. Fetch Items via Config Scraper
private _items = [_category] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\Core\FBT_ScrapeConfig.sqf");

// 3. Filter Search
private _searchText = toLower (ctrlText _ctrlSearch);
private _tokens = _searchText splitString " ";
private _filtered = [];

{
    private _name = _x select 0;
    private _class = _x select 1;
    private _match = true;
    { if ((toLower _name) find _x == -1 && (toLower _class) find _x == -1) exitWith { _match = false; }; } forEach _tokens;
    if (_match) then { _filtered pushBack _x; };
} forEach _items;

// 4. Update Picker (Bottom)
lbClear _ctrlPicker;
{
    private _idx = _ctrlPicker lbAdd (_x select 0);
    _ctrlPicker lbSetPicture [_idx, _x select 2];
    _ctrlPicker lbSetData [_idx, _x select 1];
    _ctrlPicker lbSetTooltip [_idx, _x select 1];
} forEach _filtered;

// 5. Update Slot List (Bottom Left) if necessary
private _ctrlSlots = _display displayCtrl 456080;
lbClear _ctrlSlots;
if (_category in ["UNIFORM", "VEST", "BACKPACK"]) then {
    {
        private _idx = _ctrlSlots lbAdd (_x select 0);
        _ctrlSlots lbSetPicture [_idx, _path + (_x select 2)];
        _ctrlSlots lbSetData [_idx, _x select 1];
        _ctrlSlots lbSetTooltip [_idx, _x select 0];
    } forEach [
        ["Medical", "medic", "firstaidkit_ca.paa"], 
        ["Ammo", "ammo", "magazine_ca.paa"], 
        ["Grenades", "grenade", "grenade_ca.paa"], 
        ["Misc", "misc", "items_ca.paa"]
    ];
};


if (lbSize _ctrlLoadout > 0) then { _ctrlLoadout lbSetCurSel 0; };
if (lbSize _ctrlSlots > 0) then { _ctrlSlots lbSetCurSel 0; };
