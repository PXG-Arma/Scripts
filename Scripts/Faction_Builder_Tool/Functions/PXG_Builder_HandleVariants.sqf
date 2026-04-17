/*
    PXG_Builder_HandleVariants.sqf
    -------------------------------
    Fired when:
    - User expands a base item list
    - User manually selects a variant from the combo
*/
params ["_ctrl", "_index"];
disableSerialization;

private _display = findDisplay 456000;
private _ctrlCombo = _display displayCtrl 456023;
private _ctrlList  = _display displayCtrl 456020;
private _ctrlCat   = _display displayCtrl 456070;

private _className = _ctrl lbData _index;
private _category  = _ctrlCat lbData (lbCurSel _ctrlCat);

// 1. Fetch Variants from Cache
private _masterVar = missionNamespace getVariable ["PXG_Builder_VariantsCache", createHashMap];
private _catVar = _masterVar getOrDefault [_category, createHashMap];
private _variants = _catVar getOrDefault [_className, []]; // [[Name, Class, Pic], ...]

if (count _variants == 0) exitWith { _ctrlCombo ctrlShow false; };

// 2. Populate Combo if coming from Browser Click
if (ctrlIDC _ctrl == 456020) then {
    lbClear _ctrlCombo;
    _ctrlCombo ctrlShow true;
    
    private _stickyCamo = missionNamespace getVariable ["PXG_Builder_LastSelectedCamo", ""];
    private _bestMatch = 0;

    {
        private _idx = _ctrlCombo lbAdd (_x select 0);
        _ctrlCombo lbSetData [_idx, _x select 1];
        
        // Sticky Camo Logic: Find if variant name contains the last selected camo string
        if (_stickyCamo != "" && {toLower (_x select 0) find (toLower _stickyCamo) > -1}) then {
            _bestMatch = _idx;
        };
    } forEach _variants;

    _ctrlCombo lbSetCurSel _bestMatch;
};

// 3. Apply the Selection (Equip Dummy)
private _finalClass = _ctrlCombo lbData (lbCurSel _ctrlCombo);
if (_finalClass == "") exitWith {};

// Update Sticky Memory (Extract camo keyword from name, e.g. "Tan" from "Vest (Tan)")
private _fullName = _ctrlCombo lbText (lbCurSel _ctrlCombo);
private _keywords = ["Black", "Tan", "Coyote", "Olive", "Green", "Woodland", "Desert", "MTP", "MultiCam", "Gray", "Grey"];
{
    if (toLower _fullName find (toLower _x) > -1) exitWith {
        missionNamespace setVariable ["PXG_Builder_LastSelectedCamo", _x];
    };
} forEach _keywords;

// Trigger Apply logic for the specific variant
[_ctrlCombo, lbCurSel _ctrlCombo] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ApplyGear.sqf";
