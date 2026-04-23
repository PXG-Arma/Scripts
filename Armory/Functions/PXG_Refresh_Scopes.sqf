// Get selected weapon and faction
_indexWeapon = lbCurSel 431504;
_selectedWeaponData = lbData [431504, _indexWeapon];

// Decode classname and group association
_weaponArray = _selectedWeaponData splitString "|";
if (count _weaponArray == 0) exitWith { lbClear 431505; }; // Exit if no valid data

_selectedWeapon = _weaponArray select 0;
_selectedGroup = if (count _weaponArray > 1) then { _weaponArray select 1 } else { "" };

_indexFaction = tvCurSel 431501;
_faction = tvText [431501, [_indexFaction select 0]];
_variant = tvText [431501, _indexFaction];

// Prevent error if no selection
if (_selectedWeapon == "") exitWith {
	lbClear 431505;
};

// Split variant name to get era and camopattern 
_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;
_variantCamo = _variantArray #0;

// Build path for weapon script (now handles scopes too)
_weaponsPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\weapons_" + _variantCamo + ".sqf";

// Get loadout data (short name/role) from tree selection
_indexLoadout = tvCurSel 431503;
_loadoutData = tvData [431503, _indexLoadout];

// Get role group (if it exists) to allow for group-based filtering
_group = [nil, _faction, _variant, _loadoutData, "SLOTGROUP"] call compile preprocessfile _weaponsPath;

// Clear scope listbox
lbClear 431505;

// Check if the weapon physically supports optics (has a CowsSlot)
_hasOpticSlot = isClass (configFile >> "CfgWeapons" >> _selectedWeapon >> "WeaponSlotsInfo" >> "CowsSlot");

// Only add Iron Sights option if the gun can actually mount scopes
if (_hasOpticSlot) then {
	_ironIndex = lbAdd [431505, "Iron Sights"];
	lbSetData [431505, _ironIndex, "ironsights"];
	lbSetTooltip [431505, _ironIndex, "No optic - Iron Sights only"];
};

// Call faction weapon script in "SCOPES" mode to get allowed optics
// We pass classname, weapon group, AND role group
_scopes = [nil, _faction, _variant, _loadoutData, "SCOPES", _selectedWeapon, _selectedGroup, _group] call compile preprocessfile _weaponsPath;
if (isNil "_scopes" || { !(_scopes isEqualType []) }) then { _scopes = []; };

// Populate allowed optics returned by faction script
{
	// Get display name for scope
	_displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
	if (_displayName == "") then {_displayName = _x};
	
	_index = lbAdd [431505, _displayName];
	lbSetData [431505, _index, _x];
	// Add tooltip with classname
	lbSetTooltip [431505, _index, _x];
} forEach _scopes;

// Memory handling
_scopeMemory = player getVariable ["PXG_Armory_Memory_Scope", 0];
if (_scopeMemory < (lbSize 431505)) then {
	lbSetCurSel [431505, _scopeMemory];
};

// Manually trigger preview update for current selection
[ (findDisplay 431234 displayCtrl 431505), (lbCurSel 431505), 431702 ] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Update_Preview.sqf';
