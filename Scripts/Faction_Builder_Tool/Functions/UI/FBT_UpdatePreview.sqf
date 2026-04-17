/*
    FBT_UpdatePreview.sqf
    -------------------------------
    Fired when a user selects a role in the context tree.
    Coordinates the focus and visibility of the Phantom Agents.
*/
params ["_control", "_path"];
disableSerialization;

private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _id = _control tvData _path;
private _text = _control tvText _path;
if (_text == "") exitWith {};

private _tab = missionNamespace getVariable ["FBT_ActiveTab", "Overview"];

// If in Armory, initialize the Category icons
if (_tab == "Armory") then {
    execVM "Scripts\Faction_Builder_Tool\Functions\UI\FBT_InitArmoryCategories.sqf";
};

// 1. Visibility Logic (Focus on Selected Role)
private _paradeUnits = missionNamespace getVariable ["FBT_ParadeUnits", []];
private _selectedAgent = objNull;

{
    private _unitRoleID = _x getVariable ["FBT_RoleID", ""];
    
    if (_tab == "Armory") then {
        // Only show the unit being edited
        if (_unitRoleID == _id) then {
            _x hideObject false;
            _selectedAgent = _x;
        } else {
            _x hideObject true;
        };
    } else {
        // Show everything in Overview
        _x hideObject false;
        if (_unitRoleID == _id) then { _selectedAgent = _x; };
    };
} forEach _paradeUnits;

    // 2. Camera Focus Glide
    if (!isNull _selectedAgent) then {
        // Invoke modular camera update for smooth transition and pan reset
        [[_selectedAgent], "update"] execVM "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_HandleCamera.sqf";
    };

// 3. Fallback for "Custom/Unassigned" Roles (If not in parade)
if (isNull _selectedAgent && _tab == "Armory") then {
    // Logic for "Fresh Dummy" if no marker exists for this role
    private _anchorPos = missionNamespace getVariable ["FBT_AnchorPos", [0,0,0]];
    private _dummy = missionNamespace getVariable ["FBT_Preview_Unit", objNull];
    if (isNull _dummy) then {
        _dummy = createAgent ["B_RangeMaster_F", _anchorPos, [], 0, "CAN_COLLIDE"];
        missionNamespace setVariable ["FBT_Preview_Unit", _dummy];
        _dummy enableSimulation false;
        _dummy allowDamage false;
    };
    _dummy setPosWorld (_anchorPos vectorAdd [0, 5, 0]);
    _dummy hideObject false;
    
    [[_dummy], "update"] execVM "Scripts\Faction_Builder_Tool\Functions\Camera\FBT_HandleCamera.sqf";
};
