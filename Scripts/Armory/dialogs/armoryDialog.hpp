class armoryDialog
{
	idd = 431234;
	class controls
	{
		class armoryBaseFrame: PxgGuiBackground
		{
			idc = -1;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8}; // Added 80% opacity background

			x = 0.185 * safezoneW + safezoneX;
			y = 0.1815 * safezoneH + safezoneY; // Centered
			w = 0.63 * safezoneW;
			h = 0.637 * safezoneH; // +30% Height
		};
		class armoryStructuredText: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "<t align='center'>ARMORY</t>"; // Centered and All Caps
			x = 0.185 * safezoneW + safezoneX;
			y = 0.1585 * safezoneH + safezoneY; // y - 0.023
			w = 0.63 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class armorySideText: PxgGuiRscText
		{
			idc = 431004;
			text = "1. Side"; //--- ToDo: Localize;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; // 0.26 - 0.0685
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryFactionsText: PxgGuiRscText
		{
			idc = 431000;

			text = "2. Faction"; //--- ToDo: Localize;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.3135 * safezoneH + safezoneY; // 0.382 - 0.0685
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryLoadoutsText: PxgGuiRscText
		{
			idc = 431001;

			text = "3. Loadout"; //--- ToDo: Localize;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.1915 * safezoneH + safezoneY; // 0.26 - 0.0685
			w = 0.10 * safezoneW;
			h = 0.04 * safezoneH;

		};
		class armorySideList: PxgGuiRscListBox
		{
			idc = 431500;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.2415 * safezoneH + safezoneY; // 0.31 - 0.0685
			w = 0.29 * safezoneW;
			h = 0.067 * safezoneH;

			onLBSelChanged = " call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Factions.sqf'";
		};
		class armoryFactionList: PxgGuiRscTree
		{
			idc = 431501;

			x = 0.20 * safezoneW + safezoneX;
			y = 0.3615 * safezoneH + safezoneY; // 0.43 - 0.0685
			w = 0.29 * safezoneW;
			h = 0.437 * safezoneH; // Stretched

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf'";
			onTreeExpanded = "_this spawn { params ['_ctrl', '_path']; sleep 0.05; if (count _path == 1) then { private _sel = tvCurSel _ctrl; _ctrl tvSetCurSel [-1]; for '_i' from 0 to ((_ctrl tvCount _path) - 1) do { _ctrl tvCollapse (_path + [_i]); _ctrl tvExpand (_path + [_i]); }; if (count _sel > 0) then { _ctrl tvSetCurSel _sel; }; }; };";
		};
		class armoryLoadoutList: PxgGuiRscTree
		{
			idc = 431503;

			x = 0.51 * safezoneW + safezoneX;
			y = 0.2415 * safezoneH + safezoneY; // 0.31 - 0.0685
			w = 0.29 * safezoneW;
			h = 0.557 * safezoneH; // Stretched

		};
		class armoryButtonGetLoadout: PxgGuiRscButton
		{
			idc = 431600;
			action = "[execVM ""Scripts\Armory\Functions\PXG_Request_Loadout.sqf""]";

			text = "Get Loadout"; //--- ToDo: Localize;

			x = 0.71 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // 0.887 - 0.0685
			w = 0.09 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryButtonCloseDialog: PxgGuiRscButton
		{
			idc = 431601;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.185 * safezoneW + safezoneX;
			y = 0.8185 * safezoneH + safezoneY; // 0.887 - 0.0685
			w = 0.09 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};