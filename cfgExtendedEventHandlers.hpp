class Extended_PreInit_EventHandlers {
    class pxg_respawn_init {
        init = "call pxg_respawn_fnc_preInit;";
    };
    class pxg_markers_init {
        init = "call pxg_markers_fnc_preInit;";
    };
};

class Extended_PostInit_EventHandlers 
{
    class pxg_respawn_init {
        init = "call pxg_respawn_fnc_initRespawn;";
    };
    class pxg_markers_init {
        init = "call pxg_markers_fnc_initRespawn;";
    };
};
