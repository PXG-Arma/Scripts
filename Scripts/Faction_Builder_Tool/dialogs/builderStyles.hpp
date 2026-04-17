/*
	builderStyles.hpp
	Custom base classes for the Faction Builder to ensure a premium tactical look.
	Overrides fonts, hover states, and focus colors.
*/

class PXG_Builder_BaseText: PxgGuiRscText {
	font = "RobotoCondensed";
	shadow = 1;
};

class PXG_Builder_BaseButton: PxgGuiRscButton {
	font = "RobotoCondensed";
	shadow = 0;
};

class PXG_Builder_TabButton: PXG_Builder_BaseButton {
	colorBackgroundActive[] = {0.35, 0.45, 0.45, 1}; // Slightly brighter/greyer highlight
	colorFocused[] = {0.35, 0.45, 0.45, 1};
};

class PXG_Builder_ToggleButton: PXG_Builder_BaseButton {
	colorBackground[] = {0.2, 0.25, 0.25, 0.6}; // Darker, muted base
	colorBackgroundActive[] = {0.29, 0.42, 0.42, 0.9}; // Teal highlight on hover
	colorFocused[] = {0.29, 0.42, 0.42, 1};
};

class PXG_Builder_BaseTree: PxgGuiRscTree {
	font = "EtelkaMonospacePro"; // Monospace for data trees
};

class PXG_Builder_BaseList: PxgGuiRscListBox {
	font = "EtelkaMonospacePro"; // Monospace for data lists
};

class PXG_Builder_BaseCombo: PxgGuiRscCombo {
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorBackground[] = {0.1, 0.1, 0.1, 1};
	colorSelectBackground[] = {0.29, 0.42, 0.42, 1}; // Teal highlight
};

class PXG_Builder_BaseEdit: RscEdit {
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorBackground[] = {0, 0, 0, 0.5};
	colorText[] = {1, 1, 1, 1};
	colorSelection[] = {0.29, 0.42, 0.42, 1};
};
