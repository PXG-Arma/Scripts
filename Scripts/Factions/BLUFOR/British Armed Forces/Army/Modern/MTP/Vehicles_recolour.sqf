params["_vehicle","_vehicleType"];

/*
    Vehicles_recolour.sqf (UK Armed Forces - MTP)
    -------------------------------------------
    Hardened version with mod-compatibility patches.
*/

// --- 3CB MOD COMPATIBILITY PATCH ---
// UK3CB BAF vehicles often have internal setup scripts (fn_init_EH.sqf) that crash 
// if they cannot find specific texture indices (0, 1, or 2). 
// For PREVIEW vehicles, the crash is prevented by 'removeAllEventHandlers' in Refresh_Preview.sqf.
// For LIVE vehicles, we attempt to expand the array here to mitigate issues.
{
    if (count (getObjectTextures _vehicle) < (_x + 1)) then {
        _vehicle setObjectTextureGlobal [_x, ""]; 
    };
} forEach [0, 1, 2];

switch(_vehicleType) do
{
	case "UK3CB_BAF_Warrior_A3_W_Cage_Camo_MTP": {
        // Specific woodland configuration for Warrior if needed
    };
	default {};
};
