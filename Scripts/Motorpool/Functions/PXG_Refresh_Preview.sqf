#include "..\..\macros.hpp"

/*
    PXG_Refresh_Preview.sqf
    -----------------------
    Hardened 3D Preview Refresh Logic.
    Handles creation, deletion, and mod-compatibility patching for the Motorpool.
*/

private _ctrlTree = _this select 0;
private _indexVehicle = tvCurSel _ctrlTree;

// 1. Validation & Debounce
if (count _indexVehicle < 2) exitWith {}; // Category selected
if (diag_tickTime < (missionNamespace getVariable ["PXG_Motorpool_NextPreview", 0])) exitWith {};
missionNamespace setVariable ["PXG_Motorpool_NextPreview", diag_tickTime + 0.15]; // 150ms stabilization delay

private _vehicleClass = tvData [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];
if (_vehicleClass == "") exitWith {};

// Save selection for persistence
player setVariable ["PXG_Motorpool_Memory_Vehicle", _indexVehicle];

// 2. UI Updates (Immediate)
private _previewPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "EditorPreview");
if (_previewPicture == "") then { _previewPicture = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg"; };
ctrlSetText [IDC_MOTORPOOL_PREVIEW, _previewPicture];

private _cargoVal = tvValue [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];
private _cargoCapacity = if (_cargoVal == -1) then { getNumber(configFile >> "CfgVehicles" >> _vehicleClass >> "ace_cargo_space") } else { _cargoVal };
ctrlSetText [IDC_MOTORPOOL_CARGO_TEXT, format ["Cargo Capacity: %1", _cargoCapacity]];

private _allSeats = [_vehicleClass, true] call BIS_fnc_crewCount;
private _crewSeats = [_vehicleClass, false] call BIS_fnc_crewCount;
ctrlSetText [IDC_MOTORPOOL_SEATS_TEXT, format ["Crew: %1 Passengers: %2", _crewSeats, _allSeats - _crewSeats]];

// 3. Staggered 3D Preview (Spawn Context)
_this spawn {
    params ["_ctrlTree"];
    private _display = ctrlParent _ctrlTree;
    private _indexSpawn = lbCurSel (_display displayCtrl IDC_MOTORPOOL_SPAWNPOINTS);
    if (_indexSpawn == -1) exitWith {};

    private _spawnPoint = synchronizedObjects (player getVariable "PXG_Vehicle_Master") select _indexSpawn;
    private _spawnCoords = getPosATL _spawnPoint;
    private _indexVehicle = tvCurSel _ctrlTree;
    private _vehicleClass = tvData [IDC_MOTORPOOL_VEHICLE_LB, _indexVehicle];

    // Cleanup old preview with Frame Delay
    private _oldPreview = missionNamespace getVariable ["PXG_Motorpool_Preview_Vic", objNull];
    if (!isNull _oldPreview) then { 
        deleteVehicle _oldPreview; 
        sleep 0.05; // Allow networking/mod-scripts to terminate
    };

    // Create Local Preview
    // Note: We use createVehicleLocal to avoid network overhead during clicking
    private _previewVic = _vehicleClass createVehicleLocal _spawnCoords;
    _previewVic setDir getDir _spawnPoint;
    _previewVic setPosATL _spawnCoords;
    _previewVic setVectorUp surfaceNormal _spawnCoords;
    _previewVic lock true;
    _previewVic enableSimulation false;

    // --- Hardened Mod Compatibility ---
    // 1. Suppression of malfunctioning Mod Init EHs (Stops Zero Divisor in 3CB)
    _previewVic removeAllEventHandlers "init"; 
    
    // 2. Suppress BIS system init to prevent fighting with custom skins
    _previewVic setVariable ["BIS_fnc_initVehicle_disable", true];

    missionNamespace setVariable ["PXG_Motorpool_Preview_Vic", _previewVic];
    missionNamespace setVariable ["PXG_Cam_TargetObj", _previewVic];

    // Restore Pylon Loadout
    private _customPylons = player getVariable ["PXG_Motorpool_CustomPylons", []];
    {
        _x params ["_pylonIdx", "_mag"];
        _previewVic setPylonLoadout [_pylonIdx, _mag, true];
    } forEach _customPylons;

    // Regenerate Pylon UI
    [_previewVic] call compile preprocessFile "Scripts\Motorpool\Functions\PXG_Motorpool_Pylon_Update_Panel.sqf";
};