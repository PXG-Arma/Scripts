#include "..\..\macros.hpp"

class armoryDialog
{
	idd = IDD_ARMORY;
	onLoad = "[_this select 0, 'init'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf'; [_this select 0, 'init'] execVM 'Scripts\Armory\Functions\PXG_Handle_Preview_Camera.sqf';";
	onUnload = "[findDisplay 431234, 'destroy'] execVM 'Scripts\Armory\Functions\PXG_Handle_Preview_Camera.sqf';";
	class controls
	{
		class armoryBaseFrame: PxgGuiBackground
		{
			idc = IDC_ARMORY_BACKGROUND;
			colorBackground[] = PXG_COLOR_BG; 

			x = PXG_UI_MAIN_X;
			y = PXG_UI_MAIN_Y;
			w = PXG_UI_MAIN_W;
			h = PXG_UI_MAIN_H;
		};
		class armoryStructuredText: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "<t align='center'>ARMORY</t>";
			x = PXG_UI_MAIN_X;
			y = PXG_UI_HEADER_Y;
			w = PXG_UI_MAIN_W;
			h = PXG_UI_HEADER_H;
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
			idc = IDC_ARMORY_CAMO_TEXT;
			text = "3. Camo [Era]"; 
			x = 0.20 * safezoneW + safezoneX;
			y = 0.5585 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryLoadoutsText: PxgGuiRscText
		{
			idc = 431001;
			text = "4. Loadout";
			x = 0.51 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armorySideList: PxgGuiRscListBox
		{
			idc = IDC_ARMORY_SIDE;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.067 * safezoneH;
			onLBSelChanged = " call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Factions.sqf'";
		};
		class armoryFactionList: PxgGuiRscTree
		{
			idc = IDC_ARMORY_FACTION_TREE;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.3385 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.210 * safezoneH; 
			onTreeSelChanged = "[_this select 0, 431504, 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf', 'PXG_Armory_Memory_Camo'] call compile preprocessfile 'Scripts\Factions\PXG_Refresh_Camos.sqf'";
			onTreeExpanded = "_this spawn { params ['_ctrl', '_path']; sleep 0.05; if (count _path == 1) then { private _sel = tvCurSel _ctrl; _ctrl tvSetCurSel [-1]; for '_i' from 0 to ((_ctrl tvCount _path) - 1) do { _ctrl tvCollapse (_path + [_i]); _ctrl tvExpand (_path + [_i]); }; if (count _sel > 0) then { _ctrl tvSetCurSel _sel; }; }; };";
		};
		class armoryCamoList: PxgGuiRscListBox
		{
			idc = IDC_ARMORY_CAMO_LIST;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.5885 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.210 * safezoneH; 
			sizeEx = PXG_UI_LIST_TEXT_SIZE;
			rowHeight = 1.8 * PXG_UI_LIST_TEXT_SIZE;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf'";
		};
		class armoryLoadoutList: PxgGuiRscTree
		{
			idc = IDC_ARMORY_LOADOUT_TREE;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.29 * safezoneW;
			h = 0.567 * safezoneH; 
			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Modular_Lists.sqf'";
		};
		class armoryButtonGetLoadout: PxgGuiRscButton
		{
			idc = 431600;
			action = "[execVM ""Scripts\Armory\Functions\PXG_Request_Loadout.sqf""]";
			text = "Get Loadout";
			x = 0.755 * safezoneW + safezoneX;
			y = PXG_UI_FOOTER_Y;
			w = GUI_W_BTN_M;
			h = GUI_H_BTN;
		};
		class armoryButtonCloseDialog: PxgGuiRscButton
		{
			idc = 431601;
			action = "closeDialog 2;";
			text = "Close";
			x = PXG_UI_MAIN_X;
			y = PXG_UI_FOOTER_Y;
			w = GUI_W_BTN_M;
			h = GUI_H_BTN;
		};
		class armoryButtonOpacity: PxgGuiRscButton
		{
			idc = IDC_UI_OPACITY_TOGGLE;
			action = "[ctrlParent (_this select 0), 'toggle'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
			text = GUI_STR_OPACITY;
			tooltip = "Toggle Background Opacity";
			colorText[] = GUI_COLOR_UI_GREY;
			x = 0.250 * safezoneW + safezoneX;
			y = PXG_UI_FOOTER_Y;
			w = GUI_W_BTN_S;
			h = GUI_H_BTN;
		};

		// --- MODULAR PANEL ---
		class armoryModularPanel: PxgGuiBackground
		{
			idc = IDC_ARMORY_MODULAR_PANEL;
			show = 0;
			colorBackground[] = PXG_COLOR_BG; 
			x = PXG_UI_EXT_X;
			y = PXG_UI_MAIN_Y;
			w = PXG_UI_EXT_W;
			h = PXG_UI_MAIN_H;
		};
		class armoryModularHeader: PxgGuiRscStructuredText
		{
			idc = IDC_ARMORY_MODULAR_HEADER;
			show = 0;
			text = "<t align='center'>MODULAR OPTIONS</t>";
			x = PXG_UI_EXT_X;
			y = PXG_UI_HEADER_Y;
			w = PXG_UI_EXT_W;
			h = PXG_UI_HEADER_H;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class armoryWeaponText: PxgGuiRscText
		{
			idc = IDC_ARMORY_WEAPON_TEXT;
			show = 0;
			text = "Primary Weapon";
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.2015 * safezoneH + safezoneY; 
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.02 * safezoneH; 
		};
		class armoryWeaponList: PxgGuiRscListBox
		{
			idc = IDC_ARMORY_WEAPON_LIST;
			show = 0;
			colorBackground[] = PXG_COLOR_BG_DARK;
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.2315 * safezoneH + safezoneY; 
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.16 * safezoneH;
			sizeEx = PXG_UI_LIST_TEXT_SIZE;
			rowHeight = PXG_UI_LIST_ROW_HEIGHT;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Modular_Lists.sqf'";
		};
		class armorySightText: PxgGuiRscText
		{
			idc = IDC_ARMORY_SIGHT_TEXT;
			show = 0;
			text = "Optics / Sights";
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.4015 * safezoneH + safezoneY;
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.02 * safezoneH;
		};
		class armorySightList: PxgGuiRscListBox
		{
			idc = IDC_ARMORY_SIGHT_LIST;
			show = 0;
			colorBackground[] = PXG_COLOR_BG_DARK;
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.4315 * safezoneH + safezoneY; 
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.15 * safezoneH;
			sizeEx = PXG_UI_LIST_TEXT_SIZE;
			rowHeight = PXG_UI_LIST_ROW_HEIGHT;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Update_Preview.sqf'";
		};
		class armoryPreviewBackground: PxgGuiBackground
		{
			idc = IDC_ARMORY_PREVIEW_BACKGROUND;
			show = 0;
			colorBackground[] = PXG_COLOR_PREVIEW; 
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.6015 * safezoneH + safezoneY; 
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.197 * safezoneH; 
		};
		class armoryPreviewPicture: PxgGuiRscPicture
		{
			idc = IDC_ARMORY_PREVIEW_PICTURE;
			style = 48; // ST_PICTURE (Force Stretch)
			show = 0;
			text = "#(argb,512,512,1)r2t(pxg_armory_pip,2.2)";
			x = PXG_UI_EXT_X + (0.01 * safezoneW);
			y = 0.6015 * safezoneH + safezoneY; 
			w = PXG_UI_EXT_W - (0.02 * safezoneW);
			h = 0.197 * safezoneH;
		};
	};
};