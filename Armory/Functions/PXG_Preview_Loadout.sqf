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

private _someIDC = 431027; 

private _classVariable = ["binoculars", "NVGs"];
private _arrayVariable = ["PXG_armory_binoculars", "PXG_armory_NVGs"];
private _selectedVariable = ["PXG_armory_binocularsSelected", "PXG_armory_NVGsSelected"];

call compile preprocessFile "Scripts\Armory\Functions\fn_refreshPrimary.sqf";
call compile preprocessFile "Scripts\Armory\Functions\fn_refreshSecondary.sqf";
call compile preprocessFile "Scripts\Armory\Functions\fn_refreshLauncher.sqf";


{
	private _arrayFromConfig = getArray (_loadout select 0 >> _x);

	if (count _arrayFromConfig > 1) then {ctrlEnable [_someIDC+1, true];
	} else {ctrlEnable [_someIDC+1, false];};

	if (player getVariable [_selectedVariable select _forEachIndex, "NONE"] in _arrayFromConfig) then {
		player setVariable [_arrayVariable select _forEachIndex, _arrayFromConfig];
		private _picForUI2 = [player getVariable [_selectedVariable select _forEachIndex, "NONE"]] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
		ctrlSetText [_someIDC, _picForUI2];

	} else {
		player setVariable [_arrayVariable select _forEachIndex, _arrayFromConfig];
		player setVariable [_selectedVariable select _forEachIndex, _arrayFromConfig select 0];
		private _picForUI = [_arrayFromConfig select 0] call compile preprocessfile "Scripts\Armory\Functions\fn_getWeaponPicture.sqf";
		ctrlSetText [_someIDC, _picForUI];
	};
	_someIDC = _someIDC + 2;
} forEach _classVariable;

call compile preprocessFile "Scripts\Armory\Functions\PXG_ButtonPress.sqf";
