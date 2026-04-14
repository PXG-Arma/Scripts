params["_crate"];

_indexFaction = tvCurSel 451501;
_indexSupplies = lbCurSel 451502;
if (count _indexFaction < 2) exitwith {};

_variantData = tvData [451501, _indexFaction];
if (_variantData == "") exitWith {};

_metadata = call compile _variantData;

// Construct path utilizing the GetFactionPath utility
_basePath = [_variantData] call compile preprocessFile "Scripts\Factions\PXG_GetFactionPath.sqf";
_suppliesScriptPath = _basePath + "Supplies.sqf";

_suppliesArray = call compile preprocessfile _suppliesScriptPath;
if (isNil "_suppliesArray") exitWith {};

_suppliesContent = _suppliesArray select _indexSupplies select 1;
_suppliesName = _suppliesArray select _indexSupplies select 0;

{
	_supplyType = _x select 0;
	_supplyAmount = _x select 1;
	if (_suppliesName == "Parachutes") then {
		_crate addBackpackCargoGlobal [_supplyType,_supplyAmount];
	};
	_crate addItemCargoGlobal [_supplyType,_supplyAmount];
} forEach _suppliesContent;

_crate setVariable ["ace_cargo_customName", _suppliesName, true];