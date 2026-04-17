/*
    FBT_AddItem.sqf
    -------------------------------
    Handles the creation of new roles/vehicles.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _tabName = _display getVariable ["FBT_ActiveTab", "Overview"];

if (_tabName == "Overview") exitWith { systemChat "Use the metadata dropdowns to add a new faction."; };

// Open Extended Panel for naming
[true] execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf";

// We set a flag so the 'Confirm' button in the extended panel knows what to do
_display setVariable ["FBT_PendingAction", "AddItem"];
_display setVariable ["FBT_PendingTab", _tabName];

// Set default text for the edit box
private _edit = _display displayCtrl 456061;
_edit ctrlSetText (if (_tabName == "Armory") then {"New Role"} else {"B_Heli_Light_01_F"});
