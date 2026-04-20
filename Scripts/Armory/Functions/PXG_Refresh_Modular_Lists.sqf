#include "..\..\macros.hpp"
/*
    PXG_Refresh_Modular_Lists.sqf
    ----------------------------
    Handles the population of the modular weapon and sight listboxes using hierarchical discovery.
    Input: [_ctrl, _path] (from onTreeSelChanged) OR [_ctrl, _index] (from onLBSelChanged) OR [false] (to hide)
*/

params ["_input", ["_pathOrIndex", []]];

private _display = findDisplay IDD_ARMORY;
if (isNull _display) exitWith {};

// --- 1. COLLECT MODULAR CONTROLS ---
private _modularIDCs = [
    IDC_ARMORY_MODULAR_PANEL, IDC_ARMORY_MODULAR_HEADER, 
    IDC_ARMORY_WEAPON_TEXT, IDC_ARMORY_WEAPON_LIST,
    IDC_ARMORY_ATTACHMENT_LIST,
    IDC_ARMORY_PREVIEW_PICTURE, IDC_ARMORY_PREVIEW_BACKGROUND,
    IDC_ARMORY_SIGHT_ICON, IDC_ARMORY_UNDERBARREL_ICON,
    IDC_ARMORY_GRIP_ICON, IDC_ARMORY_MUZZLE_ICON
];
private _modularControls = _modularIDCs apply { _display displayCtrl _x };

// --- 2. HANDLE HIDE REQUEST ---
if (_input isEqualType false && {!_input}) exitWith {
    [_display, false, _modularIDCs] execVM "Scripts\Misc\PXG_Handle_UI_Expansion.sqf";
};

private _ctrlWeaponList = _display displayCtrl IDC_ARMORY_WEAPON_LIST;
private _weaponUpdateOnly = (_input isEqualType controlNull && { _input == _ctrlWeaponList });
private _treeSelection = tvCurSel IDC_ARMORY_LOADOUT_TREE;

// Hide if no role is selected (e.g. category header selected)
if (count _treeSelection < 2) exitWith {
    [_display, false, _modularIDCs] execVM "Scripts\Misc\PXG_Handle_UI_Expansion.sqf";
};

private _loadoutID = tvData [IDC_ARMORY_LOADOUT_TREE, _treeSelection];
private _indexCamo = lbCurSel IDC_ARMORY_CAMO_LIST;
private _variantData = lbData [IDC_ARMORY_CAMO_LIST, _indexCamo];
private _metadata = call compile _variantData;
private _basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";

private _discoveryScript = "Scripts\Armory\Functions\PXG_Get_Modular_Options.sqf";

// --- 3. REFRESH WEAPONS (Role Changed) ---
if (!_weaponUpdateOnly) then {
    private _roleGroup = [_basePath, _loadoutID, "SLOTGROUP", _metadata] call compile preprocessFile _discoveryScript;
    private _rawOptions = [_basePath, _loadoutID, "WEAPASSIGN", _metadata] call compile preprocessFile _discoveryScript;
    
    // Fallback to group if role has no specific options
    if (count _rawOptions == 0 && {_roleGroup != ""}) then {
        _rawOptions = [_basePath, _roleGroup, "WEAPASSIGN", _metadata] call compile preprocessFile _discoveryScript;
    };

    if (count _rawOptions > 0) then {
        lbClear _ctrlWeaponList;
        {
            private _option = _x;
            if (isClass (configFile >> "CfgWeapons" >> _option)) then {
                private _displayName = getText (configFile >> "CfgWeapons" >> _option >> "displayName");
                private _index = _ctrlWeaponList lbAdd _displayName;
                _ctrlWeaponList lbSetData [_index, format["%1|%2", _option, ""]];
                _ctrlWeaponList lbSetPicture [_index, getText (configFile >> "CfgWeapons" >> _option >> "picture")];
            } else {
                private _groupGuns = [_basePath, _option, "GUNGROUP", _metadata] call compile preprocessFile _discoveryScript;
                {
                    private _displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
                    private _index = _ctrlWeaponList lbAdd _displayName;
                    _ctrlWeaponList lbSetData [_index, format["%1|%2", _x, _option]]; 
                    _ctrlWeaponList lbSetPicture [_index, getText (configFile >> "CfgWeapons" >> _x >> "picture")];
                } forEach _groupGuns;
            };
        } forEach _rawOptions;

        if (lbSize _ctrlWeaponList > 0) then {
            _ctrlWeaponList lbSetCurSel 0;
            [_display, true, _modularIDCs] execVM "Scripts\Misc\PXG_Handle_UI_Expansion.sqf";
        } else {
            [_display, false, _modularIDCs] execVM "Scripts\Misc\PXG_Handle_UI_Expansion.sqf";
        };
    } else {
        [_display, false, _modularIDCs] execVM "Scripts\Misc\PXG_Handle_UI_Expansion.sqf";
    };
} else {
    // --- 4. REFRESH ATTACHMENTS (Weapon Selected or Category Changed) ---
    private _selectionData = _ctrlWeaponList lbData (lbCurSel _ctrlWeaponList);
    private _split = _selectionData splitString "|";
    if (count _split < 1) exitWith {};
    
    private _selectedWeapon = _split select 0;
    private _weaponGroup = if (count _split > 1) then { _split select 1 } else { "" };
    private _roleGroup = [_basePath, _loadoutID, "SLOTGROUP", _metadata] call compile preprocessFile _discoveryScript;
    
    // Resolve Active Category
    private _activeCategory = _display getVariable ["PXG_Armory_Active_Attachment_Slot", "optic"];
    private _options = [];

    switch (_activeCategory) do {
        case "optic": {
             _options = [_basePath, _loadoutID, "SCOPES", _metadata, _selectedWeapon, _weaponGroup, _roleGroup] call compile preprocessFile _discoveryScript;
        };
        case "muzzle";
        case "acc";
        case "bipod": {
            // Fetch standards for the selected weapon
            // Correct mapping: _basePath, _loadout, _mode, _metadata, _weapon
            private _standards = [_basePath, _loadoutID, "ATTACHMENTS", _metadata, _selectedWeapon] call compile preprocessFile _discoveryScript;
            
            // Standards format: [muzzle, pointer, bipod]
            private _standardItem = "";
            if (typeName _standards == "ARRAY" && {count _standards >= 3}) then {
                _standardItem = switch (_activeCategory) do {
                    case "muzzle": { _standards select 0 };
                    case "acc":    { _standards select 1 };
                    case "bipod":  { _standards select 2 };
                    default { "" };
                };
            };

            if (_standardItem != "") then { _options pushBack _standardItem; };
            // Future: Add discovery for optional/alternative attachments here
        };
    };
    
    private _ctrlAttachmentList = _display displayCtrl IDC_ARMORY_ATTACHMENT_LIST;
    lbClear _ctrlAttachmentList;
    {
        private _className = _x;
        if (isClass (configFile >> "CfgWeapons" >> _className)) then {
            private _displayName = getText (configFile >> "CfgWeapons" >> _className >> "displayName");
            private _index = _ctrlAttachmentList lbAdd _displayName;
            _ctrlAttachmentList lbSetData [_index, _className];
            _ctrlAttachmentList lbSetPicture [_index, getText (configFile >> "CfgWeapons" >> _className >> "picture")];
        };
    } forEach _options;
    
    if (lbSize _ctrlAttachmentList > 0) then { 
        _ctrlAttachmentList lbSetCurSel 0; 
    };
    
    // --- 5. UI FEEDBACK (Highlight Active Category) ---
    private _icons = [
        ["optic", IDC_ARMORY_SIGHT_ICON],
        ["bipod", IDC_ARMORY_UNDERBARREL_ICON],
        ["acc", IDC_ARMORY_GRIP_ICON],
        ["muzzle", IDC_ARMORY_MUZZLE_ICON]
    ];

    {
        _x params ["_catName", "_idc"];
        private _ctrl = _display displayCtrl _idc;
        if (_catName == _activeCategory) then {
            _ctrl ctrlSetBackgroundColor [0.29, 0.42, 0.42, 1]; // Active Highlight
        } else {
            _ctrl ctrlSetBackgroundColor [0, 0, 0, 0]; // Transparent
        };
    } forEach _icons;

    // Trigger Preview Update
    call compile preprocessFile "Scripts\Armory\Functions\PXG_Update_Preview.sqf";
};
