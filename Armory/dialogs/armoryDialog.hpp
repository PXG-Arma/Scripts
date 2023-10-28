class armoryDialog
{
	idd = 431234;

	class controls
	{	
		class armoryBaseFrame: PxgGuiBackground
		{
			idc = -1;

			x = 0.36 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.60 * safezoneW;
			h = 0.52 * safezoneH;
		};
		
		 class primaryPreview: RscPicture
		{
			idc = 431007;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class primaryPreviewButton: PxgGuiHiddenButton
		{
			idc = 431008;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "";

			action = "[431008] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class primaryMuzzlePreview: RscPicture
		{
			idc = 431009;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class primaryMuzzlePreviewButton: PxgGuiHiddenButton
		{
			idc = 431010;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431010] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class primaryGripPreview: RscPicture
		{
			idc = 431011;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class primaryGripPreviewButton: PxgGuiHiddenButton
		{
			idc = 431012;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431012] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class primaryLightPreview: RscPicture
		{
			idc = 431013;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class primaryLightPreviewButton: PxgGuiHiddenButton
		{
			idc = 431014;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431014] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};


		class primaryScopePreview: RscPicture
		{
			idc = 431015;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class primaryScopePreviewButton: PxgGuiHiddenButton
		{
			idc = 431016;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.392 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431016] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};


		 class LauncherPreview: RscPicture
		{
			idc = 431017;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class LauncherPreviewButton: PxgGuiHiddenButton
		{
			idc = 431018;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "";

			action = "[431018] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};


		class LauncherMuzzlePreview: RscPicture
		{
			idc = 431019;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class LauncherMuzzlePreviewButton: PxgGuiHiddenButton
		{
			idc = 431020;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431020] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class LauncherGripPreview: RscPicture
		{
			idc = 431021;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class LauncherGripPreviewButton: PxgGuiHiddenButton
		{
			idc = 431022;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431022] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class LauncherLightPreview: RscPicture
		{
			idc = 431023;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class LauncherLightPreviewButton: PxgGuiHiddenButton
		{
			idc = 431024;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431024] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class LauncherScopePreview: RscPicture
		{
			idc = 431025;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class LauncherScopePreviewButton: PxgGuiHiddenButton
		{
			idc = 431026;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.552 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431026] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};



		class BinocularsPreview: RscPicture
		{
			idc = 431027;

			x = 0.78 * safezoneW + safezoneX;
			y = 0.40 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.08 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class BinocularsPreviewButton: PxgGuiHiddenButton
		{
			idc = 431028;

			x = 0.78 * safezoneW + safezoneX;
			y = 0.40 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.08 * safezoneH;
			text = "";

			action = "[431028] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class NightVisionPreview: RscPicture
		{
			idc = 431029;

			x = 0.78 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.08 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class NightVisionPreviewButton: PxgGuiHiddenButton
		{
			idc = 431030;

			x = 0.78 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.08 * safezoneH;
			text = "";

			action = "[431030] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class SecondaryPreview: RscPicture
		{
			idc = 431031;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class SecondaryPreviewButton: PxgGuiHiddenButton
		{
			idc = 431032;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.10 * safezoneH;
			text = "";

			action = "[431032] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};


		class SecondaryMuzzlePreview: RscPicture
		{
			idc = 431033;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class SecondaryMuzzlePreviewButton: PxgGuiHiddenButton
		{
			idc = 431034;

			x = 0.64 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431034] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class SecondaryGripPreview: RscPicture
		{
			idc = 431035;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class SecondaryGripPreviewButton: PxgGuiHiddenButton
		{
			idc = 431036;

			x = 0.662 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431036] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class SecondaryLightPreview: RscPicture
		{
			idc = 431037;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class SecondaryLightPreviewButton: PxgGuiHiddenButton
		{
			idc = 431038;

			x = 0.684 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431038] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};

		class SecondaryScopePreview: RscPicture
		{
			idc = 431039;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_InvisibleBarrier_F.jpg";

		};

		class SecondaryScopePreviewButton: PxgGuiHiddenButton
		{
			idc = 431040;

			x = 0.706 * safezoneW + safezoneX;
			y = 0.712 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";

			action = "[431040] call compile preprocessfile 'Scripts\Armory\Functions\PXG_ButtonPress.sqf'";

		};
		

		class armoryAccesoryList: PxgGuiRscTree
		{
			idc = 431041;

			x = 0.83 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.42 * safezoneH;

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_selectCustomisation.sqf'";

		};


		class armoryAccesoryText: PxgGuiRscText
		{
			idc = 431042;

			text = "4. Customise"; //--- ToDo: Localize;
			x = 0.85 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.04 * safezoneH;
		};
		
		class armoryStructuredText: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "Armory"; //--- ToDo: Localize;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.227 * safezoneH + safezoneY;
			w = 0.60 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class armorySideText: PxgGuiRscText
		{
			idc = 431004;
			text = "1. Side"; //--- ToDo: Localize;
			x = 0.37 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryFactionsText: PxgGuiRscText
		{
			idc = 431000;

			text = "2. Faction"; //--- ToDo: Localize;
			x = 0.37 * safezoneW + safezoneX;
			y = 0.382 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryLoadoutsText: PxgGuiRscText
		{
			idc = 431001;

			text = "3. Loadout"; //--- ToDo: Localize;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.04 * safezoneH;

		};
		class armorySideList: PxgGuiRscListBox
		{
			idc = 431500;
			x = 0.37 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.067 * safezoneH;

			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Factions.sqf'";
		};
		class armoryFactionList: PxgGuiRscTree
		{
			idc = 431501;

			x = 0.37 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.29 * safezoneH;

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf'";

		};
		class armoryLoadoutList: PxgGuiRscTree
		{
			idc = 431503;

			x = 0.51 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.41 * safezoneH;

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Preview_loadout.sqf'";

		};
		class armoryButtonGetLoadout: PxgGuiRscButton
		{
			idc = 431600;
			action = "[execVM ""Scripts\Armory\Functions\PXG_Request_Loadout.sqf""]";

			text = "Get Loadout"; //--- ToDo: Localize;

			x = 0.58 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryButtonCloseDialog: PxgGuiRscButton
		{
			idc = 431601;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.36 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};