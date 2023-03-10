class dialog_respawn
{
	idd = 471922;
	class controls
	{
		
		class RscFrame_1: PxgGuiBackground
		{
			idc = -1;

			x = 0.38 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.27 * safezoneH;
		};
		
		class RscStructuredText_1: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "Respawn menu"; //--- ToDo: Localize;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.238 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class RespawnText: PxgGuiRscText
		{
			idc = 471100; 

			text = "";
			x = 0.39 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.04 * safezoneH;
		};
/*		class respawn_add_wave_button: PxgGuiRscButton
		{
			idc = 471600;
			action = "[-1] call pxg_respawn_fnc_addRespawnWave; closeDialog 2;";

			text = "Add wave"; //--- ToDo: Localize;
			
			x = 0.50 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class respawn_remove_wave_button: PxgGuiRscButton
		{
			idc = 471601;
			action = "[1] call pxg_respawn_fnc_addRespawnWave; closeDialog 2;";

			text = "Remove wave"; //--- ToDo: Localize;
			
			x = 0.44 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};*/
		class respawn_trigger_wave_button: PxgGuiRscButton
		{
			idc = 471602;
			action = "call pxg_respawn_fnc_startRespawnWave; closeDialog 2;";

			text = "Trigger wave"; //--- ToDo: Localize;
			
			x = 0.56 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class respawn_ButtonCloseDialog: PxgGuiRscButton
		{
			idc = 471603;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.38 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class respawn_deadplayer_list: PxgGuiRscListBox
		{
			idc = 471604;

			x = 0.58 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.20 * safezoneH;

		};
		class respawn_respawn_single_player: PxgGuiRscButton
		{
			idc = 471605;
			action = "call pxg_respawn_fnc_respawnOnePlayerRemote; closeDialog 2;";

			text = "Respawn One";

			x = 0.65 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RespawnText2: PxgGuiRscText
		{
			idc = 471606; 

			text = "Dead Players:";
			x = 0.58 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
		};
	};
};

