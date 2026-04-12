/*
    PXG_GetFactionPath.sqf
    ----------------------------
    Parses serialized registry metadata and returns the absolute basePath to the Faction's resources.
    Input: String _variantData (from tvData)
    Output: String _basePath
*/

params [["_variantData", ""]];

if (_variantData == "") exitWith { "" };

private _metadata = call compile _variantData;
private _sideFolder = _metadata select 0;
private _faction = _metadata select 1;
private _subFaction = _metadata select 2;
private _variantEra = _metadata select 3;
private _variantCamo = _metadata select 4;

private _subFactionPath = ""; 
if (_subFaction != "") then { _subFactionPath = _subFaction + "\" };

private _eraPath = ""; 
if (_variantEra != "") then { _eraPath = _variantEra + "\" };

private _basePath = "Scripts\Factions\" + _sideFolder + "\" + _faction + "\" + _subFactionPath + _eraPath + _variantCamo + "\";

_basePath
