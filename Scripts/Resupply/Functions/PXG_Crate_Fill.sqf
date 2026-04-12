params["_crate"];

_indexFaction = tvCurSel 451501;
_indexSupplies = lbCurSel 451502;
if (count _indexFaction < 2) exitwith {};

_variantData = tvData [451501, _indexFaction];
if (_variantData == "") exitWith {};

_metadata = call compile _variantData;
_sideFolder = _metadata select 0;
_faction = _metadata select 1;
_variantEra = _metadata select 2;
_variantCamo = _metadata select 3;

// Path for supplies list (Handles empty era correctly)
_eraPath = ""; if (_variantEra != "") then { _eraPath = _variantEra + "\" };
_suppliesScriptPath = "Scripts\Factions\" + _sideFolder + "\" + _faction + "\" + _eraPath + _variantCamo + "\Supplies.sqf";

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