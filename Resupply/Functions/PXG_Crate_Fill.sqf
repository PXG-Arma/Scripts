params["_crate"];

_indexFaction = tvCurSel 451501;
_indexSupply = tvCurSel 451502;

// Gets text and data from UI 
_variant = tvText [451501, _indexFaction];
_indexFaction deleteAt 1; 
_faction = tvText [451501, _indexFaction];

_variantArray = _variant splitString " ";
_variantEra = _variantArray select 1;
_variantCamo = _variantArray #0;

_suppliesScriptPath = "Scripts\Factions\";
_suppliesScriptPath = _suppliesScriptPath + _faction + "\" + _variantEra + "\supplies_" + _variantCamo + ".sqf";

_suppliesFile = call compile preprocessfile _suppliesScriptPath;
_suppliesConfig = _suppliesFile select 0;  // Flat list of all supply definitions

// Get supply name token from tree data
_suppliesName = tvData [451502, _indexSupply];

// Look up supply contents by name in the flat definitions list
_suppliesContent = [];
{ if (_x select 0 == _suppliesName) exitWith { _suppliesContent = _x select 1; }; } forEach _suppliesConfig;

if (_suppliesName == "Parachutes") then {
	{
		_supplyType = _suppliesContent select _forEachIndex select 0;
		_supplyAmount = _suppliesContent select _forEachIndex select 1;
		_crate addBackpackCargoGlobal [_supplyType, _supplyAmount];
		_crate addItemCargoGlobal [_supplyType, _supplyAmount];
	} forEach _suppliesContent;
} else {
	{
		_supplyType = _suppliesContent select _forEachIndex select 0;
		_supplyAmount = _suppliesContent select _forEachIndex select 1;
		_crate addItemCargoGlobal [_supplyType, _supplyAmount];
	} forEach _suppliesContent;
};

_crate setVariable ["ace_cargo_customName", _suppliesName, true];