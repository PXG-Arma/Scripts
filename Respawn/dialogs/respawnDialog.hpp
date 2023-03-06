class dialog_respawn
{
	idd = 471922;
	class controls
	{
		
		class RscFrame_1: PxgGuiBackground
		{
			idc = -1;

			x = 0.38 * safezoneW + safezoneX;
			y = 0.47 * safezoneH + safezoneY;
			w = 0.24 * safezoneW;
			h = 0.06 * safezoneH;
		};
		
		class RscStructuredText_1: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "Respawn menu"; //--- ToDo: Localize;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.447 * safezoneH + safezoneY;
			w = 0.24 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class RespawnText: PxgGuiRscText
		{
			idc = 471100; 

			text = "";
			x = 0.39 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class respawn_add_wave_button: PxgGuiRscButton
		{
			idc = 471600;
			action = "[1] execVM 'Scripts\Respawn\Functions\PXG_Change_Respawn_Wave.sqf'; closeDialog 2;";

			text = "Add wave"; //--- ToDo: Localize;
			
			x = 0.50 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class respawn_remove_wave_button: PxgGuiRscButton
		{
			idc = 471601;
			action = "[-1] execVM 'Scripts\Respawn\Functions\PXG_Change_Respawn_Wave.sqf'; closeDialog 2;";

			text = "Remove wave"; //--- ToDo: Localize;
			
			x = 0.44 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class respawn_trigger_wave_button: PxgGuiRscButton
		{
			idc = 471602;
			action = "execVM 'Scripts\Respawn\Functions\PXG_Start_Respawn_Wave.sqf'; closeDialog 2;";

			text = "Trigger wave"; //--- ToDo: Localize;
			
			x = 0.56 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class motorpoolButtonCloseDialog: PxgGuiRscButton
		{
			idc = 471603;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.38 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};

