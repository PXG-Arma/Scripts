// Fonts
#define GUI_FONT_NORMAL			RobotoCondensed
#define GUI_FONT_BOLD			RobotoCondensedBold
#define GUI_FONT_THIN			RobotoCondensedLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro
#define GUI_FONT_CODE			LucidaConsoleB
#define GUI_FONT_SYSTEM			TahomaB

// Grids
#define GUI_GRID_CENTER_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs		(GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W		(GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H		(GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y		(safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

// Armory Dialog IDCs
#define IDD_ARMORY 431234
#define IDC_ARMORY_SIDE 431500
#define IDC_ARMORY_FACTION_TREE 431501
#define IDC_ARMORY_LOADOUT_TREE 431503
#define IDC_ARMORY_CAMO_TEXT 431005
#define IDC_ARMORY_CAMO_LIST 431504
#define IDC_ARMORY_BACKGROUND 431006

// BigArmory Modular IDCs
#define IDC_ARMORY_MODULAR_PANEL 431700
#define IDC_ARMORY_MODULAR_HEADER 431704
#define IDC_ARMORY_WEAPON_TEXT 431705
#define IDC_ARMORY_WEAPON_LIST 431701
#define IDC_ARMORY_ATTACHMENT_LIST 431702
#define IDC_ARMORY_PREVIEW_PICTURE 431703
#define IDC_ARMORY_PREVIEW_BACKGROUND 431707

// Attachment Icon IDCs
#define IDC_ARMORY_SIGHT_ICON 431710
#define IDC_ARMORY_UNDERBARREL_ICON 431711
#define IDC_ARMORY_GRIP_ICON 431712
#define IDC_ARMORY_MUZZLE_ICON 431713

// Resupply Dialog IDCs
#define IDD_RESUPPLY 451922
#define IDC_RESUPPLY_SIDE 451504
#define IDC_RESUPPLY_FACTION_TREE 451501
#define IDC_RESUPPLY_SUPPLIES_LB 451502
#define IDC_RESUPPLY_SPAWNPOINTS 451500
#define IDC_RESUPPLY_CONTENTS_TEXT 451505
#define IDC_RESUPPLY_CONTENTS_SPACE_TEXT 451506
#define IDC_RESUPPLY_CAMO_TEXT 451507
#define IDC_RESUPPLY_CAMO_LIST 451508
#define IDC_RESUPPLY_BACKGROUND 451006

// Motorpool Dialog IDCs
#define IDD_MOTORPOOL 461922
#define IDC_MOTORPOOL_SIDE 461504
#define IDC_MOTORPOOL_FACTION_TREE 461501
#define IDC_MOTORPOOL_VEHICLE_LB 461502
#define IDC_MOTORPOOL_SPAWNPOINTS 461500
#define IDC_MOTORPOOL_PREVIEW 461505
#define IDC_MOTORPOOL_CARGO_TEXT 461499
#define IDC_MOTORPOOL_SEATS_TEXT 461498
#define IDC_MOTORPOOL_CAMO_TEXT 461506
#define IDC_MOTORPOOL_CAMO_LIST 461507
#define IDC_MOTORPOOL_BACKGROUND 461006

// Config IDCs
#define IDC_UI_OPACITY_TOGGLE 400001
#define IDC_UI_ORBIT_TOGGLE 400002

// GUI Styling
#define GUI_COLOR_UI_GREY {0.7, 0.7, 0.7, 1}
#define PXG_COLOR_BG {0.1, 0.1, 0.1, 0.8}
#define PXG_COLOR_BG_DARK {0, 0, 0, 0.3}
#define PXG_COLOR_PREVIEW {0.44, 0.47, 0.49, 0.6} // Steel Grey (#71797E)

#define GUI_STR_OPACITY "%"
#define GUI_STR_ORBIT "<"
#define GUI_W_BTN_S (0.03 * safezoneW)    // Small (Opacity/Orbit)
#define GUI_W_BTN_M (0.06 * safezoneW)    // Medium (Close/Spawn)
#define GUI_W_BTN_L (0.045 * safezoneW)   // Switch (Motorpool/Resupply)
#define GUI_H_BTN (0.02 * safezoneH)

// Global UI Layout Standards
#define PXG_UI_MAIN_X (0.185 * safezoneW + safezoneX)
#define PXG_UI_MAIN_X_CENTERED (0.095 * safezoneW + safezoneX)
#define PXG_UI_MAIN_Y (0.1815 * safezoneH + safezoneY)
#define PXG_UI_MAIN_W (0.63 * safezoneW)
#define PXG_UI_MAIN_H (0.637 * safezoneH)

#define PXG_UI_EXT_X  (0.815 * safezoneW + safezoneX) // Modular/Cargo sidebar X
#define PXG_UI_EXT_X_CENTERED (0.725 * safezoneW + safezoneX) // Centered Sidebar X
#define PXG_UI_EXT_W  (0.18 * safezoneW)

#define PXG_UI_HEADER_Y (0.1585 * safezoneH + safezoneY)
#define PXG_UI_HEADER_H (0.022 * safezoneH)
#define PXG_UI_FOOTER_Y (0.8185 * safezoneH + safezoneY)

#define PXG_UI_LIST_ROW_HEIGHT (0.05 * safezoneH)
#define PXG_UI_LIST_TEXT_SIZE  (0.018 * safezoneH)

// Logic & Data Macros
#define IS_OPTIC(item) (getNumber (configFile >> "CfgWeapons" >> item >> "ItemInfo" >> "type") == 201)

// Motorpool Pylon Manager IDCs
#define IDC_MOTORPOOL_PYLON_PANEL 461700
#define IDC_MOTORPOOL_PYLON_CONTAINER 461710
