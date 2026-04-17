#include "builderStyles.hpp"

class PXG_Builder_Dialog {
	idd = 456000;
	movingEnable = false;
	onUnload = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_Cleanup.sqf';";
	
	class controlsBackground {
		
		// --- Top Tabs Area ---
		class TopTabs_Background: PxgGuiBackground {
			idc = -1;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH * 0.05;
			colorBackground[] = {0.29, 0.42, 0.42, 0.9}; // Tactical Dark Teal
		};
		
		// --- Left Panel (Context Tree) ---
		class LeftPanel_Background: PxgGuiBackground {
			idc = 456011;
			x = safezoneX;
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
		
		// --- Right Panel (Configuration) ---
		class RightPanel_Background: PxgGuiBackground {
			idc = 456021;
			x = safezoneX + (safezoneW * 0.75); // Exactly 1/4 of the screen
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};
		// --- Bottom Panel (Inventory) ---
		class BottomPanel_Background: PxgGuiBackground {
			idc = 456032;
			x = safezoneX + (safezoneW * 0.25);
			y = safezoneY + (safezoneH * 0.75);
			w = safezoneW * 0.5;
			h = safezoneH * 0.25;
			colorBackground[] = {0.1, 0.1, 0.1, 0.8};
		};

		// --- Extended Panel (Duplicate/Add) ---
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
		
		// --- Top Tabs ---
		class Tab_Overview: PXG_Builder_TabButton {
			idc = 456001;
			text = "OVERVIEW";
			tooltip = "Configure Faction Metadata (Name, Camo, Era)";
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Overview'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_TabSwitch.sqf';";
		};
		
		class Tab_Armory: PXG_Builder_TabButton {
			idc = 456002;
			text = "ARMORY";
			tooltip = "Configure Infantry Roles and Loadouts";
			x = safezoneX + (safezoneW * 0.12);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Armory'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_TabSwitch.sqf';";
		};
		
		class Tab_Motorpool: PXG_Builder_TabButton {
			idc = 456003;
			text = "MOTORPOOL";
			tooltip = "Configure and Texture Land, Air, and Sea Vehicles";
			x = safezoneX + (safezoneW * 0.23);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Motorpool'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_TabSwitch.sqf';";
		};
		
		class Tab_Resupply: PXG_Builder_TabButton {
			idc = 456004;
			text = "RESUPPLY";
			tooltip = "Auto-Fill or Manual Supply Crate Generation";
			x = safezoneX + (safezoneW * 0.34);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;
			action = "['Resupply'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_TabSwitch.sqf';";
		};

		// Orbit Toggle Button
		class Button_Orbit_Toggle: PXG_Builder_ToggleButton {
			idc = 456007; 
			text = "CAMERA ORBIT";
			tooltip = "Enable or disable the cinematic camera rotation around the target.";
			x = safezoneX + (safezoneW * 0.56);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.13;
			h = safezoneH * 0.03;
			action = "[[], 'orbit_toggle'] execVM 'Scripts\Misc\PXG_Handle_Camera.sqf';";
		};

		// Opacity Toggle Button
		class Button_Opacity_Toggle: PXG_Builder_ToggleButton {
			idc = 456006;
			text = "TOGGLE OPACITY";
			tooltip = "Switch the right Configuration Panel between 80% and 100% opacity.";
			x = safezoneX + (safezoneW * 0.70);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.13;
			h = safezoneH * 0.03;
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ToggleOpacity.sqf';";
		};

		// Export Button
		class Button_Export: PXG_Builder_BaseButton {
			idc = 456005;
			text = "EXPORT TO CLIPBOARD";
			tooltip = "Compile the entire Faction Hashmap and copy it to your OS Clipboard.";
			x = safezoneX + (safezoneW * 0.84);
			y = safezoneY + (safezoneH * 0.01);
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			colorBackground[] = {0.2, 0.6, 0.2, 1}; 
			colorBackgroundActive[] = {0.3, 0.8, 0.3, 1}; 
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Export_Faction.sqf';";
		};
		
		// --- Left Panel Controls ---
		class Context_Tree: PXG_Builder_BaseTree {
			idc = 456010;
			tooltip = "Select a Category or Role to edit.";
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.07);
			w = safezoneW * 0.23;
			h = safezoneH * 0.82; 
			onTreeSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdatePreview.sqf';";
		};

		class Button_Add_Item: PXG_Builder_BaseButton {
			idc = 456012;
			text = "[+]";
			tooltip = "Add a new Role or Vehicle.";
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_AddItem.sqf';";
		};
		class Button_Duplicate_Item: PXG_Builder_BaseButton {
			idc = 456014;
			text = "[D]";
			tooltip = "Duplicate the selected Role or Vehicle.";
			x = safezoneX + (safezoneW * 0.09);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			colorBackground[] = {0.2, 0.4, 0.4, 0.8};
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_DuplicateItem.sqf';";
		};
		class Button_Delete_Item: PXG_Builder_BaseButton {
			idc = 456013;
			text = "[-]";
			tooltip = "Remove the selected element.";
			x = safezoneX + (safezoneW * 0.17);
			y = safezoneY + (safezoneH * 0.90);
			w = safezoneW * 0.07;
			h = safezoneH * 0.03;
			colorBackground[] = {0.6, 0.2, 0.2, 0.8};
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_DeleteItem.sqf';";
		};

		// --- Overview Tab Controls (Grouped) ---
		class Group_OverviewControls: RscControlsGroupNoScrollbars {
			idc = 456050;
			x = safezoneX + (safezoneW * 0.01);
			y = safezoneY + (safezoneH * 0.07);
			w = safezoneW * 0.23;
			h = safezoneH * 0.85;
			show = 0; // Hidden by default

			class controls {
				class Label_Side: PXG_Builder_BaseText {
					text = "SIDE";
					x = 0; y = 0; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Side: PXG_Builder_BaseCombo {
					idc = 456051;
					x = 0; y = 0.035 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Side'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf';";
				};
				class Label_Faction: PXG_Builder_BaseText {
					text = "FACTION";
					x = 0; y = 0.08 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Faction: PXG_Builder_BaseCombo {
					idc = 456052;
					x = 0; y = 0.115 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Faction'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf';";
				};
				class Label_Subfaction: PXG_Builder_BaseText {
					text = "SUBFACTION";
					x = 0; y = 0.16 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Subfaction: PXG_Builder_BaseCombo {
					idc = 456053;
					x = 0; y = 0.195 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Subfaction'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf';";
				};
				class Label_Camo: PXG_Builder_BaseText {
					text = "CAMO";
					x = 0; y = 0.24 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Camo: PXG_Builder_BaseCombo {
					idc = 456054;
					x = 0; y = 0.275 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Camo'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf';";
				};
				class Label_Era: PXG_Builder_BaseText {
					text = "ERA";
					x = 0; y = 0.32 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
				class Combo_Era: PXG_Builder_BaseCombo {
					idc = 456055;
					x = 0; y = 0.355 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					onLBSelChanged = "['Era'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_UpdateDropdowns.sqf';";
				};

				// --- Management Area ---
				class Button_Duplicate: PXG_Builder_BaseButton {
					idc = 456056;
					text = "DUPLICATE";
					tooltip = "Create a copy of this faction setup for a different metadata combination.";
					x = 0; y = 0.45 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
					action = "[true] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ToggleExtended.sqf';";
				};
				class Button_AddNew: PXG_Builder_BaseButton {
					idc = 456057;
					text = "ADD NEW FACTION";
					x = 0; y = 0.49 * safezoneH; w = 0.23 * safezoneW; h = 0.03 * safezoneH;
				};
			};
		};

		// --- Extended Panel Controls (Duplicate Interface) ---
		class Group_ExtendedControls: RscControlsGroupNoScrollbars {
			idc = 456060;
			x = safezoneX + (safezoneW * 0.26); 
			y = safezoneY + (safezoneH * 0.07);
			w = 0; 
			h = safezoneH * 0.85;
			show = 0;

			class controls {
				class Label_Ext_Title: PXG_Builder_BaseText {
					text = "NEW ELEMENT NAME";
					x = 0; y = 0; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
				};
				class Edit_NewName: PXG_Builder_BaseEdit {
					idc = 456061;
					x = 0; y = 0.035 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
				};
				class Button_ConfirmAdd: PXG_Builder_BaseButton {
					text = "CONFIRM";
					x = 0; y = 0.08 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
					colorBackground[] = {0.2, 0.6, 0.2, 1};
					action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ConfirmAction.sqf';";
				};
				class Button_CancelAdd: PXG_Builder_BaseButton {
					text = "CANCEL";
					x = 0; y = 0.12 * safezoneH; w = 0.21 * safezoneW; h = 0.03 * safezoneH;
					action = "[false] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ToggleExtended.sqf';";
				};
			};
		};

		class Group_RightPanel: RscControlsGroupNoScrollbars {
			idc = 456100;
			x = safezoneX + (safezoneW * 0.75);
			y = safezoneY + (safezoneH * 0.05);
			w = safezoneW * 0.25;
			h = safezoneH * 0.95;
			show = 0; // Only shown when configuring (Armory, etc)

			class controls {
				// Column 1: Category List (Icon Sidebar)
				class Category_List: PxgGuiRscListBox {
					idc = 456070;
					x = safezoneW * 0.005;
					y = safezoneH * 0.007;
					w = safezoneW * 0.03;
					h = safezoneH * 0.943;
					colorBackground[] = {0.05, 0.05, 0.05, 0.9};
					sizeEx = 0;
					onLBSelChanged = "['CategoryChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleCategory.sqf';";
				};

				// Column 2: Main Item Browser
				class Search_Gear: PXG_Builder_BaseEdit {
					idc = 456022;
					tooltip = "Search for specific gear by name...";
					x = safezoneW * 0.04;
					y = safezoneH * 0.007;
					w = safezoneW * 0.06; 
					h = safezoneH * 0.03;
					onKeyUp = "['SearchChanged'] execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleCategory.sqf';";
				};

				class Combo_Variants: PxgGuiRscCombo {
					idc = 456023;
					tooltip = "Select pattern / color variant.";
					x = safezoneW * 0.102;
					y = safezoneH * 0.007;
					w = safezoneW * 0.038;
					h = safezoneH * 0.03;
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleVariants.sqf';";
				};

				class Right_Listbox: PXG_Builder_BaseList {
					idc = 456020;
					x = safezoneW * 0.04;
					y = safezoneH * 0.04;
					w = safezoneW * 0.10;
					h = safezoneH * 0.83;
					rowHeight = "4 * (0.018 * safezoneH)"; 
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ApplyGear.sqf';";
				};

				// Column 3: Slot / Content Manager
				class Label_Slots: PXG_Builder_BaseText {
					text = "SLOTS & CONTENTS";
					x = safezoneW * 0.145;
					y = safezoneH * 0.007;
					w = safezoneW * 0.10;
					h = safezoneH * 0.03;
					colorBackground[] = {0.29, 0.42, 0.42, 0.4};
				};

				class Slot_Listbox: PXG_Builder_BaseList {
					idc = 456080;
					tooltip = "Active attachments and container contents.";
					x = safezoneW * 0.145;
					y = safezoneH * 0.04;
					w = safezoneW * 0.10;
					h = safezoneH * 0.77; 
					rowHeight = "2.5 * (0.018 * safezoneH)";
					onLBSelChanged = "_this execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_HandleSlotClick.sqf';";
				};

				class Label_Amount: PXG_Builder_BaseText {
					text = "QTY:";
					x = safezoneW * 0.145;
					y = safezoneH * 0.82;
					w = safezoneW * 0.03;
					h = safezoneH * 0.03;
					sizeEx = 0.03;
				};

				class Edit_Amount: PXG_Builder_BaseEdit {
					idc = 456081;
					text = "1"; 
					x = safezoneW * 0.175;
					y = safezoneH * 0.82;
					w = safezoneW * 0.02;
					h = safezoneH * 0.03;
					onKeyUp = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_CalcMass.sqf';";
				};

				class Text_Mass: PXG_Builder_BaseText {
					idc = 456082;
					text = "MASS: 0.0";
					x = safezoneW * 0.20;
					y = safezoneH * 0.82;
					w = safezoneW * 0.045;
					h = safezoneH * 0.03;
					colorText[] = {0.3, 0.8, 0.3, 1};
				};
			};
		};

		// --- Bottom Panel Controls ---
		class Inventory_Text: PXG_Builder_BaseText {
			idc = 456030;
			text = "INVENTORY PREVIEW";
			tooltip = "A live look into the inventory of the spawned physical unit.";
			x = safezoneX + (safezoneW * 0.26);
			y = safezoneY + (safezoneH * 0.77);
			w = safezoneW * 0.40;
			h = safezoneH * 0.03;
		};

		class Button_Collapse_Inventory: PXG_Builder_BaseButton {
			idc = 456031;
			text = "[-]";
			tooltip = "Collapse or Expand the Inventory frame.";
			x = safezoneX + (safezoneW * 0.72);
			y = safezoneY + (safezoneH * 0.77);
			w = safezoneW * 0.02;
			h = safezoneH * 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0.29, 0.42, 0.42, 0.5}; // Faint teal on hover
			action = "execVM 'Scripts\Faction_Builder_Tool\Functions\PXG_Builder_ToggleInventory.sqf';";
		};
	};
};
