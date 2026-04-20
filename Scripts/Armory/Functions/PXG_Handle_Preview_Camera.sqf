#include "..\..\macros.hpp"
/*
    PXG_Handle_Preview_Camera.sqf
    ----------------------------
    Handles the RTT camera focused on the player for the Armory preview.
    Modes: "init", "update", "destroy"
*/

params [["_display", displayNull], ["_mode", "init"]];

switch (_mode) do {
    case "init": {
        if (isNull _display) exitWith {};

        // 1. Save State
        PXG_Armory_Original_Loadout = getUnitLoadout player;
        PXG_Armory_Original_UnitPos = unitPos player;
        PXG_Armory_Apply_Final = false;

        // 2. Force Stance
        player setUnitPos "UP";
        player playActionNow "RifleRaised";

        // 3. Create Camera
        if (isNil "PXG_Armory_Cam" || {isNull PXG_Armory_Cam}) then {
            PXG_Armory_Cam = "camera" camCreate (getPosASL player);
        };
        
        "pxg_armory_pip" setPiPEffect [0];
        PXG_Armory_Cam cameraEffect ["INTERNAL", "BACK", "pxg_armory_pip"];
        PXG_Armory_Cam camPrepareFOV 0.45;
        PXG_Armory_Cam camCommitPrepared 0;

        // 4. Start Render Loop
        if (!isNil "PXG_Armory_Cam_Draw3D") then { removeMissionEventHandler ["Draw3D", PXG_Armory_Cam_Draw3D]; };
        PXG_Armory_Cam_Draw3D = addMissionEventHandler ["Draw3D", {
            if (isNil "PXG_Armory_Cam" || {isNull PXG_Armory_Cam}) exitWith {};
            
            private _dist = 1.8;
            
            // Calculate Camera Position (60 degrees from front-right)
            // Shifted +0.3 forward in Y
            private _camPosAGL = player modelToWorldVisual [sin(60) * _dist, cos(60) * _dist + 0.3, 1.4];
            private _camPosASL = AGLToASL _camPosAGL;
            PXG_Armory_Cam setPosASL _camPosASL;
            
            // Calculate Target Position (0.3m right, 0.8m forward, 1.2m up)
            private _targetPosAGL = player modelToWorldVisual [0.3, 0.8, 1.2];
            private _targetPosASL = AGLToASL _targetPosAGL;
            
            // Force Camera to look at target using vectors (most reliable method)
            private _dirVec = _targetPosASL vectorDiff _camPosASL;
            PXG_Armory_Cam setVectorDirAndUp [_dirVec, [0,0,1]];
        }];
    };

    case "destroy": {
        // 1. Cleanup Render Loop
        if (!isNil "PXG_Armory_Cam_Draw3D") then {
            removeMissionEventHandler ["Draw3D", PXG_Armory_Cam_Draw3D];
            PXG_Armory_Cam_Draw3D = nil;
        };

        // 2. Cleanup Camera
        if (!isNil "PXG_Armory_Cam" && {!isNull PXG_Armory_Cam}) then {
            PXG_Armory_Cam cameraEffect ["TERMINATE", "BACK"];
            camDestroy PXG_Armory_Cam;
            PXG_Armory_Cam = nil;
        };

        // 3. Restore/Finalize State
        if (!(missionNamespace getVariable ["PXG_Armory_Apply_Final", false])) then {
            if (!isNil "PXG_Armory_Original_Loadout") then { player setUnitLoadout PXG_Armory_Original_Loadout; };
            if (!isNil "PXG_Armory_Original_UnitPos") then { player setUnitPos PXG_Armory_Original_UnitPos; };
        };

        PXG_Armory_Original_Loadout = nil;
        PXG_Armory_Original_UnitPos = nil;
        PXG_Armory_Apply_Final = nil;
    };
};
