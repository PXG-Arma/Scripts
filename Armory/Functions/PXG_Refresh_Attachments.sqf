params["_control", "_selectedIndex"];

if (_selectedIndex == -1) exitWith {
	ctrlSetText [431703, ""];
	ctrlSetText [431704, ""];
	ctrlSetText [431705, ""];
};

// Decode classname and group association
_weaponData = _control lbData _selectedIndex;
_weaponArray = _weaponData splitString "|";
if (count _weaponArray == 0) exitWith {
	ctrlSetText [431703, ""];
	ctrlSetText [431704, ""];
	ctrlSetText [431705, ""];
};

_weapon = _weaponArray select 0;
_weaponGroup = if (count _weaponArray > 1) then { _weaponArray select 1 } else { "" };

// Get faction and variant from tree
_indexFaction = tvCurSel 431501;
_faction = tvText [431501, [_indexFaction select 0]];
_variant = tvText [431501, _indexFaction];
_variantArray = _variant splitString " ";
_variantEra = if (count _variantArray > 1) then { _variantArray select 1 } else { "" };
_variantCamo = if (count _variantArray > 0) then { _variantArray select 0 } else { "" };
_weaponsPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\weapons_" + _variantCamo + ".sqf";

// Get loadout data (short name/role) from tree selection
_indexLoadout = tvCurSel 431503;
_loadoutData = tvData [431503, _indexLoadout];

// Resolve Role Group (SLOTGROUP) for filtering
_roleGroup = [nil, _faction, _variant, _loadoutData, "SLOTGROUP"] call compile preprocessfile _weaponsPath;

// 1. Try to fetch attachments using the CLASSNAME directly
_attachments = [nil, _faction, _variant, _loadoutData, "ATTACHMENTS", _weapon, _weaponGroup, _roleGroup] call compile preprocessfile _weaponsPath;

// 2. SMART LOOKUP: If no specific attachments, use the dynamic GROUP this weapon belongs to
if (isNil "_attachments" || { !(_attachments isEqualType []) } || { count _attachments == 0 } || { (_attachments joinString "") == "" }) then {
	if (_weaponGroup != "") then {
		// Fetch attachments for the resolved weapon group name instead of the classname
		_attachments = [nil, _faction, _variant, _loadoutData, "ATTACHMENTS", _weaponGroup, _weaponGroup, _roleGroup] call compile preprocessfile _weaponsPath;
	};
};

// 3. Update Preview Images
if (!isNil "_attachments" && { _attachments isEqualType [] }) then {
    _muzzle = if (count _attachments > 0) then { _attachments select 0 } else { "" };
    _rail = if (count _attachments > 1) then { _attachments select 1 } else { "" };
    _under = if (count _attachments > 2) then { _attachments select 2 } else { "" };

    _muzzlePic = if (_muzzle != "") then { getText (configFile >> "CfgWeapons" >> _muzzle >> "picture") } else { "" };
    _railPic = if (_rail != "") then { getText (configFile >> "CfgWeapons" >> _rail >> "picture") } else { "" };
    _underPic = if (_under != "") then { getText (configFile >> "CfgWeapons" >> _under >> "picture") } else { "" };

    ctrlSetText [431703, _muzzlePic];
    ctrlSetText [431704, _railPic];
    ctrlSetText [431705, _underPic];
} else {
    ctrlSetText [431703, ""];
    ctrlSetText [431704, ""];
    ctrlSetText [431705, ""];
};
