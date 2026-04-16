#include "..\..\macros.hpp"

params [["_vehicle", objNull]];

private _display = uiNamespace getVariable ["PXG_Cam_Active_Display", displayNull];
if (isNull _display) exitWith {};

private _ctrlGroup = _display displayCtrl IDC_MOTORPOOL_PYLON_CONTAINER;
if (isNull _ctrlGroup) exitWith {};

// Determine target vehicle if not passed
if (isNull _vehicle) then {
    _vehicle = player getVariable ["PXG_Motorpool_Active_Vehicle", objNull];
    if (isNull _vehicle) then {
        _vehicle = missionNamespace getVariable ["PXG_Cam_TargetObj", objNull];
    };
};

if (isNull _vehicle) exitWith {};

// Check for pylons
private _pylonInfo = getAllPylonsInfo _vehicle;
private _hasPylons = (count _pylonInfo > 0);

// Toggle Visibility
(_display displayCtrl IDC_MOTORPOOL_PYLON_PANEL) ctrlShow _hasPylons;
(_display displayCtrl 461706) ctrlShow _hasPylons; // Header
_ctrlGroup ctrlShow _hasPylons;

if (!_hasPylons) exitWith {};

// Ensure internal state is reset to prevent control doubling if called rapidly
{
	if (ctrlParentControlsGroup _x == _ctrlGroup) then { ctrlDelete _x; };
} forEach (allControls _display);

// LOCK: Prevent EH triggers during population
missionNamespace setVariable ["PXG_Motorpool_Pylon_Lock", true];

// Dynamic Generation Loop
private _yPos = 0.01 * safezoneH;
private _rowHeight = 0.055 * safezoneH;

{
    _x params ["_pylonIdx", "_pylonName", "_pylonTurret", "_pylonMag", "_pylonAmmo"];
    
	// Get Display Name from CfgVehicles
    private _displayName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylonName >> "displayName");
    if (_displayName == "") then { _displayName = _pylonName; };

	// Smart Parsing for Display Name
	private _cleanName = _displayName;
	// Remove redundant "pylon" (case-insensitive check)
	private _pylonCheck = _cleanName find "pylon";
	if (_pylonCheck != -1) then {
		_cleanName = _cleanName select [(_pylonCheck + 5)];
	};
	// Clean up underscores and spaces
	_cleanName = _cleanName splitString "_" joinString " ";
	_cleanName = _cleanName splitString " " joinString " "; // Reduce double spaces
	if (_cleanName == "") then { _cleanName = _pylonName; };

	// 1. Create Label (Pylon Index + Cleaned Name) with Padding
	private _ctrlLabel = _display ctrlCreate ["PxgGuiRscText", -1, _ctrlGroup];
	_ctrlLabel ctrlSetPosition [0.010 * safezoneW, _yPos, 0.16 * safezoneW, 0.02 * safezoneH]; // Move right for padding
	_ctrlLabel ctrlSetText (format ["%1. %2", _pylonIdx, _cleanName]);
	_ctrlLabel ctrlSetTextColor [1, 0.8, 0, 1];
	_ctrlLabel ctrlCommit 0;

	// 2. Create Combo (Weapon Selection) - Align with label padding
	private _ctrlCombo = _display ctrlCreate ["PxgGuiRscCombo", 461800 + _pylonIdx, _ctrlGroup];
	_ctrlCombo ctrlSetPosition [0.010 * safezoneW, _yPos + 0.022 * safezoneH, 0.155 * safezoneW, 0.025 * safezoneH];
	_ctrlCombo ctrlCommit 0;

	// Populate Combo with Compatible Magazines
	private _compatible = _vehicle getCompatiblePylonMagazines _pylonIdx;
	
	// Add Empty option for stripping pylons
	private _emptyIdx = _ctrlCombo lbAdd "--- Empty ---";
	_ctrlCombo lbSetData [_emptyIdx, ""];
	
	private _currentSelIdx = 0;
	{
		private _mDisplayName = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
		private _mIcon = getText (configFile >> "CfgMagazines" >> _x >> "picture");
		private _mDesc = getText (configFile >> "CfgMagazines" >> _x >> "descriptionShort");
		
		// Warhead Type Detection
		private _ammoClass = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
		private _warhead = getText (configFile >> "CfgAmmo" >> _ammoClass >> "warheadName");
		if (_warhead == "") then { _warhead = getText (configFile >> "CfgMagazines" >> _x >> "displayNameShort"); };
		
		// Append warhead info if found with smart redundancy check
		if (_warhead != "") then {
			// Remove the warhead info from the base name if it exists there to avoid "Hellfire HE [HE]"
			private _nameLower = toLower _mDisplayName;
			private _warLower = toLower _warhead;
			private _findIdx = _nameLower find _warLower;
			
			if (_findIdx != -1) then {
				// Remove the substring and clean up spaces
				private _part1 = _mDisplayName select [0, _findIdx];
				private _part2 = _mDisplayName select [(_findIdx + count _warhead)];
				_mDisplayName = trim (_part1 + _part2);
				// Clean up any double spaces or leftover brackets from the original name
				_mDisplayName = _mDisplayName splitString "()[]" joinString "";
				_mDisplayName = trim (_mDisplayName splitString " " joinString " ");
			};
			
			_mDisplayName = format ["%1 [%2]", _mDisplayName, _warhead];
		};

		private _idx = _ctrlCombo lbAdd _mDisplayName;
		_ctrlCombo lbSetData [_idx, _x];
		_ctrlCombo lbSetPicture [_idx, _mIcon];
		_ctrlCombo lbSetTooltip [_idx, _mDesc];
		
		if (_x == _pylonMag) then { _currentSelIdx = _idx; };
	} forEach _compatible;

	_ctrlCombo lbSetCurSel _currentSelIdx;

	// Add Event Handler for instant application
	_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
		params ["_ctrl", "_index"];
		// Pre-set some protective flags to avoid recursive calls if we refresh panel
		if (missionNamespace getVariable ["PXG_Motorpool_Pylon_Lock", false]) exitWith {};
		
		private _mag = _ctrl lbData _index;
		private _pylonIdx = (ctrlIDC _ctrl) - 461800;
		[_pylonIdx, _mag] call compile preprocessFile "Scripts\Motorpool\Functions\PXG_Motorpool_Pylon_Apply.sqf";
	}];

	_yPos = _yPos + _rowHeight;
} forEach _pylonInfo;

// UNLOCK
missionNamespace setVariable ["PXG_Motorpool_Pylon_Lock", false];
