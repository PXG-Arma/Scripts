/*
    FBT_HandleCategory.sqf
    -------------------------------
    Fired when:
    - User clicks a category icon
    - User types in the search box
*/
params [["_input", "CategoryChanged"]];
disableSerialization;

// 0. Re-entrancy Guard
if (missionNamespace getVariable ["FBT_Busy_HandleCategory", false]) exitWith {};
missionNamespace setVariable ["FBT_Busy_HandleCategory", true];

private _mode = "CategoryChanged";
if (!isNil "_input") then {
    if (typeName _input == "ARRAY" && {count _input > 0}) then {
        if (typeName (_input select 0) == "STRING") then { _mode = _input select 0; };
    } else {
        if (typeName _input == "STRING") then { _mode = _input; };
    };
};


private _display = findDisplay 456000;
if (isNull _display) exitWith { missionNamespace setVariable ["FBT_Busy_HandleCategory", false]; };

private _ctrlPicker = _display displayCtrl 456020; // NEW: Top list is now the main picker
private _ctrlSearch = _display displayCtrl 456022;
private _dummy = missionNamespace getVariable ["FBT_Preview_Unit", objNull];

// 1. Resolve Category
private _ctrlCat = _display displayCtrl 456070;
private _category = _ctrlCat lbData (lbCurSel _ctrlCat);

if (_category == "") exitWith { missionNamespace setVariable ["FBT_Busy_HandleCategory", false]; };
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

// 4. Update Main Picker (Top)
missionNamespace setVariable ["FBT_SuppressEvents", true]; // Prevent FBT_ApplyGear from firing
lbClear _ctrlPicker;

private _equipped = "";
switch (_category) do {
    case "PRIMARY":   { _equipped = primaryWeapon _dummy; };
    case "HANDGUN":   { _equipped = handgunWeapon _dummy; };
    case "LAUNCHER":  { _equipped = secondaryWeapon _dummy; };
    case "UNIFORM":   { _equipped = uniform _dummy; };
    case "VEST":      { _equipped = vest _dummy; };
    case "BACKPACK":  { _equipped = backpack _dummy; };
    case "HEADGEAR":  { _equipped = headgear _dummy; };
    case "GOGGLES":   { _equipped = goggles _dummy; };
    case "BINOC":     { _equipped = binocular _dummy; };
    case "NVG":       { 
        private _items = assignedItems _dummy;
        { if (getNumber(configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type") == 616) exitWith { _equipped = _x; }; } forEach _items;
    };
};

private _selectedIdx = -1;
{
    private _idx = _ctrlPicker lbAdd (_x select 0);
    _ctrlPicker lbSetPicture [_idx, _x select 2];
    _ctrlPicker lbSetData [_idx, _x select 1];
    _ctrlPicker lbSetTooltip [_idx, _x select 1];
    
    if ((_x select 1) == _equipped) then {
        _selectedIdx = _idx;
        _ctrlPicker lbSetColor [_idx, [0.4, 0.8, 0.8, 1]]; // Highlight equipped
    };
} forEach _filtered;

if (_selectedIdx != -1) then { _ctrlPicker lbSetCurSel _selectedIdx; };

// 5. Update Sub-Slot List (Bottom Left)
private _ctrlSlots = _display displayCtrl 456080;
lbClear _ctrlSlots;

private _slots = [];
private _iconPath = "\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\";

if (_category in ["PRIMARY", "HANDGUN"]) then {
    _slots = [
        ["Optic", "optic", _iconPath + "itemoptic_ca.paa"],
        ["Muzzle", "muzzle", _iconPath + "itemmuzzle_ca.paa"],
        ["Pointer", "acc", _iconPath + "itemacc_ca.paa"],
        ["Bipod", "bipod", _iconPath + "itembipod_ca.paa"],
        ["Ammo", "ammo", _iconPath + "itemmag_ca.paa"]
    ];
};

if (_category in ["UNIFORM", "VEST", "BACKPACK"]) then {
    _slots = [
        ["Medical", "medic", "firstaidkit_ca.paa"], 
        ["Ammo", "ammo", "magazine_ca.paa"], 
        ["Grenades", "grenade", "grenade_ca.paa"], 
        ["Misc", "misc", "items_ca.paa"]
    ];
};

{
    private _idx = _ctrlSlots lbAdd "";
    _ctrlSlots lbSetPicture [_idx, _x select 2];
    _ctrlSlots lbSetData [_idx, _x select 1];
    _ctrlSlots lbSetTooltip [_idx, _x select 0];
    _ctrlSlots lbSetPictureColor [_idx, [1, 1, 1, 1]];
    _ctrlSlots lbSetPictureColorSelected [_idx, [0.29, 0.42, 0.42, 1]];
} forEach _slots;

if (lbSize _ctrlSlots > 0) then { 
    _ctrlSlots lbSetCurSel 0; 
    // Synchronously refresh the slot picker
    ["SlotChanged"] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleSlotClick.sqf");
};

missionNamespace setVariable ["FBT_SuppressEvents", false];
missionNamespace setVariable ["FBT_Busy_HandleCategory", false];
