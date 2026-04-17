/*
    PXG_Builder_ApplyGear.sqf
    -------------------------------
    Fired when: User clicks an item in the middle browser.
*/
params ["_ctrl", "_index"];
disableSerialization;

private _className = _ctrl lbData _index;
if (_className == "") exitWith {};

private _display = findDisplay 456000;
private _ctrlCat = _display displayCtrl 456070;
private _category = _ctrlCat lbData (lbCurSel _ctrlCat);

// 1. Get States
private _activeSlot = _display getVariable ["PXG_Builder_ActiveSlot", ""];
private _dummy = missionNamespace getVariable ["PXG_Builder_Preview_Unit", objNull];
private _amount = parseNumber (ctrlText (_display displayCtrl 456081));
if (_amount <= 0) then { _amount = 1; };

// 2. Variant Folding Check (Handover to Variant Selector)
if (ctrlIDC _ctrl == 456020 && _category in ["UNIFORM", "VEST", "HEADGEAR"]) then {
    private _vars = missionNamespace getVariable ["PXG_Builder_VariantsCache", createHashMap];
    private _catTable = _vars getOrDefault [_category, createHashMap];
    if (_className in _catTable) exitWith {
        _this execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleVariants.sqf";
    };
};

// 3. Identify Category/Class and Update Mass UI
[] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_CalcMass.sqf";


// 3. Apply Physical Change
if (_activeSlot == "") then {
    // Normal Category Equip (Usually 1)
    switch (_category) do {
        case "PRIMARY":   { _dummy addWeaponGlobal _className; _dummy selectWeapon _className; };
        case "LAUNCHER":  { _dummy addWeaponGlobal _className; };
        case "HANDGUN":   { _dummy addWeaponGlobal _className; };
        case "UNIFORM":   { _dummy forceAddUniform _className; };
        case "VEST":      { _dummy addVest _className; };
        case "BACKPACK":  { _dummy addBackpackGlobal _className; };
        case "HEADGEAR":  { _dummy addHeadgear _className; };
        case "GOGGLES":   { _dummy addGoggles _className; };
        case "NVG":       { _dummy linkItem _className; };
        case "BINOC":     { _dummy addWeaponGlobal _className; };
        case "ITEMS":     { for "_i" from 1 to _amount do { _dummy addItem _className; }; };
    };
} else {
    // Slot-Specific (Attachments or Contents)
    if (_category in ["PRIMARY", "HANDGUN"]) then {
        // Attachments usually only 1
        if (_category == "PRIMARY") then { _dummy addPrimaryWeaponItem _className; };
        if (_category == "HANDGUN") then { _dummy addHandgunItem _className; };
    } else {
        // Bulk Contents (Mags, Medical, etc.)
        for "_i" from 1 to _amount do {
            switch (_category) do {
                case "UNIFORM":  { _dummy addItemToUniform _className; };
                case "VEST":     { _dummy addItemToVest _className; };
                case "BACKPACK": { _dummy addItemToBackpack _className; };
            };
        };
    };
};


// 3. Update Master Hash
private _masterHash = missionNamespace getVariable ["PXG_Builder_MasterHash", createHashMap];
private _armory = _masterHash getOrDefault ["Armory", createHashMap];

private _tree = _display displayCtrl 456010;
private _path = tvCurSel _tree;
if (count _path > 0) then {
    private _roleId = _tree tvData _path;
    private _roleData = _armory getOrDefault [_roleId, createHashMap];
    
    if (_activeSlot == "") then {
        _roleData set [_category, _className];
    } else {
        // Use a composite key or nested hash for attachments
        private _key = _category + "_" + _activeSlot;
        _roleData set [_key, _className];
    };
    _armory set [_roleId, _roleData];
};


diag_log format ["[PXG Builder] Applied %1 to slot %2", _className, _category];
