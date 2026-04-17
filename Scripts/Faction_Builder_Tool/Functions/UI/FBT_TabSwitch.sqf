/*
    FBT_TabSwitch.sqf
    -------------------------------
    Handles switching Left and Right context panels based on the selected Tab.
*/
params ["_tabName"];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _tree = _display displayCtrl 456010;
private _overviewGroup = _display displayCtrl 456050;

// Wipe the tree
tvClear _tree;

// Play a subtle UI sound
playSound ["RscDisplayCurator_ping01", true];

private _rightPanel = _display displayCtrl 456100;

if (_tabName == "Overview") then {
	_tree ctrlShow false;
	_overviewGroup ctrlShow true;
    _rightPanel ctrlShow false; // Keep right side clean in Overview
	// Populate dropdowns for the first time
	["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";

    // Visibility Reset for Phantom Agents
    { _x hideObject false; } forEach (missionNamespace getVariable ["FBT_ParadeUnits", []]);
} else {
	_tree ctrlShow true;
	_overviewGroup ctrlShow false;
    _rightPanel ctrlShow true; // Show for configuration tabs (Armory, etc)
    // Ensure extended panel is closed when switching away
    [false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
};

switch (_tabName) do {
    case "Overview": {
        private _main = _tree tvAdd [[], "Faction Metadata"];
        _tree tvAdd [[_main], "Side"];
        _tree tvAdd [[_main], "Faction Name"];
        _tree tvAdd [[_main], "Subfaction"];
        _tree tvAdd [[_main], "Camo"];
        _tree tvAdd [[_main], "Era"];
		// Automatically open the folder
        _tree tvExpand [_main];
    };
    case "Armory": {
        private _hq = _tree tvAdd [[], "Platoon HQ"];
        _tree tvAdd [[_hq], "Platoon Leader"];
        _tree tvAdd [[_hq], "Medic"];
        
        private _sq1 = _tree tvAdd [[], "Squad 1"];
        _tree tvAdd [[_sq1], "Squad Leader"];
        _tree tvAdd [[_sq1], "Rifleman"];
        _tree tvAdd [[_sq1], "Grenadier"];
		
		_tree tvExpand [_hq];
		_tree tvExpand [_sq1];
    };
    case "Motorpool": {
        _tree tvAdd [[], "Land Vehicles"];
        _tree tvAdd [[], "Air Vehicles"];
        _tree tvAdd [[], "Sea Vehicles"];
        _tree tvAdd [[], "Turrets"];
    };
    case "Resupply": {
        _tree tvAdd [[], "Standard Ammunition"];
        _tree tvAdd [[], "Medical Supplies"];
        _tree tvAdd [[], "Explosives & Logistics"];
    };
};
