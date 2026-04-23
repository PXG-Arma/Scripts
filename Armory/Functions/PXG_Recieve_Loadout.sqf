params["_side","_faction","_variant", "_loadout", ["_scope", "default"], ["_weaponInput", "default"]];

// Decode weapon input (could be "classname|groupname")
_weaponArray = _weaponInput splitString "|";
_weapon = if (count _weaponArray > 0) then { _weaponArray select 0 } else { "" };
_weaponGroupInput = if (count _weaponArray > 1) then { _weaponArray select 1 } else { "" };
// Split variant name to get era and camopattern 
_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;
_variantCamo = _variantArray #0;

// Path for uniform script 
_uniformPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\uniforms_" + _variantCamo + ".sqf";

// Path for weapon script 
_weaponsPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\weapons_" + _variantCamo + ".sqf";

// Path for ammo script 
_ammoPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\ammo_" + _variantCamo + ".sqf";

// Path for gear script
_gearPath = "Scripts\Factions\" + _faction + "\" + _variantEra + "\gear_" + _variantCamo + ".sqf";

// removes all items from current loadout
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;

// Set ACE permissions 
[_side, _faction, _variant, _loadout] call compile preprocessFile "scripts\Armory\Functions\PXG_Set_ACEPerms.sqf";

// Give Uniforms
[_side, _faction, _variant, _loadout] call compile preprocessFile _uniformPath;

// --- MODULAR WEAPONS RESOLUTION ---

// 1. Resolve Role Group (SLOTGROUP) for lookup logic
_group = [nil, _faction, _variant, _loadout, "SLOTGROUP"] call compile preprocessfile _weaponsPath;

// 2. Resolve Primary Weapon
_finalWeapon = _weapon;
_finalGroup = _weaponGroupInput;

if (_finalWeapon == "default" || _finalWeapon == "") then {
    _lookupValue = _loadout;
    if (!isNil "_group" && {_group != ""}) then { _lookupValue = _group };

    // Get first item from list
    _list = [nil, _faction, _variant, _lookupValue, "WEAPASSIGN"] call compile preprocessfile _weaponsPath;
    if (!isNil "_list" && { _list isEqualType [] } && { count _list > 0 }) then {
        _rawWeapon = _list # 0;
        // Expand if it's a group name
        if (isClass (configFile >> "CfgWeapons" >> _rawWeapon)) then {
            _finalWeapon = _rawWeapon;
            _finalGroup = ""; // No group association
        } else {
            _groupGuns = [nil, _faction, _variant, _rawWeapon, "GUNGROUP"] call compile preprocessfile _weaponsPath;
            if (!isNil "_groupGuns" && { _groupGuns isEqualType [] } && { count _groupGuns > 0 }) then { 
                _finalWeapon = _groupGuns # 0;
                _finalGroup = _rawWeapon; // Remember group name implicitly!
            };
        };
    };
};

// 2b. Resolve Handgun (role-specific first, fall back to SLOTGROUP)
_handgun = [nil, _faction, _variant, _loadout, "SECONDARY", "", "", _group] call compile preprocessfile _weaponsPath;
if (isNil "_handgun" || { _handgun == "" }) then {
    _handgun = [nil, _faction, _variant, _group, "SECONDARY", "", "", _group] call compile preprocessfile _weaponsPath;
};
_launcher = [nil, _faction, _variant, _loadout, "LAUNCHER"] call compile preprocessfile _weaponsPath;



// 3. Resolve Attachments for Primary (Smart Lookup)
_attachments = [nil, _faction, _variant, _loadout, "ATTACHMENTS", _finalWeapon, _finalGroup, _group] call compile preprocessfile _weaponsPath;

// If no specific attachments for this CLASSNAME, check for its group standard
if (isNil "_attachments" || { !(_attachments isEqualType []) } || { count _attachments == 0 } || { (_attachments joinString "") == "" }) then {
    if (_finalGroup != "") then {
        _attachments = [nil, _faction, _variant, _loadout, "ATTACHMENTS", _finalGroup, _finalGroup, _group] call compile preprocessfile _weaponsPath;
    };
};

// --- APPLY WEAPONS ---

if (_finalWeapon != "") then {
    player addWeapon _finalWeapon;
    // Apply standard attachments
    if (!isNil "_attachments") then {
        { if (_x != "") then { player addPrimaryWeaponItem _x } } forEach _attachments;
    };
};

if (!isNil "_handgun" && {_handgun != ""}) then { player addWeapon _handgun };
if (!isNil "_launcher") then { 
	_launcherClass = "";
	_launcherItems = [];

	if (_launcher isEqualType []) then {
		_launcherClass = _launcher select 0;
		_launcherItems = _launcher select 1;
	} else {
		_launcherClass = _launcher;
	};

	if (_launcherClass != "") then {
		player addWeapon _launcherClass;
		{ if (_x != "") then { player addSecondaryWeaponItem _x } } forEach _launcherItems;
	};
};

// 4. Apply Scope override
if (_scope == "ironsights") then {
    // Strip any existing optic — give clean iron sights
    {
        _category = (_x call BIS_fnc_itemType);
        if (_category select 1 == "AccessorySights") then { player removePrimaryWeaponItem _x };
    } forEach (primaryWeaponItems player);
} else {
    if (_scope != "default" && _scope != "") then {
        // Remove existing optic and apply chosen scope
        {
            _category = (_x call BIS_fnc_itemType);
            if (_category select 1 == "AccessorySights") then { player removePrimaryWeaponItem _x };
        } forEach (primaryWeaponItems player);
        player addPrimaryWeaponItem _scope;
    };
};

// Give Ammo (handled after weapons so magazines can be matched)
[_side, _faction, _variant, _loadout] call compile preprocessFile _ammoPath;

// Give radios
[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\radios.sqf";

// Give common gear
[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\gear.sqf";

// Give Specific gear
[_side, _faction, _variant, _loadout] call compile preprocessFile _gearPath;

// Give medical
[_side, _faction, _variant, _loadout] call compile preprocessFile "Scripts\Factions\common\medical.sqf";

// configure radios
[_side, _faction, _variant, _loadout] call compile preprocessFile "scripts\Armory\Functions\PXG_Configure_RadioChannels.sqf";
