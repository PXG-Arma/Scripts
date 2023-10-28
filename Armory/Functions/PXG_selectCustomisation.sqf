// get tv cursor 

private _cursor = tvCurSel 431041;

private _cursorData = tvData [431041, _cursor];

private _uiIDC = player getVariable "PXG_armory_customisationSelect" select 1;
private _custimiseVariable = player getVariable "PXG_armory_customisationSelect" select 0;

private _customisePic = getText (configFile >> "CfgWeapons" >> _cursorData >> "picture");

ctrlSetText [_uiIDC, _customisePic];
player setVariable [_custimiseVariable, _cursorData];

switch (_uiIDC) do {
	case 431007: {call compile preprocessFile "scripts\Armory\Functions\fn_refreshPrimary.sqf";}; // primary 
	case 431017: {call compile preprocessFile "scripts\Armory\Functions\fn_refreshLauncher.sqf";}; // launcher
	case 431031: {call compile preprocessFile "scripts\Armory\Functions\fn_refreshSecondary.sqf";}; // secondary 
};