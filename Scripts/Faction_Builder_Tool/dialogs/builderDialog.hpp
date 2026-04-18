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
		class Button_Isolate_Toggle: FBT_ToggleButton {
			idc = 456008; 
			text = "ISOLATE UNIT";
			tooltip = "Show only the selected role while in the Armory";
			x = safezoneX + (safezoneW * 0.45);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.10;
			h = safezoneH * 0.03;
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleIsolation.sqf';";
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
					x = 0; y = 0.45 * safezoneH; w = 0.11 * safezoneW; h = 0.03 * safezoneH;
					action = "['DuplicateFaction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf';";
				};
				class Button_New: FBT_BaseButton {
					idc = 456057;
					text = "CREATE NEW";
					x = 0.12 * safezoneW; y = 0.45 * safezoneH; w = 0.11 * safezoneW; h = 0.03 * safezoneH;
					colorBackground[] = {0.2, 0.6, 0.2, 1};
					action = "['NewFaction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ToggleExtended.sqf';";
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
				// --- SIDE ---
				class Ext_Label_Side: FBT_BaseText {
					text = "SIDE";
					x = 0; y = 0; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Ext_Combo_Side: FBT_BaseCombo {
					idc = 456151;
					x = 0; y = 0.035 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Side'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf';";
				};

				// --- FACTION ---
				class Ext_Label_Faction: FBT_BaseText {
					text = "FACTION";
					x = 0; y = 0.08 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Ext_Combo_Faction: FBT_BaseCombo {
					idc = 456152;
					x = 0; y = 0.115 * safezoneH; w = 0.13 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Faction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf';";
				};
				class Ext_Edit_Faction: FBT_BaseEdit {
					idc = 456172;
					x = 0.14 * safezoneW; y = 0.115 * safezoneH; w = 0.09 * safezoneW; h = 0.03 * safezoneH;
					show = 0;
				};

				// --- SUBFACTION ---
				class Ext_Label_Subfaction: FBT_BaseText {
					text = "SUBFACTION";
					x = 0; y = 0.16 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Ext_Combo_Subfaction: FBT_BaseCombo {
					idc = 456153;
					x = 0; y = 0.195 * safezoneH; w = 0.13 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Subfaction'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf';";
				};
				class Ext_Edit_Subfaction: FBT_BaseEdit {
					idc = 456173;
					x = 0.14 * safezoneW; y = 0.195 * safezoneH; w = 0.09 * safezoneW; h = 0.03 * safezoneH;
					show = 0;
				};

				// --- CAMO ---
				class Ext_Label_Camo: FBT_BaseText {
					text = "CAMO";
					x = 0; y = 0.24 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Ext_Combo_Camo: FBT_BaseCombo {
					idc = 456154;
					x = 0; y = 0.275 * safezoneH; w = 0.13 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Camo'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf';";
				};
				class Ext_Edit_Camo: FBT_BaseEdit {
					idc = 456174;
					x = 0.14 * safezoneW; y = 0.275 * safezoneH; w = 0.09 * safezoneW; h = 0.03 * safezoneH;
					show = 0;
				};

				// --- ERA ---
				class Ext_Label_Era: FBT_BaseText {
					text = "ERA";
					x = 0; y = 0.32 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Ext_Combo_Era: FBT_BaseCombo {
					idc = 456155;
					x = 0; y = 0.355 * safezoneH; w = 0.13 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Era'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_UpdateExtendedDropdowns.sqf';";
				};
				class Ext_Edit_Era: FBT_BaseEdit {
					idc = 456175;
					x = 0.14 * safezoneW; y = 0.355 * safezoneH; w = 0.09 * safezoneW; h = 0.03 * safezoneH;
					show = 0;
				};

				class Button_ConfirmAdd: FBT_BaseButton {
					idc = 456162;
					text = "CONFIRM";
					x = 0; y = 0.45 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					colorBackground[] = {0.2, 0.6, 0.2, 1};
					action = "execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_ConfirmAction.sqf';";
				};
				class Button_CancelAdd: FBT_BaseButton {
					text = "CANCEL";
					x = 0; y = 0.49 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
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
				// --- TOP SECTION (Primary Selection) ---
				class Search_Gear: FBT_BaseEdit {
					idc = 456022;
					x = safezoneW * 0.005; y = safezoneH * 0.007; w = safezoneW * 0.24; h = safezoneH * 0.03;
					onKeyUp = "['SearchChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleCategory.sqf';";
				};
				class Category_List: PxgGuiRscListBox {
					idc = 456070;
					x = safezoneW * 0.005; y = safezoneH * 0.045; w = safezoneW * 0.05; h = safezoneH * 0.42;
					rowHeight = 0.05 * safezoneH;
					sizeEx = 0; 
					onLBSelChanged = "['CategoryChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleCategory.sqf';";
				};
				class Right_Listbox: FBT_BaseList {
					idc = 456020;
					x = safezoneW * 0.06; y = safezoneH * 0.045; w = safezoneW * 0.185; h = safezoneH * 0.38;
					onLBSelChanged = "['CategorySelected'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleCategory.sqf';";
				};
				class Combo_Variants: PxgGuiRscCombo {
					idc = 456023;
					x = safezoneW * 0.06; y = safezoneH * 0.43; w = safezoneW * 0.185; h = safezoneH * 0.03;
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_HandleVariants.sqf';";
					show = 0; 
				};

				// --- BOTTOM SECTION (Configuration/Slots) ---
				class Search_Slot_Gear: FBT_BaseEdit {
					idc = 456091; // New IDC for bottom search
					x = safezoneW * 0.005; y = safezoneH * 0.485; w = safezoneW * 0.24; h = safezoneH * 0.03;
					tooltip = "Search compatible items";
					onKeyUp = "['SlotSearchChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleSlotClick.sqf';";
				};
				class Slot_Listbox: PxgGuiRscListBox {
					idc = 456080;
					x = safezoneW * 0.005; y = safezoneH * 0.52; w = safezoneW * 0.05; h = safezoneH * 0.38; 
					rowHeight = 0.05 * safezoneH;
					sizeEx = 0; 
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\UI\FBT_HandleSlotClick.sqf';";
				};
				class Slot_Items_List: FBT_BaseList {
					idc = 456090; // New IDC for slot items selection
					x = safezoneW * 0.06; y = safezoneH * 0.52; w = safezoneW * 0.185; h = safezoneH * 0.38;
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_ApplyGear.sqf';";
				};

				// --- FOOTER (Stats & Utils) ---
				class Label_Amount: FBT_BaseText {
					text = "AMOUNT:";
					x = safezoneW * 0.005; y = safezoneH * 0.91; w = safezoneW * 0.05; h = safezoneH * 0.03;
				};
				class Edit_Amount: FBT_BaseEdit {
					idc = 456081;
					text = "1"; 
					x = safezoneW * 0.055; y = safezoneH * 0.91; w = safezoneW * 0.03; h = safezoneH * 0.03;
					onKeyUp = "execVM 'Scripts\Faction_Builder_Tool\Functions\Armory\FBT_CalcMass.sqf';";
				};
				class Text_Mass: FBT_BaseText {
					idc = 456082;
					text = "MASS: 0.0";
					x = safezoneW * 0.09; y = safezoneH * 0.91; w = safezoneW * 0.155; h = safezoneH * 0.03;
					colorText[] = {0.3, 0.8, 0.3, 1};
					style = 2; // ST_RIGHT
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
