/*
    FBT_TabSwitch.sqf
    -------------------------------
    Handles switching Left and Right context panels based on the selected Tab.
*/
params ["_tabName"];
disableSerialization;
missionNamespace setVariable ["FBT_ActiveTab", _tabName];

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
    missionNamespace setVariable ["FBT_ActiveTab_Old", "Overview"];
	// Populate dropdowns for the first time
	["Init"] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf";

    // Visibility Reset for Phantom Agents
    { _x hideObject false; } forEach (missionNamespace getVariable ["FBT_ParadeUnits", []]);

    // Set Overview Camera Default (Bird's Eye / 2.5x factor) if not booting
    if (!(missionNamespace getVariable ["FBT_SuppressEvents", false])) then {
        FBT_Cam_Dist = missionNamespace getVariable ["FBT_Field_Zoom", 12];
        FBT_Cam_El = 30;
    };
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
        private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];
        private _groups = _masterHash getOrDefault ["ArmoryGroups", []];
        private _roles  = _masterHash getOrDefault ["ArmoryRoles", []];
        private _ids    = _masterHash getOrDefault ["ArmoryIDs", []];

        {
            private _gIdx = _forEachIndex;
            private _parentIdx = _tree tvAdd [[], _x];
            
            private _groupRoles = _roles select _gIdx;
            private _groupIDs   = _ids select _gIdx;

            {
                private _rIdx = _tree tvAdd [[_parentIdx], _x];
                _tree tvSetData [[_parentIdx, _rIdx], _groupIDs select _forEachIndex];
            } forEach _groupRoles;

            _tree tvExpand [_parentIdx];
        } forEach _groups;

        // Set Armory Camera Default (4m as requested)
        FBT_Cam_Dist = 4;
        FBT_Cam_El = 20;
        
        // Add +30 clockwise offset once upon entry from another tab
        if (missionNamespace getVariable ["FBT_ActiveTab_Old", ""] != "Armory") then {
            FBT_Cam_Az = (FBT_Cam_Az + 30) % 360;
            missionNamespace setVariable ["FBT_ActiveTab_Old", "Armory"];
        };

        // Autoselect first role (if exists) to trigger initial focus and UI logic
        if (_tree tvCount [] > 0) then {
            if (_tree tvCount [0] > 0) then {
                _tree tvSetCurSel [0, 0];
            };
        };
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
