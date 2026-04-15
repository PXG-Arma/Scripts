#include "..\..\macros.hpp"

class armoryDialog
{
	idd = 431234;
	onLoad = "[_this select 0, 'init'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
	class controls
	{
		class armoryBaseFrame: PxgGuiBackground
		{
			idc = 431006;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8}; 

			x = 0.185 * safezoneW + safezoneX;
			y = 0.1815 * safezoneH + safezoneY; // Global UI Standard
			w = 0.63 * safezoneW;
			h = 0.637 * safezoneH; // Global UI Standard
		};
		class armoryStructuredText: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "<t align='center'>ARMORY</t>"; // Centered and All Caps
			x = 0.185 * safezoneW + safezoneX;
			y = 0.1585 * safezoneH + safezoneY; // Global UI Standard
			w = 0.63 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class armorySideText: PxgGuiRscText
		{
			idc = 431004;
			text = "1. Side"; 
			x = 0.20 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryFactionsText: PxgGuiRscText
		{
			idc = 431000;

			text = "2. Faction"; 
			x = 0.20 * safezoneW + safezoneX;
			y = 0.3085 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryCamoText: PxgGuiRscText
		{
			idc = 431005;

			text = "3. Camo [Era]"; 
			x = 0.20 * safezoneW + safezoneX;
			y = 0.5585 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryLoadoutsText: PxgGuiRscText
		{
			idc = 431001;

			text = "4. Loadout"; //--- ToDo: Localize;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;

		};
		class armorySideList: PxgGuiRscListBox
		{
			idc = 431500;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.067 * safezoneH;

			onLBSelChanged = " call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Factions.sqf'";
		};
		class armoryFactionList: PxgGuiRscTree
		{
			idc = 431501;

			x = 0.20 * safezoneW + safezoneX;
			y = 0.3385 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.210 * safezoneH; 

			onTreeSelChanged = "[_this select 0, 431504, 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf', 'PXG_Armory_Memory_Camo'] call compile preprocessfile 'Scripts\Factions\PXG_Refresh_Camos.sqf'";
			onTreeExpanded = "_this spawn { params ['_ctrl', '_path']; sleep 0.05; if (count _path == 1) then { private _sel = tvCurSel _ctrl; _ctrl tvSetCurSel [-1]; for '_i' from 0 to ((_ctrl tvCount _path) - 1) do { _ctrl tvCollapse (_path + [_i]); _ctrl tvExpand (_path + [_i]); }; if (count _sel > 0) then { _ctrl tvSetCurSel _sel; }; }; };";
		};
		class armoryCamoList: PxgGuiRscListBox
		{
			idc = 431504;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.5885 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.210 * safezoneH; 

			sizeEx = 0.018 * safezoneH;
			rowHeight = 1.8 * 0.018 * safezoneH;

			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf'";
		};
		class armoryLoadoutList: PxgGuiRscTree
		{
			idc = 431503;

			x = 0.51 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.567 * safezoneH; 

		};
		class armoryButtonGetLoadout: PxgGuiRscButton
		{
			idc = 431600;
			action = "[execVM ""Scripts\Armory\Functions\PXG_Request_Loadout.sqf""]";

			text = "Get Loadout"; //--- ToDo: Localize;

			x = 0.755 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // Global UI Standard
			w = GUI_W_BTN_M;
			h = GUI_H_BTN;
		};
		class armoryButtonCloseDialog: PxgGuiRscButton
		{
			idc = 431601;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.185 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // Global UI Standard
			w = GUI_W_BTN_M;
			h = GUI_H_BTN;
		};
		class armoryButtonOpacity: PxgGuiRscButton
		{
			idc = 400001;
			action = "[ctrlParent (_this select 0), 'toggle'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
			text = GUI_STR_OPACITY;
			tooltip = "Toggle Background Opacity";
			colorText[] = GUI_COLOR_UI_GREY;
			x = 0.250 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // Global UI Standard
			w = GUI_W_BTN_S;
			h = GUI_H_BTN;
		};
	};
};