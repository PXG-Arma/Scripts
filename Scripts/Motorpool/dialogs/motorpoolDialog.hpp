class dialog_motorpool
{
	idd = 461922;
	onLoad = "[_this select 0, 'init'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
	class controls
	{
		
		class RscFrame_1: PxgGuiBackground
		{
			idc = 461006;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8}; 

			x = 0.185 * safezoneW + safezoneX;
			y = 0.1685 * safezoneH + safezoneY; // Centered
			w = 0.63 * safezoneW;
			h = 0.663 * safezoneH; // +30% Height
		};
		
		class RscStructuredText_1: PxgGuiRscStructuredText
		{
			idc = 1100;
			text = "<t align='center'>VEHICLE SPAWN</t>"; // Centered and All Caps
			x = 0.185 * safezoneW + safezoneX;
			y = 0.1455 * safezoneH + safezoneY; // y - 0.023
			w = 0.63 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class motorpoolSideText: PxgGuiRscText
		{
			idc = -1;

			text = "1. Side";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class motorpoolFactionText: PxgGuiRscText
		{
			idc = -1; 

			text = "2. Faction";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.3085 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class motorpoolCamoText: PxgGuiRscText
		{
			idc = 461506;

			text = "3. Camo [Era]";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.5585 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};

		class motorpoolVehicleText: PxgGuiRscText
		{
			idc = -1; 

			text = "4. Vehicle";
			x = 0.40 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class motorpoolSpawnText: PxgGuiRscText
		{
			idc = -1; 

			text = "5. Spawn Point";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class dim_vehicle_spawnpoint_list: PxgGuiRscListBox
		{
			idc = 461500;

			x = 0.605 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.15 * safezoneH;
		};
	
		class dim_vehicle_list: PxgGuiRscTree
		{
			idc = 461502;
			onTreeSelChanged = "call compile preprocessfile 'Scripts\Motorpool\Functions\PXG_Refresh_Preview.sqf'";

			x = 0.40 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.567 * safezoneH; 
		};
	
		class dim_vehicle_faction_list: PxgGuiRscTree
		{
			idc = 461501;
			onTreeSelChanged = "[_this select 0, 461507, 'Scripts\Motorpool\Functions\PXG_Refresh_Vehicles.sqf', 'PXG_Motorpool_Memory_Camo'] call compile preprocessfile 'Scripts\Factions\PXG_Refresh_Camos.sqf'";
			onTreeExpanded = "_this spawn { params ['_ctrl', '_path']; sleep 0.05; if (count _path == 1) then { private _sel = tvCurSel _ctrl; _ctrl tvSetCurSel [-1]; for '_i' from 0 to ((_ctrl tvCount _path) - 1) do { _ctrl tvCollapse (_path + [_i]); _ctrl tvExpand (_path + [_i]); }; if (count _sel > 0) then { _ctrl tvSetCurSel _sel; }; }; };";

			x = 0.195 * safezoneW + safezoneX;
			y = 0.3385 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.210 * safezoneH; 
		};

		class motorpoolCamoList: PxgGuiRscListbox
		{
			idc = 461507;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Motorpool\Functions\PXG_Refresh_Vehicles.sqf'";
			
			x = 0.195 * safezoneW + safezoneX;
			y = 0.5885 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.210 * safezoneH;

			sizeEx = 0.018 * safezoneH;
			rowHeight = 1.8 * 0.018 * safezoneH;
		};
		
		class dim_vehicle_faction_side_list: PxgGuiRscListbox
		{
			idc = 461504;
			onLBSelChanged = "call compile preprocessfile 'Scripts\Motorpool\Functions\PXG_Refresh_Factions.sqf'";
			
			x = 0.195 * safezoneW + safezoneX;
			y = 0.2315 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.067 * safezoneH;
		};
		class motorpoolPreviewPicture: PxgGuiRscPicture
		{
			idc = 461505; 

			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.4215 * safezoneH + safezoneY; 
			w = 0.20 * safezoneW;
			h = 0.377 * safezoneH;
		};
		class motorpoolCargoText: PxgGuiRscText
		{
			idc = 461499;

			text = "Cargo Capacity: 0";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class motorpoolSeatsText: PxgGuiRscText
		{
			idc = 461498;

			text = "Crew: 0 Passengers: 0";
			x = 0.705 * safezoneW + safezoneX;
			y = 0.3915 * safezoneH + safezoneY; 
			w = 0.10 * safezoneW;
			h = 0.02 * safezoneH;
		};
	
		class dim_vehicle_spawn_button: PxgGuiRscButton
		{
			idc = 461600;
			action = "execVM 'Scripts\Motorpool\Functions\PXG_Spawn_Vehicle.sqf'";

			text = "Spawn"; //--- ToDo: Localize;
			
			x = 0.755 * safezoneW + safezoneX;
			y = 0.8315 * safezoneH + safezoneY; // 0.913 - 0.0815
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class motorpoolButtonCloseDialog: PxgGuiRscButton
		{
			idc = 461602;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.185 * safezoneW + safezoneX;
			y = 0.8315 * safezoneH + safezoneY; // 0.913 - 0.0815
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class motorpoolButtonOpacity: PxgGuiRscButton
		{
			idc = 400001;
			action = "[ctrlParent (_this select 0), 'toggle'] execVM 'Scripts\Misc\PXG_Handle_Opacity.sqf';";
			text = "[ * ]";
			tooltip = "Toggle Background Opacity";
			x = 0.250 * safezoneW + safezoneX;
			y = 0.8315 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};