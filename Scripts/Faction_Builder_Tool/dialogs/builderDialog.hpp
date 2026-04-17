#include "builderStyles.hpp"

class FBT_Dialog {
	idd = 456000;
	movingEnable = false;
	onUnload = "execVM 'Scripts\Faction_Builder_Tool\Functions\Staging\FBT_Cleanup.sqf';";
	
	class controlsBackground {
		class TopTabs_Background: PxgGuiBackground {
			idc = -1;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH * 0.05;
			colorBackground[] = {0.29, 0.42, 0.42, 0.9}; 
		};
		class LeftPanel_Background: PxgGuiBackground {
			idc = 456011;
			x = safezoneX;
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
		class RightPanel_Background: PxgGuiBackground {
			idc = 456021;
			x = safezoneX + (safezoneW * 0.75); 
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
		class BottomPanel_Background: PxgGuiBackground {
			idc = 456032;
			x = safezoneX + (safezoneW * 0.25);
			y = safezoneY + (safezoneH * 0.96);
			w = safezoneW * 0.5;
			h = safezoneH * 0.04;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
		class ExtendedPanel_Background: PxgGuiBackground {
			idc = 456040;
			x = safezoneX + (safezoneW * 0.25); 
			y = safezoneY + (safezoneH * 0.05);
			w = 0; 
			h = safezoneH * 0.95;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
	};
	
	class controls {
		class Tab_Overview: FBT_TabButton {
			idc = 456001;
			text = "OVERVIEW";
			tooltip = "Configure Faction Metadata";
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Overview'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf';";
		};
		class Tab_Armory: FBT_TabButton {
			idc = 456002;
			text = "ARMORY";
			x = safezoneX + (safezoneW * 0.12);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Armory'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf';";
		};
		class Tab_Motorpool: FBT_TabButton {
			idc = 456003;
			text = "MOTORPOOL";
			x = safezoneX + (safezoneW * 0.23);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Motorpool'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf';";
		};
		class Tab_Resupply: FBT_TabButton {
			idc = 456004;
			text = "RESUPPLY";
			x = safezoneX + (safezoneW * 0.34);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Resupply'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_TabSwitch.sqf';";
		};
		class Button_Orbit_Toggle: FBT_ToggleButton {
			idc = 456007; 
			text = "CAMERA ORBIT";
			x = safezoneX + (safezoneW * 0.56);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.13;
			h = safezoneH * 0.03;
			action = "[[], 'orbit_toggle'] execVM 'Scripts\Faction_Builder_Tool\Functions\Camera\FBT_HandleCamera.sqf';";
		};
		class Button_Opacity_Toggle: FBT_ToggleButton {
			idc = 456006;
			text = "TOGGLE OPACITY";
			x = safezoneX + (safezoneW * 0.70);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.13;
			h = safezoneH * 0.03;
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleOpacity.sqf';";
		};
		class Button_Export: FBT_BaseButton {
			idc = 456005;
			text = "EXPORT TO CLIPBOARD";
			x = safezoneX + (safezoneW * 0.84);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			colorBackground[] = {0.2, 0.6, 0.2, 1}; 
			colorBackgroundActive[] = {0.3, 0.8, 0.3, 1}; 
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\Core\FBT_Export_Faction.sqf';";
		};
		class Context_Tree: FBT_BaseTree {
			idc = 456010;
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.07);
			w = safezoneW * 0.23;
			h = safezoneH * 0.82; 
			onTreeSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdatePreview.sqf';";
		};
		class Button_Add_Item: FBT_BaseButton {
			idc = 456012;
			text = "[+]";
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_AddItem.sqf';";
		};
		class Button_Duplicate_Item: FBT_BaseButton {
			idc = 456014;
			text = "[D]";
			x = safezoneX + (safezoneW * 0.09);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			colorBackground[] = {0.2, 0.4, 0.4, 0.8};
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_DuplicateItem.sqf';";
		};
		class Button_Delete_Item: FBT_BaseButton {
			idc = 456013;
			text = "[-]";
			x = safezoneX + (safezoneW * 0.17);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			colorBackground[] = {0.6, 0.2, 0.2, 0.8};
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_DeleteItem.sqf';";
		};

		class Group_OverviewControls: RscControlsGroupNoScrollbars {
			idc = 456050;
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.07);
			w = safezoneW * 0.23;
			h = safezoneH * 0.85;
			show = 0; 
			class controls {
				class Label_Side: FBT_BaseText {
					text = "SIDE";
					x = 0; y = 0; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Side: FBT_BaseCombo {
					idc = 456051;
					x = 0; y = 0.035 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Side'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf';";
				};
				class Label_Faction: FBT_BaseText {
					text = "FACTION";
					x = 0; y = 0.08 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Faction: FBT_BaseCombo {
					idc = 456052;
					x = 0; y = 0.115 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Faction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf';";
				};
				class Label_Subfaction: FBT_BaseText {
					text = "SUBFACTION";
					x = 0; y = 0.16 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Subfaction: FBT_BaseCombo {
					idc = 456053;
					x = 0; y = 0.195 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Subfaction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf';";
				};
				class Label_Camo: FBT_BaseText {
					text = "CAMO";
					x = 0; y = 0.24 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Camo: FBT_BaseCombo {
					idc = 456054;
					x = 0; y = 0.275 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Camo'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf';";
				};
				class Label_Era: FBT_BaseText {
					text = "ERA";
					x = 0; y = 0.32 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Era: FBT_BaseCombo {
					idc = 456055;
					x = 0; y = 0.355 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Era'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateDropdowns.sqf';";
				};
				class Button_Duplicate: FBT_BaseButton {
					idc = 456056;
					text = "DUPLICATE";
					x = 0; y = 0.45 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					action = "[true] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf';";
				};
			};
		};

		class Group_ExtendedControls: RscControlsGroupNoScrollbars {
			idc = 456060;
			x = safezoneX + (safezoneW * 0.26); 
			y = safezoneY + (safezoneH * 0.07);
			w = 0; 
			h = safezoneH * 0.85;
			show = 0;
			class controls {
				class Label_Ext_Title: FBT_BaseText {
					text = "NEW ELEMENT NAME";
					x = 0; y = 0; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
				};
				class Edit_NewName: FBT_BaseEdit {
					idc = 456061;
					x = 0; y = 0.035 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
				};
				class Button_ConfirmAdd: FBT_BaseButton {
					text = "CONFIRM";
					x = 0; y = 0.08 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
					colorBackground[] = {0.2, 0.6, 0.2, 1};
					action = "execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ConfirmAction.sqf';";
				};
				class Button_CancelAdd: FBT_BaseButton {
					text = "CANCEL";
					x = 0; y = 0.12 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
					action = "[false] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf';";
				};
			};
		};

		class Group_RightPanel: RscControlsGroupNoScrollbars {
			idc = 456100;
			x = safezoneX + (safezoneW * 0.75);
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			show = 0; 
			class controls {
				class Category_List: PxgGuiRscListBox {
					idc = 456070;
					x = safezoneW * 0.005; y = safezoneH * 0.007; w = safezoneW * 0.03; h = safezoneH * 0.943;
					onLBSelChanged = "['CategoryChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleCategory.sqf';";
				};
				class Search_Gear: FBT_BaseEdit {
					idc = 456022;
					x = safezoneW * 0.04; y = safezoneH * 0.007; w = safezoneW * 0.06; h = safezoneH * 0.03;
					onKeyUp = "['SearchChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleCategory.sqf';";
				};
				class Combo_Variants: PxgGuiRscCombo {
					idc = 456023;
					x = safezoneW * 0.102; y = safezoneH * 0.007; w = safezoneW * 0.038; h = safezoneH * 0.03;
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_HandleVariants.sqf';";
				};
				class Right_Listbox: FBT_BaseList {
					idc = 456020;
					x = safezoneW * 0.04; y = safezoneH * 0.04; w = safezoneW * 0.10; h = safezoneH * 0.83;
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_ApplyGear.sqf';";
				};
				class Label_Slots: FBT_BaseText {
					text = "SLOTS & CONTENTS";
					x = safezoneW * 0.145; y = safezoneH * 0.007; w = safezoneW * 0.10; h = safezoneH * 0.03;
					colorBackground[] = {0.29, 0.42, 0.42, 0.4};
				};
				class Slot_Listbox: FBT_BaseList {
					idc = 456080;
					x = safezoneW * 0.145; y = safezoneH * 0.04; w = safezoneW * 0.10; h = safezoneH * 0.77; 
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleSlotClick.sqf';";
				};
				class Edit_Amount: FBT_BaseEdit {
					idc = 456081;
					text = "1"; 
					x = safezoneW * 0.175; y = safezoneH * 0.82; w = safezoneW * 0.02; h = safezoneH * 0.03;
					onKeyUp = "execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_CalcMass.sqf';";
				};
				class Text_Mass: FBT_BaseText {
					idc = 456082;
					text = "MASS: 0.0";
					x = safezoneW * 0.20; y = safezoneH * 0.82; w = safezoneW * 0.045; h = safezoneH * 0.03;
					colorText[] = {0.3, 0.8, 0.3, 1};
				};
			};
		};

		class Inventory_Text: FBT_BaseText {
			idc = 456030;
			text = "INVENTORY PREVIEW";
			x = safezoneX + (safezoneW * 0.26); y = safezoneY + (safezoneH * 0.965); w = safezoneW * 0.40; h = safezoneH * 0.03;
		};
		class Button_Collapse_Inventory: FBT_BaseButton {
			idc = 456031;
			text = "[+]";
			x = safezoneX + (safezoneW * 0.72); y = safezoneY + (safezoneH * 0.965); w = safezoneW * 0.02; h = safezoneH * 0.03;
			colorBackground[] = {0.35, 0.45, 0.45, 0.9};
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleInventory.sqf';";
		};
	};
};
