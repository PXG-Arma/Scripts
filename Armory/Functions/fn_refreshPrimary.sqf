// Get selected item from faction list
 _indexFaction = tvCurSel 431501;

// Prevents error about missing SQF if player selects faction rather than variant from tree list 
if (count _indexFaction < 2) exitwith {};

// Get faction name 
_factionName = tvText [431501, _indexFaction];

_faction = "getText (_x >> 'name') == _factionName" configClasses (missionConfigFile >> "PXGfactions");

_loadouts = "getNumber (_x >> 'displayInArmory') == 1" configClasses (_faction select 0);

 _indexLoadout = tvCurSel 431503;
 _loadoutName = tvText [431503, _indexLoadout];
 

_loadout = "getText (_x >> 'displayName') == _loadoutName" configClasses (_faction select 0);

private _someIDC = 431007; 

private _classVariable = ["primaryMuzzles", "primaryGrips", "primaryLights", "primaryOptics"];
private _arrayVariable = ["PXG_armory_primaryMuzzles", "PXG_armory_primaryGrips", "PXG_armory_primaryLights", "PXG_armory_primaryOptics"];
private _selectedVariable = ["PXG_armory_primaryMuzzlesSelected", "PXG_armory_primaryGripsSelected", "PXG_armory_primaryLightsSelected", "PXG_armory_primaryOpticsSelected"];


private _primary = getArray (_loadout select 0 >> "primary");
if (count _primary > 1) then {ctrlEnable [_someIDC +1, true];
} else {ctrlEnable [_someIDC +1, false];};

if (player getVariable ["PXG_armory_primarySelected", "NONE"] in _primary) then {
	player setVariable ["PXG_armory_primary", _primary];
	private _picForUI2 = [player getVariable ["PXG_armory_primarySelected", "NONE"]] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
	ctrlSetText [_someIDC, _picForUI2];

} else {
	player setVariable ["PXG_armory_primary", _primary];
	player setVariable ["PXG_armory_primarySelected", _primary select 0];
	private _picForUI = [_primary select 0] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
	ctrlSetText [_someIDC, _picForUI];
};
	_someIDC = _someIDC + 2;
{
	private _arrayFromConfig = getArray (_loadout select 0 >> _x);

	private _compatbileAttachments = [];
	
	if (count _arrayFromConfig > 0) then {
		{
			private _isCompatible = _x in compatibleItems (player getVariable ["PXG_armory_primarySelected", "NONE"]);

			if (_isCompatible) then {
				_compatbileAttachments pushBack _x;
			};
		} forEach _arrayFromConfig;
	};
	

	if (count _compatbileAttachments > 1) then {ctrlEnable [_someIDC+1, true];
	} else {ctrlEnable [_someIDC+1, false];};

	if (player getVariable [_selectedVariable select _forEachIndex, "NONE"] in _compatbileAttachments) then {
		player setVariable [_arrayVariable select _forEachIndex, _compatbileAttachments];
		private _picForUI2 = [player getVariable [_selectedVariable select _forEachIndex, "NONE"]] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
		ctrlSetText [_someIDC, _picForUI2];

	} else {
		player setVariable [_arrayVariable select _forEachIndex, _compatbileAttachments];
		player setVariable [_selectedVariable select _forEachIndex, _compatbileAttachments select 0];
		private _picForUI = [_compatbileAttachments select 0] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
		ctrlSetText [_someIDC, _picForUI];
	};
	_someIDC = _someIDC + 2;
} forEach _classVariable;
