// Get selected faction and role from tree lists
_indexFaction = tvCurSel 431501;
_faction = tvText [431501, [_indexFaction select 0]];
_variant = tvText [431501, _indexFaction];
_indexLoadout = tvCurSel 431503;

// Prevent error if no selection
if (count _indexLoadout < 2) exitWith {
	lbClear 431504;
};

// Get loadout data (short name)
_loadoutData = tvData [431503, _indexLoadout];

// Split variant name to get era and camopattern 
_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;
_variantCamo = _variantArray #0;

// Build path for weapon script 
_weaponsPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\weapons_" + _variantCamo + ".sqf";

// Get role group (if it exists)
_group = [nil, _faction, _variant, _loadoutData, "SLOTGROUP"] call compile preprocessfile _weaponsPath;

// Call faction weapon script in "WEAPASSIGN" mode for the specific role first
_rawGuns = [nil, _faction, _variant, _loadoutData, "WEAPASSIGN"] call compile preprocessfile _weaponsPath;
if (isNil "_rawGuns" || { !(_rawGuns isEqualType []) }) then { _rawGuns = []; };

// If the role has no specific list, fall back to the group's weapon list
if (count _rawGuns == 0 && {!isNil "_group"} && {_group != ""}) then {
	_rawGuns = [nil, _faction, _variant, _group, "WEAPASSIGN"] call compile preprocessfile _weaponsPath;
	if (isNil "_rawGuns" || { !(_rawGuns isEqualType []) }) then { _rawGuns = []; };
};

// Clear weapon listbox and previews
lbClear 431504;
ctrlSetText [431701, ""];
ctrlSetText [431702, ""];

// Recursive Expansion: Resolve weapon groups into classnames
_guns = [];
{
	if (isClass (configFile >> "CfgWeapons" >> _x)) then {
		_guns pushBack [_x, ""]; // Individual classname, no group association
	} else {
		// It's a group name, ask faction script for the weapons in this group
		_groupName = _x;
		_groupGuns = [nil, _faction, _variant, _groupName, "GUNGROUP"] call compile preprocessfile _weaponsPath;
		if (!isNil "_groupGuns" && { _groupGuns isEqualType [] }) then { 
			{ _guns pushBack [_x, _groupName] } forEach _groupGuns;
		};
	};
} forEach _rawGuns;

// Uniquify the list (remove duplicates while preserving the order of first appearance)
_uniqueGuns = [];
_tempFull = [];
{
	if (_x isEqualType [] && {count _x > 0}) then {
		_weaponClass = _x select 0;
    	if !(_weaponClass in _uniqueGuns) then { 
			_uniqueGuns pushBack _weaponClass;
			_tempFull pushBack _x;
		};
	};
} forEach _guns;
_guns = _tempFull; // Now holds array of [_classname, _groupName]

// Determine the default weapon (first entry in the final expanded list)
_defaultWeaponData = ["", ""];
if (count _guns > 0) then {
	_defaultWeaponData = _guns select 0;
};
_defaultWeapon = _defaultWeaponData select 0;
_defaultGroup = _defaultWeaponData select 1;

// Add the standard issue weapon first
if (_defaultWeapon != "") then {
	_displayName = getText (configFile >> "CfgWeapons" >> _defaultWeapon >> "displayName");
	if (_displayName == "") then {_displayName = _defaultWeapon};

	_index = lbAdd [431504, _displayName];
	lbSetData [431504, _index, format["%1|%2", _defaultWeapon, _defaultGroup]];
	lbSetTooltip [431504, _index, _defaultWeapon];

	// Filter out the default weapon from the extra list to prevent duplicates
	_guns = _guns - [_defaultWeaponData];
};

{
	_weaponClass = _x select 0;
	_weaponGroup = _x select 1;

	// Get display name for weapon
	_displayName = getText (configFile >> "CfgWeapons" >> _weaponClass >> "displayName");
	if (_displayName == "") then {_displayName = _weaponClass};
	
	_index = lbAdd [431504, _displayName];
	lbSetData [431504, _index, format["%1|%2", _weaponClass, _weaponGroup]];
	// Add tooltip with classname
	lbSetTooltip [431504, _index, _weaponClass];
} forEach _guns;

// Memory handling
_weaponMemory = player getVariable ["PXG_Armory_Memory_Weapon", 0];
if (_weaponMemory < (lbSize 431504)) then {
	lbSetCurSel [431504, _weaponMemory];
};

// Manually trigger preview update for current selection
[ (findDisplay 431234 displayCtrl 431504), (lbCurSel 431504), 431701 ] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Update_Preview.sqf';

// Manually trigger scope refresh for selection
call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Scopes.sqf';

// Manually trigger attachments refresh for selection
[ (findDisplay 431234 displayCtrl 431504), (lbCurSel 431504) ] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Attachments.sqf';
