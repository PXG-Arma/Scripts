#include "..\..\macros.hpp"

/*
    PXG_Motorpool_Pylon_Apply.sqf
    ----------------------------
    Applies a specific magazine to a specific pylon hardpoint.
    Updates both the object (live or preview) and the player's persistent loadout memory.

    Arguments:
    0: NUMBER - Pylon ID (1-indexed)
    1: STRING - Magazine classname (empty string to clear)
*/

params ["_pylonIdx", "_mag"];

if (isNil "_pylonIdx" || isNil "_mag") exitWith {};

// Determine target vehicle
private _vehicle = player getVariable ["PXG_Motorpool_Active_Vehicle", objNull];
private _isSpawned = !isNull _vehicle || (!isNull cursorTarget && {cursorTarget distance player < 10});

if (isNull _vehicle) then {
    _vehicle = missionNamespace getVariable ["PXG_Cam_TargetObj", objNull];
};

if (isNull _vehicle) exitWith {};

// 1. Physical Application
if (_isSpawned) then {
    // Multiplayer safe global application for live vehicles
    [_vehicle, [_pylonIdx, _mag, true]] remoteExec ["setPylonLoadout", _vehicle];
} else {
    // Local application for the 3D preview vehicle
    _vehicle setPylonLoadout [_pylonIdx, _mag, true];
};

// 2. Persistence Layer (Memory for next spawn)
private _customPylons = player getVariable ["PXG_Motorpool_CustomPylons", []];

// Remove existing entry for this specific pylon ID if it exists
private _newPylons = [];
{
    if ((_x select 0) != _pylonIdx) then { _newPylons pushBack _x; };
} forEach _customPylons;
_customPylons = _newPylons;

// Add new configuration if not empty
if (_mag != "") then {
    _customPylons pushBack [_pylonIdx, _mag];
};

player setVariable ["PXG_Motorpool_CustomPylons", _customPylons];
