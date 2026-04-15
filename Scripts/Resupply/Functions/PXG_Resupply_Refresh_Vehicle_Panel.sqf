#include "..\..\macros.hpp"

// Define new Panel IDCs for easier reference
#define IDC_PANEL_BG 451700
#define IDC_PANEL_NAME 451701
#define IDC_PANEL_PIC 451702
#define IDC_PANEL_CAP 451703
#define IDC_PANEL_LIST 451704
#define IDC_PANEL_BTN 451705
#define IDC_PANEL_HEADER 451706
#define IDC_PANEL_LABEL 451707

private _indexSpawn = lbCurSel IDC_RESUPPLY_SPAWNPOINTS;
if (_indexSpawn == -1) exitWith {
	{ (findDisplay IDD_RESUPPLY displayCtrl _x) ctrlShow false } forEach [IDC_PANEL_BG, IDC_PANEL_NAME, IDC_PANEL_PIC, IDC_PANEL_CAP, IDC_PANEL_LIST, IDC_PANEL_BTN, IDC_PANEL_HEADER, IDC_PANEL_LABEL];
};

private _spawnMaster = player getVariable ["PXG_Resupply_Master", objNull];
if (isNull _spawnMaster) exitWith {};

private _spawnLocationObj = (synchronizedObjects _spawnMaster) select _indexSpawn;
private _spawnPos = getPosATL _spawnLocationObj;

// Detect vehicle
private _nearVehicles = nearestObjects [_spawnPos, ["LandVehicle", "Air", "Ship", "Slingload_base_F"], 5];

if (count _nearVehicles == 0) exitWith {
	{ (findDisplay IDD_RESUPPLY displayCtrl _x) ctrlShow false } forEach [IDC_PANEL_BG, IDC_PANEL_NAME, IDC_PANEL_PIC, IDC_PANEL_CAP, IDC_PANEL_LIST, IDC_PANEL_BTN, IDC_PANEL_HEADER, IDC_PANEL_LABEL];
};

private _vehicle = _nearVehicles select 0;
private _display = findDisplay IDD_RESUPPLY;

// Show Panel
{ (_display displayCtrl _x) ctrlShow true } forEach [IDC_PANEL_BG, IDC_PANEL_NAME, IDC_PANEL_PIC, IDC_PANEL_CAP, IDC_PANEL_LIST, IDC_PANEL_BTN, IDC_PANEL_HEADER, IDC_PANEL_LABEL];

// Update Data
private _vName = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
private _vPicture = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "editorPreview");
if (_vPicture == "") then { _vPicture = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "picture") };

private _maxSpace = _vehicle getVariable ["ace_cargo_maxSpace", getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ace_cargo_space")];
private _remainingSpace = _vehicle getVariable ["ace_cargo_space", 0];

(_display displayCtrl IDC_PANEL_NAME) ctrlSetText _vName;
(_display displayCtrl IDC_PANEL_PIC) ctrlSetText _vPicture;

private _color = if (_remainingSpace > 0) then {"#00ff00"} else {"#ff0000"};

(_display displayCtrl IDC_PANEL_CAP) ctrlSetStructuredText parseText format [
	"<t color='%1'>%2</t> / %3", 
	_color, 
	_remainingSpace, 
	_maxSpace
];

// Load Cargo List
lbClear IDC_PANEL_LIST;
private _loadedItems = _vehicle getVariable ["ace_cargo_loaded", []];

{
	private _name = "";
	if (typeName _x == "STRING") then {
		_name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
		if (_name == "") then {_name = _x};
	} else {
		_name = _x getVariable ["ace_cargo_customName", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
		if (_name == "") then {_name = typeOf _x};
	};
	
	private _idx = lbAdd [IDC_PANEL_LIST, _name];
	lbSetData [IDC_PANEL_LIST, _idx, _name]; 
	// Storing object reference as Value if possible, but listbox data only takes strings.
	// We'll use the index to delete later.
} forEach _loadedItems;

// Save current vehicle and data to a UI variable for the delete button
_display setVariable ["PXG_Resupply_Current_Vehicle", _vehicle];
