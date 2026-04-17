/*
    PXG_Builder_HandleCategory.sqf
    -------------------------------
    Fired when:
    - User clicks a category icon
    - User types in the search box
*/
params [["_mode", "CategoryChanged"]];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _ctrlCat    = _display displayCtrl 456070;
private _ctrlSearch = _display displayCtrl 456022;
private _ctrlList   = _display displayCtrl 456020;

// 1. Get State
private _category = _ctrlCat lbData (lbCurSel _ctrlCat);
if (_category == "") then { _category = "PRIMARY"; };

private _searchText = toLower (ctrlText _ctrlSearch);

// 2. Fetch Base Items
private _items = [_category] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ScrapeConfig.sqf");

// 3. Filter and Sort
private _filtered = [];
private _factionCamo = missionNamespace getVariable ["PXG_Builder_CurrentCamo", ""];
private _tokens = (toLower _searchText) splitString " ";

{
    private _name = _x select 0;
    private _class = _x select 1;
    private _pic = _x select 2;
    private _lowerName = toLower _name;
    private _lowerClass = toLower _class;
    
    // Tokenized Search (All tokens must match)
    private _match = true;
    {
        if (_lowerName find _x == -1 && _lowerClass find _x == -1) exitWith { _match = false; };
    } forEach _tokens;

    if (_match) then {
        private _priority = 0;
        if (_factionCamo != "" && (_lowerName find (toLower _factionCamo) > -1)) then { _priority = 10; };
        _filtered pushBack [_priority, _name, _class, _pic];
    };
} forEach _items;


// Sort by Priority (Descending)
_filtered sort false;

// 4. Update Main Item List
lbClear _ctrlList;
{
    private _idx = _ctrlList lbAdd (_x select 1);
    _ctrlList lbSetPicture [_idx, _x select 3];
    _ctrlList lbSetData [_idx, _x select 2]; // ClassName
    if ((_x select 0) > 0) then { _ctrlList lbSetColor [_idx, [0.4, 0.8, 0.4, 1]]; };
} forEach _filtered;

// 5. Update Slot Manager (Column 3)
private _ctrlSlots = _display displayCtrl 456080;
lbClear _ctrlSlots;

switch (_category) do {
    case "PRIMARY": {
        { 
            private _idx = _ctrlSlots lbAdd (_x select 0); 
            _ctrlSlots lbSetData [_idx, _x select 1];
        } forEach [["Optic Slot", "optic"], ["Muzzle Slot", "muzzle"], ["Pointer Slot", "acc"], ["Bipod Slot", "bipod"]];
    };
    case "UNIFORM";
    case "VEST";
    case "BACKPACK": {
        {
            private _idx = _ctrlSlots lbAdd (_x select 0);
            _ctrlSlots lbSetData [_idx, _x select 1];
        } forEach [["Medical", "medic"], ["Ammo", "ammo"], ["Grenades", "grenade"], ["Misc", "misc"]];
    };
};

if (lbSize _ctrlList > 0) then { _ctrlList lbSetCurSel 0; };

