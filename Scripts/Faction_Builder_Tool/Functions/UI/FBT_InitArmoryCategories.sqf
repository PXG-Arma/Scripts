/*
    FBT_InitArmoryCategories.sqf
    -------------------------------
    Populates the vertical icon sidebar in the Armory Right Panel.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _ctrl = _display displayCtrl 456070;
lbClear _ctrl;

private _path = "\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\";

private _categories = [
    ["Primary Weapons", _path + "primaryweapon_ca.paa", "PRIMARY"],
    ["Launchers", _path + "secondaryweapon_ca.paa", "LAUNCHER"],
    ["Handguns", _path + "handgun_ca.paa", "HANDGUN"],
    ["Uniforms", _path + "uniform_ca.paa", "UNIFORM"],
    ["Vests", _path + "vest_ca.paa", "VEST"],
    ["Backpacks", _path + "backpack_ca.paa", "BACKPACK"],
    ["Headgear", _path + "headgear_ca.paa", "HEADGEAR"],
    ["Goggles", _path + "goggles_ca.paa", "GOGGLES"],
    ["Night Vision", _path + "nvgs_ca.paa", "NVG"],
    ["Binoculars", _path + "binoculars_ca.paa", "BINOC"],
    ["Inventory Items", _path + "map_ca.paa", "ITEMS"]
];

{
    private _idx = _ctrl lbAdd ""; // Label is empty to show icon only
    _ctrl lbSetPicture [_idx, _x select 1];
    _ctrl lbSetData [_idx, _x select 2]; // Store category tag
    _ctrl lbSetTooltip [_idx, _x select 0];
    
    // Aesthetic: Muted color for static icons (Opaque for visibility)
    _ctrl lbSetPictureColor [_idx, [1, 1, 1, 1]];
    _ctrl lbSetPictureColorSelected [_idx, [0.29, 0.42, 0.42, 1]]; // Teal highlight on selection
} forEach _categories;

_ctrl lbSetCurSel 0;
