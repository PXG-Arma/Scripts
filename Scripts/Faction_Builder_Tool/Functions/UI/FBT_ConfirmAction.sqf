/*
    FBT_ConfirmAction.sqf
    -------------------------------
    Processes the confirmed changes from the Extended Panel.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _action = _display getVariable ["FBT_PendingAction", ""];
private _tab    = _display getVariable ["FBT_PendingTab", ""];
private _newName = ctrlText (_display displayCtrl 456061);

if (_newName == "") exitWith { systemChat "Error: Name cannot be empty."; };

private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];

if (_action == "AddItem") then {
    if (_tab == "Armory") then {
        private _seq = _masterHash getOrDefault ["ArmorySequence", []];
        // For now, append to the end
        private _newId = "custom_" + (str (count _seq));
        _seq pushBack [_newId, _newName, "Custom Group"];
        _masterHash set ["ArmorySequence", _seq];
        
        // Init empty gear for new role
        (_masterHash get "Armory") set [_newId, createHashMap];
    };
    
    if (_tab == "Motorpool") then {
        private _seq = _masterHash getOrDefault ["MotorpoolSequence", []];
        _seq pushBack [_newName, "Custom Category"]; // newName is className for vehicles
        _masterHash set ["MotorpoolSequence", _seq];
    };
};

// Refresh the entire physical world
[] spawn {
    uiSleep 0.1;
    execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf";
    // Also refresh the tree in the UI
    private _tab = (findDisplay 456000) getVariable ["FBT_ActiveTab", "Overview"];
    [_tab] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf";
};

// Close panel
[false] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";
systemChat format ["Added %1 to the faction.", _newName];
