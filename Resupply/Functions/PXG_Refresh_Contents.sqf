// Get selected item from faction list
_indexFaction = tvCurSel 451501;
_indexSupply = tvCurSel 451502;
_faction = [_indexFaction select 0];

// Prevents error if player selects faction header rather than a variant
if (count _indexFaction < 2) exitWith {};

// Intercept category header clicks — clear contents and bail out silently
if (count _indexSupply < 2) exitWith { ctrlSetText [451505, ""]; };

// Get faction and variant name
_faction = tvText [451501, _faction];
_variant = tvText [451501, _indexFaction];

// Split variant name to get era and camo
_variantArray = _variant splitString " ";
_variantEra = _variantArray #1;
_variantCamo = _variantArray #0;

// Path for supplies list 
_suppliesScriptPath = "Scripts\Factions\";
_suppliesScriptPath = _suppliesScriptPath + _faction + "\" + _variantEra + "\supplies_" + _variantCamo + ".sqf";

_suppliesFile = call compile preprocessfile _suppliesScriptPath;
_suppliesConfig = _suppliesFile select 0;  // Flat list of all supply definitions

_suppliesContents = [];
_crateContentsText = "";

// Get the supply name token stored in tvData
_supplyName = tvData [451502, _indexSupply];

switch (_supplyName) do
{
	case "FOB";
	case "FARP";
	case "Slingloadable Crate (8)";
	case "Wheel";
	case "Track": { _suppliesContents = [[], []]; };
	default {
		// Look up supply contents by name in the flat definitions list
		{ if (_x select 0 == _supplyName) exitWith { _suppliesContents = _x select 1; }; } forEach _suppliesConfig;

		{
			_sName = _suppliesContents select _forEachIndex select 0;
			_sCount = _suppliesContents select _forEachIndex select 1;
			_isMag = isClass (configFile >> "CfgMagazines" >> _sName);
			_isWeapon = isClass (configFile >> "CfgWeapons" >> _sName);
			_isVehicle = isClass (configFile >> "CfgVehicles" >> _sName);
			if (_isMag) then { _sName = getText (configFile >> "CfgMagazines" >> _sName >> "DisplayName"); };
			if (_isWeapon) then { _sName = getText (configFile >> "CfgWeapons" >> _sName >> "DisplayName"); };
			if (_isVehicle) then { _sName = getText (configFile >> "CfgVehicles" >> _sName >> "DisplayName"); };
			_crateContentsText = _crateContentsText + _sName + ": " + str _sCount + "\n";
		} forEach _suppliesContents;
	};
};

ctrlSetText [451505, _crateContentsText];
