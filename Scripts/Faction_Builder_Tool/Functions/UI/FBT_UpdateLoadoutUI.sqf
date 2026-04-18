/*
    FBT_UpdateLoadoutUI.sqf
    -------------------------------
    Populates the right sidebar's main listbox with the current loadout of the selected unit.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _tree = _display displayCtrl 456010;
private _path = tvCurSel _tree;
if (count _path == 0) exitWith {};

private _roleID = _tree tvData _path;
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
private _armory = _masterHash getOrDefault ["Armory", createHashMap];
private _roleData = _armory getOrDefault [_roleID, createHashMap];

private _ctrlList = _display displayCtrl 456020;
lbClear _ctrlList;

// Define the display order and categories
private _categories = [
    ["UNIFORM", "Uniform"],
    ["VEST", "Vest"],
    ["BACKPACK", "Backpack"],
    ["HEADGEAR", "Headgear"],
    ["GOGGLES", "Goggles"],
    ["PRIMARY", "Primary Weapon"],
    ["HANDGUN", "Handgun"],
    ["LAUNCHER", "Launcher"],
    ["BINOC", "Binoculars"],
    ["NVG", "NVG/Linked"]
];

{
    _x params ["_cat", "_label"];
    private _item = _roleData getOrDefault [_cat, ""];
    
    private _displayName = "[None]";
    private _picture = "";
    
    private _itemExists = if (typeName _item == "ARRAY") then { count _item > 0 } else { _item != "" };
    
    if (_itemExists) then {
        // Handle cases where _item might be an array (for weapons)
        private _class = if (typeName _item == "ARRAY") then { _item select 0 } else { _item };
        
        private _cfg = (configFile >> "CfgWeapons" >> _class);
        if !(isClass _cfg) then { _cfg = (configFile >> "CfgVehicles" >> _class); };
        if !(isClass _cfg) then { _cfg = (configFile >> "CfgGlasses" >> _class); };
        
        if (isClass _cfg) then {
            _displayName = getText (_cfg >> "displayName");
            _picture = getText (_cfg >> "picture");
        } else {
            _displayName = _class;
        };
    };

    private _idx = _ctrlList lbAdd format ["%1: %2", _label, _displayName];
    _ctrlList lbSetData [_idx, _cat]; // Store category in data so clicking it knows what to browse
    if (_picture != "") then { _ctrlList lbSetPicture [_idx, _picture]; };
    
    // Aesthetic: Greyscale for empty slots, Teal for filled
    if (!_itemExists) then {
        _ctrlList lbSetColor [_idx, [0.5, 0.5, 0.5, 1]];
    } else {
        _ctrlList lbSetColor [_idx, [0.4, 0.8, 0.8, 1]];
    };
} forEach _categories;

// Special section: Ammunition & Items count? 
// Maybe just a summary for now to keep it clean.
private _mags = _roleData getOrDefault ["MAGAZINES", []];
private _items = _roleData getOrDefault ["ITEMS", []];
if (count _mags > 0 || count _items > 0) then {
    private _idx = _ctrlList lbAdd format ["Inventory: %1 Mags, %2 Items", count _mags, count _items];
    _ctrlList lbSetData [_idx, "ITEMS"];
    _ctrlList lbSetColor [_idx, [0.8, 0.8, 0.4, 1]];
};
