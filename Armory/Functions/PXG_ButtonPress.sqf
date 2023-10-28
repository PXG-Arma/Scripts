params["_value"];

private _purgelist = false; 

private _stuff = switch (_value) do {	// case must be odd
	default {_purgelist = true;};
	case 431008:{player getVariable ["PXG_armory_primary", ["NONE"]]}; // 431008
	case 431010:{player getVariable ["PXG_armory_primaryMuzzles", ["NONE"]]}; // 431010
	case 431012:{player getVariable ["PXG_armory_primaryGrips", ["NONE"]]}; // 431014
	case 431014:{player getVariable ["PXG_armory_primaryLights", ["NONE"]]}; // 431014
	case 431016:{player getVariable ["PXG_armory_primaryOptics", ["NONE"]]}; // 431016
	case 431018:{player getVariable ["PXG_armory_launcher", ["NONE"]]}; // 431018
	case 431020:{player getVariable ["PXG_armory_launcherMuzzles", ["NONE"]]}; // 431020
	case 431022:{player getVariable ["PXG_armory_launcherGrips", ["NONE"]]}; // 431022
	case 431024:{player getVariable ["PXG_armory_launcherLights", ["NONE"]]}; // 431024
	case 431026:{player getVariable ["PXG_armory_launcherOptics", ["NONE"]]}; // 431026
	case 431028:{player getVariable ["PXG_armory_binoculars",["NONE"]]}; // 431028
	case 431030:{player getVariable ["PXG_armory_NVGs",["NONE"]]}; // 431030
	case 431032:{player getVariable ["PXG_armory_secondary",["NONE"]]}; // 431032
	case 431034:{player getVariable ["PXG_armory_secondaryMuzzles",["NONE"]]}; // 431034
	case 431036:{player getVariable ["PXG_armory_secondaryGrips",["NONE"]]}; // 431036
	case 431038:{player getVariable ["PXG_armory_secondaryLights",["NONE"]]}; // 431038
	case 431040:{player getVariable ["PXG_armory_secondaryOptics",["NONE"]]}; // 431040
};

switch (_value) do {	// case must be odd
	default {};
	case 431008:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_primarySelected", _value -1]]}; // 431008
	case 431010:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_primaryMuzzlesSelected", _value -1]]}; // 431010
	case 431012:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_primaryGripsSelected", _value -1]]}; // 431014
	case 431014:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_primaryLightsSelected", _value -1]]}; // 431014
	case 431016:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_primaryOpticsSelected", _value -1]]}; // 431016
	case 431018:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_launcherSelected", _value -1]]}; // 431018
	case 431020:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_launcherMuzzlesSelected", _value -1]]}; // 431020
	case 431022:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_launcherGripsSelected", _value -1]]}; // 431022
	case 431024:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_launcherLightsSelected", _value -1]]}; // 431024
	case 431026:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_launcherOpticsSelected", _value -1]]}; // 431026
	case 431028:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_binocularsSelected", _value -1]]}; // 431028
	case 431030:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_NVGsSelected", _value -1]]}; // 431030
	case 431032:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_secondarySelected", _value -1]]}; // 431032
	case 431034:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_secondaryMuzzlesSelected", _value -1]]}; // 431034
	case 431036:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_secondaryGripsSelected", _value -1]]}; // 431036
	case 431038:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_secondaryLightsSelected", _value -1]]}; // 431038
	case 431040:{player setVariable ["PXG_armory_customisationSelect", ["PXG_armory_secondaryOpticsSelected", _value -1]]}; // 431040
};

tvclear 431041;

if (not _purgelist) then {
	{
	_customName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");

	// add text to list
	tvAdd [431041,[], _customName];
	tvSetData [431041, [_forEachIndex], _x];
	tvSetPicture [431041, [_forEachIndex], getText (configFile >> "CfgWeapons" >> _x >> "picture")];
	}forEach _stuff;
};