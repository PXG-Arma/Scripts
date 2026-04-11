class armoryDialog
{
	idd = 431234;
	class controls
	{
		class armoryBaseFrame: PxgGuiBackground
		{
			idc = -1;

			x = 0.20 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.60 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class armoryStructuredText: PxgGuiRscStructuredText
		{
			idc = -1;
			text = "Armory"; //--- ToDo: Localize;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.227 * safezoneH + safezoneY;
			w = 0.60 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1 * GUI_GRID_H * GUI_GRID_H;
		};
		class armorySideText: PxgGuiRscText
		{
			idc = 431004;
			text = "Side"; //--- ToDo: Localize;
			x = 0.21 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryFactionsText: PxgGuiRscText
		{
			idc = 431000;

			text = "Faction"; //--- ToDo: Localize;
			x = 0.21 * safezoneW + safezoneX;
			y = 0.382 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryLoadoutsText: PxgGuiRscText
		{
			idc = 431001;

			text = "Role"; //--- ToDo: Localize;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.04 * safezoneH;

		};
		class armorySideList: PxgGuiRscListBox
		{
			idc = 431500;
			x = 0.21 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.067 * safezoneH;

			onLBSelChanged = " call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Factions.sqf'";
		};
		class armoryFactionList: PxgGuiRscTree
		{
			idc = 431501;

			x = 0.21 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.31 * safezoneH;

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Loadouts.sqf'";

		};
		class armoryLoadoutList: PxgGuiRscTree
		{
			idc = 431503;

			x = 0.36 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.43 * safezoneH;

			onTreeSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Weapons.sqf'";
		};
		class armoryWeaponsText: PxgGuiRscText
		{
			idc = 431006;

			text = "Weapons"; //--- ToDo: Localize;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryWeaponList: PxgGuiRscListBox
		{
			idc = 431504;

			x = 0.51 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.19 * safezoneH;

			onLBSelChanged = "call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Scopes.sqf'; [(_this select 0), (_this select 1), 431701] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Update_Preview.sqf'; [(_this select 0), (_this select 1)] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Refresh_Attachments.sqf';";
		};
		class armoryScopesText: PxgGuiRscText
		{
			idc = 431005;

			text = "Scopes"; //--- ToDo: Localize;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.51 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryScopesList: PxgGuiRscListBox
		{
			idc = 431505;
			x = 0.51 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.18 * safezoneH;

			onLBSelChanged = "[(_this select 0), (_this select 1), 431702] call compile preprocessfile 'Scripts\Armory\Functions\PXG_Update_Preview.sqf';";
		};
		class armoryPreviewText: PxgGuiRscText
		{
			idc = 431007;

			text = "Preview (Scope / Weapon)"; //--- ToDo: Localize;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class armoryPreviewFrameScope: PxgGuiRscBrightBox
		{
			idc = -1;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class armoryPreviewScope: PxgGuiRscPicture
		{
			idc = 431702;
			text = "";
			x = 0.65 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class armoryPreviewFrameWeapon: PxgGuiRscBrightBox
		{
			idc = -1;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class armoryPreviewWeapon: PxgGuiRscPicture
		{
			idc = 431701;
			text = "";
			x = 0.65 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.14 * safezoneH;
		};
		// Triple Attachment Previews
		class armoryPreviewFrameMuzzle: PxgGuiRscBrightBox
		{
			idc = -1;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryPreviewMuzzle: PxgGuiRscPicture
		{
			idc = 431703;
			text = "";
			x = 0.65 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryPreviewFrameRail: PxgGuiRscBrightBox
		{
			idc = -1;
			x = 0.698 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryPreviewRail: PxgGuiRscPicture
		{
			idc = 431704;
			text = "";
			x = 0.698 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryPreviewFrameUnder: PxgGuiRscBrightBox
		{
			idc = -1;
			x = 0.746 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryPreviewUnder: PxgGuiRscPicture
		{
			idc = 431705;
			text = "";
			x = 0.746 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class armoryButtonGetLoadout: PxgGuiRscButton
		{
			idc = 431600;
			action = "[execVM ""Scripts\Armory\Functions\PXG_Request_Loadout.sqf""]";

			text = "Get Loadout"; //--- ToDo: Localize;

			x = 0.73 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class armoryButtonCloseDialog: PxgGuiRscButton
		{
			idc = 431601;
			action = "closeDialog 2;";

			text = "Close";

			x = 0.21 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};