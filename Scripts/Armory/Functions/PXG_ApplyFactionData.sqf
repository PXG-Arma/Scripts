// PXG Data-Driven Engine
// Reads Faction_Core.sqf Hashmap and applies the loadout for the specified role.
params [
    "_side", "_faction", "_variant", "_loadout", "_basePath",
    ["_overrideWeapon", ""], ["_overrideSight", ""]
];

private _factionData = call compile preprocessFile (_basePath + "Faction_Core.sqf");
if (isNil "_factionData" || {typeName _factionData != "HASHMAP"}) exitWith {
	diag_log format ["[PXG Error] Faction_Core.sqf at %1 is invalid or missing.", _basePath];
};

private _armoryData = _factionData getOrDefault ["Armory", createHashMap];
private _roleData = _armoryData get _loadout;

if (isNil "_roleData") then {
	_roleData = _armoryData get "default";
};

if (isNil "_roleData") exitWith {
	diag_log format ["[PXG Error] Role '%1' not found in Faction_Core.sqf 'Armory' map.", _loadout];
};

// --- Clothing ---
private _uniform = _roleData getOrDefault ["uniform", ""];
if (_uniform != "") then { player forceAddUniform _uniform; };

private _vest = _roleData getOrDefault ["vest", ""];
if (_vest != "") then { player addVest _vest; };

private _backpack = _roleData getOrDefault ["backpack", ""];
if (_backpack != "") then { player addBackpack _backpack; };

private _headgear = _roleData getOrDefault ["headgear", ""];
if (_headgear == "") then { _headgear = _roleData getOrDefault ["helmet", ""]; }; 
if (_headgear != "") then { player addHeadgear _headgear; };

// --- Weapons ---
private _attachmentStandards = _factionData getOrDefault ["Attachment_Standards", createHashMap];

private _primaryData = _roleData getOrDefault ["primary", []];
private _primaryGun = if (_overrideWeapon != "") then { _overrideWeapon } else { _primaryData getOrDefault [0, ""] };

if (_primaryGun != "") then {
    player addWeapon _primaryGun;

    // Smart Attachment Resolution
    private _appliedSights = false;

    // 1. Apply UI Override Sight
    if (_overrideSight != "") then {
        player addPrimaryWeaponItem _overrideSight;
        _appliedSights = true;
    };

    // 2. Apply Standards (Suppressors, Lasers, and Sights if not overridden)
    private _standards = _attachmentStandards getOrDefault [_primaryGun, []];
    {
        private _item = _x;
        private _isOptic = IS_OPTIC(_item); // Standardized optic check macro
        
        // Don't apply standard sight if we already applied an override
        if (_appliedSights && _isOptic) then { continue };
        
        player addPrimaryWeaponItem _item;
    } forEach _standards;

    // 3. Fallback to fixed loadout attachments if no standards/overrides exist
    if (count _primaryData > 1 && {count _standards == 0} && {_overrideSight == ""}) then {
        { player addPrimaryWeaponItem _x; } forEach (_primaryData select 1);
    };
};

private _secondaryData = _roleData getOrDefault ["secondary", []]; // Support for 'secondary' key
if (count _secondaryData == 0) then { _secondaryData = _roleData getOrDefault ["handgun", []]; }; // Fallback for 'handgun' key
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
// Standard 1-file format uses flat arrays for magazines and items
private _magazines = _roleData getOrDefault ["magazines", []];
{
	player addItem _x;
} forEach _magazines;

private _items = _roleData getOrDefault ["items", []];
{
	player addItem _x;
} forEach _items;

// Link items (if defined specifically by the exporter, otherwise common scripts will handle basic maps/compass)
private _linkedItems = _roleData getOrDefault ["linkedItems", []];
if (count _linkedItems == 0) then { _linkedItems = _roleData getOrDefault ["nvg", []]; }; // Fallback for singular types
if (_linkedItems isEqualType "") then { _linkedItems = [_linkedItems]; };

{
	if (_x != "") then { player linkItem _x; };
} forEach _linkedItems;

