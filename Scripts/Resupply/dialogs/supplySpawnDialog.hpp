class dialog_supply_spawn
{
	idd = 451922;
	onLoad = "[_this select 0, 'init'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by J. Dimlight, v1.063, #Xinebe)
		////////////////////////////////////////////////////////

		class RscFrame_1: PxgGuiBackground
		{
			idc = 451006;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8}; 

			x = 0.185 * safezoneW + safezoneX;
			y = 0.1815 * safezoneH + safezoneY; // Centered
			w = 0.63 * safezoneW;
			h = 0.637 * safezoneH; // +30% Height
		};
		
		class RscStructuredText_1: PxgGuiRscStructuredText
		{
			idc = -1;

			text = "<t align='center'>SUPPLY SPAWN</t>"; // Centered and All Caps
			x = 0.185 * safezoneW + safezoneX;
			y = 0.1585 * safezoneH + safezoneY; // y - 0.023
			w = 0.63 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class supplySideText: PxgGuiRscText
		{
			idc = -1;

			text = "1. Side";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class supplyFactionText: PxgGuiRscText
		{
			idc = -1; 

			text = "2. Faction";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.3085 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class supplyCamoText: PxgGuiRscText
		{
			idc = 451507; 

			text = "3. Camo [Era]";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.5585 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class supplyCrateText: PxgGuiRscText
		{
			idc = -1; 

			text = "4. Supply";
			x = 0.40 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; // 0.26 - 0.0685
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class supplySpawnText: PxgGuiRscText
		{
			idc = -1; 

			text = "5. Spawn Point";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; // 0.26 - 0.0685
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class supplyContentsText: PxgGuiRscText
		{
			idc = -1; 

			text = "Crate Content";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class resupplyCrateSpaceValue: PxgGuiRscStructuredText
		{
			idc = 451506; 
			text = "";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.02 * safezoneH;
			colorBackground[] = {0,0,0,0}; 
			class Attributes { align = "right"; };
		};
		class dim_supply_spawnpoint_list: PxgGuiRscListBox
		{
			idc = 451500;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Resupply\Functions\PXG_Resupply_Refresh_Vehicle_Panel.sqf'";

			x = 0.605 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.15 * safezoneH;
		};		
		class dim_supply_cratecontent_list: PxgGuiRscListbox
		{
			idc = 451502;

			x = 0.400 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.567 * safezoneH; // Adjusted to keep bottom

			onLBSelChanged = "call compile preprocessfile 'Scripts\Resupply\Functions\PXG_Resupply_Refresh_Contents.sqf'";
		};
		
		class dim_supply_faction_list: PxgGuiRscTree
		{
			idc = 451501;
			onTreeSelChanged = "[_this select 0, 451508, 'Scripts\Resupply\Functions\PXG_Resupply_Refresh_Supplies.sqf', 'PXG_Resupply_Memory_Camo'] call compile preprocessfile 'Scripts\Factions\PXG_Refresh_Camos.sqf'";
			onTreeExpanded = "_this spawn { params ['_ctrl', '_path']; sleep 0.05; if (count _path == 1) then { private _sel = tvCurSel _ctrl; _ctrl tvSetCurSel [-1]; for '_i' from 0 to ((_ctrl tvCount _path) - 1) do { _ctrl tvCollapse (_path + [_i]); _ctrl tvExpand (_path + [_i]); }; if (count _sel > 0) then { _ctrl tvSetCurSel _sel; }; }; };";

			x = 0.195 * safezoneW + safezoneX;
			y = 0.3385 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.210 * safezoneH; 
		};

		class supplyCamoList: PxgGuiRscListbox
		{
			idc = 451508;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Resupply\Functions\PXG_Resupply_Refresh_Supplies.sqf'";
			
			x = 0.195 * safezoneW + safezoneX;
			y = 0.5885 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.210 * safezoneH;

			sizeEx = 0.018 * safezoneH;
			rowHeight = 1.8 * 0.018 * safezoneH;
		};
		
		class dim_supply_faction_side_list: PxgGuiRscListbox
		{
			idc = 451504;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Resupply\Functions\PXG_Resupply_Refresh_Factions.sqf'";
			
			x = 0.195 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.067 * safezoneH;
		};
		class supplyContentsList: PxgGuiRscStructuredText
		{
			idc = 451505; 

			x = 0.605 * safezoneW + safezoneX;
			y = 0.4215 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.377 * safezoneH; 

			colorBackground[] = {0,0,0,0.3};
		};
		class dim_supply_spawn_button: PxgGuiRscButton
		{
			idc = 451600;
			action = "execVM 'Scripts\Resupply\Functions\PXG_Resupply_Crate_Spawn_Check.sqf'";

			text = "Spawn Crate"; //--- ToDo: Localize;
			
			x = 0.755 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // 0.887 - 0.0685
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};

		class dim_supply_clean_button: PxgGuiRscButton
		{
			idc = 451602;
			action = "execVM 'Scripts\Resupply\Functions\PXG_Resupply_Clean_Pad.sqf'";

			text = "Clean Pad";
			
			x = 0.690 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // 0.887 - 0.0685
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};

		class supplyButtonCloseDialog: PxgGuiRscButton
		{
			idc = 451601;
			action = "closeDialog 2;";

			text = "Close";


			x = 0.185 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // 0.887 - 0.0685
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class supplyButtonOpacity: PxgGuiRscButton
		{
			idc = 400001;
			action = "[ctrlParent (_this select 0), 'toggle'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
			text = "[ * ]";
			tooltip = "Toggle Background Opacity";
			x = 0.250 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.02 * safezoneH;
		};

		// --- CARGO PANEL EXTENSION ---
		class resupplyCargoPanelBackground: PxgGuiBackground
		{
			idc = 451700;
			show = 0;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};

			x = 0.815 * safezoneW + safezoneX; // No padding
			y = 0.1815 * safezoneH + safezoneY; // Centered
			w = 0.18 * safezoneW;
			h = 0.637 * safezoneH;
		};
		class resupplyCargoHeader: PxgGuiRscStructuredText
		{
			idc = 451706;
			show = 0;
			text = "<t align='center' color='#FFFFFF'>VEHICLE CARGO</t>";
			x = 0.815 * safezoneW + safezoneX;
			y = 0.1585 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class resupplyCargoVehicleName: PxgGuiRscText
		{
			idc = 451701;
			show = 0;
			text = "VEHICLE INFO";
			x = 0.820 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY;
			w = 0.170 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1, 0.8, 0, 1};
		};
		class resupplyCargoVehiclePicture: PxgGuiRscPicture
		{
			idc = 451702;
			show = 0;
			text = "";
			x = 0.820 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY;
			w = 0.170 * safezoneW;
			h = 0.15 * safezoneH;
		};
		class resupplyCargoCapacityLabel: PxgGuiRscStructuredText
		{
			idc = 451707;
			show = 0;
			text = "Available Capacity:";
			x = 0.820 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY;
			w = 0.170 * safezoneW;
			h = 0.02 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class resupplyCargoCapacityText: PxgGuiRscStructuredText
		{
			idc = 451703;
			show = 0;
			text = "0 / 0";
			colorBackground[] = {0,0,0,0}; 
			x = 0.820 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY;
			w = 0.170 * safezoneW;
			h = 0.02 * safezoneH;
			class Attributes { align = "right"; };
		};
		class resupplyCargoManifestList: PxgGuiRscListBox
		{
			idc = 451704;
			show = 0;
			x = 0.820 * safezoneW + safezoneX;
			y = 0.4215 * safezoneH + safezoneY;
			w = 0.170 * safezoneW;
			h = 0.39 * safezoneH; // Shrunk slightly for button
			sizeEx = 0.03;
		};
		class resupplyCargoDeleteButton: PxgGuiRscButton
		{
			idc = 451705;
			show = 0;
			action = "call compile preprocessFile 'Scripts\Resupply\Functions\PXG_Resupply_Crate_Unload.sqf'";
			text = "Unload";
			
			x = 0.935 * safezoneW + safezoneX; // End of expanded panel
			y = 0.8185 * safezoneH + safezoneY; // Centered
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};