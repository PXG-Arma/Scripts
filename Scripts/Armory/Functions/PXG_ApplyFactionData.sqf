// PXG Data-Driven Engine
// Reads Faction_Core.sqf Hashmap and applies the loadout for the specified role.
params ["_side", "_faction", "_variant", "_loadout", "_basePath"];

private _factionData = call compile preprocessFile (_basePath + "Faction_Core.sqf");
if (isNil "_factionData" || {typeName _factionData != "HASHMAP"}) exitWith {
	diag_log format ["[PXG Error] Faction_Core.sqf at %1 is invalid or missing.", _basePath];
};

private _roleData = _factionData get _loadout;
if (isNil "_roleData") then {
	// Attempt to fallback to a 'default' role if one exists, otherwise exit
	_roleData = _factionData get "default";
};

if (isNil "_roleData") exitWith {
	diag_log format ["[PXG Error] Role '%1' not found in Faction_Core.sqf, and no 'default' role exists.", _loadout];
};

// --- Clothing ---
private _uniform = _roleData getOrDefault ["uniform", ""];
if (_uniform != "") then { player forceAddUniform _uniform; };

private _vest = _roleData getOrDefault ["vest", ""];
if (_vest != "") then { player addVest _vest; };

private _backpack = _roleData getOrDefault ["backpack", ""];
if (_backpack != "") then { player addBackpack _backpack; };

private _helmet = _roleData getOrDefault ["helmet", ""];
if (_helmet != "") then { player addHeadgear _helmet; };

// --- Weapons ---
private _primaryData = _roleData getOrDefault ["primary", []];
if (count _primaryData > 0) then {
    private _gun = _primaryData select 0;
	if (_gun != "") then {
		player addWeapon _gun;
		if (count _primaryData > 1) then {
			private _attachments = _primaryData select 1;
			{ player addPrimaryWeaponItem _x; } forEach _attachments;
		};
	};
};

private _secondaryData = _roleData getOrDefault ["secondary", []];
if (count _secondaryData > 0) then {
    private _gun = _secondaryData select 0;
	if (_gun != "") then {
		player addWeapon _gun;
		if (count _secondaryData > 1) then {
			private _attachments = _secondaryData select 1;
			{ player addHandgunItem _x; } forEach _attachments;
		};
	};
};

private _launcherData = _roleData getOrDefault ["launcher", []];
if (count _launcherData > 0) then {
    private _gun = _launcherData select 0;
	if (_gun != "") then {
		player addWeapon _gun;
		if (count _launcherData > 1) then {
			private _attachments = _launcherData select 1;
			{ player addSecondaryWeaponItem _x; } forEach _attachments;
		};
	};
};

// --- Magazines / Inventory ---
private _magazines = _roleData getOrDefault ["magazines", []];
{
	_x params ["_magClass", "_magCount"];
	for "_i" from 1 to _magCount do {
		player addItem _magClass;
	};
} forEach _magazines;

private _items = _roleData getOrDefault ["items", []];
{
	_x params ["_itemClass", "_itemCount"];
	for "_i" from 1 to _itemCount do {
		player addItem _itemClass;
	};
} forEach _items;

// Link items (if defined specifically by the exporter, otherwise common scripts will handle basic maps/compass)
private _linkedItems = _roleData getOrDefault ["linkedItems", []];
{
	player linkItem _x;
} forEach _linkedItems;
