/*
    FBT_DuplicateItem.sqf
    -------------------------------
    Creates a copy of the currently selected role or vehicle.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _tree = _display displayCtrl 456010;
private _path = tvCurSel _tree;
if (count _path == 0) exitWith { systemChat "Error: No role selected to duplicate."; };

private _roleId = _tree tvData _path;
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
private _armory = _masterHash getOrDefault ["Armory", createHashMap];
private _seq    = _masterHash getOrDefault ["ArmorySequence", []];

// 1. Fetch source data
private _sourceData = _armory getOrDefault [_roleId, createHashMap];
private _sourceName = "";
{ if (_x select 0 == _roleId) exitWith { _sourceName = _x select 1; }; } forEach _seq;

// 2. Clone and Generate New ID
private _newData = +_sourceData; // Deep copy
private _newId = _roleId + "_copy";
private _newName = _sourceName + " (Copy)";

// Check for ID collision
if (_newId in _armory) then {
    _newId = _newId + "_" + (str (round (random 999)));
};

// 3. Register in Sequence and Store data
_armory set [_newId, _newData];
_seq pushBack [_newId, _newName, "Custom"];
_masterHash set ["ArmorySequence", _seq];

// 4. Refresh UI and World
[] spawn {
    uiSleep 0.1;
    execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf";
    ["Armory"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
};

systemChat format ["Duplicated %1 as %2", _sourceName, _newName];
