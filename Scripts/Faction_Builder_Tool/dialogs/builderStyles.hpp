/*
	builderStyles.hpp
	Custom base classes for the Faction Builder Tool (FBT) to ensure a premium tactical look.
*/

class FBT_BaseText: PxgGuiRscText {
	font = "RobotoCondensed";
	shadow = 1;
};

class FBT_BaseButton: PxgGuiRscButton {
	font = "RobotoCondensed";
	shadow = 0;
};

class FBT_TabButton: FBT_BaseButton {
	colorBackgroundActive[] = {0.35, 0.45, 0.45, 1}; 
	colorFocused[] = {0.35, 0.45, 0.45, 1};
};

class FBT_ToggleButton: FBT_BaseButton {
	colorBackground[] = {0.2, 0.25, 0.25, 0.6}; 
	colorBackgroundActive[] = {0.29, 0.42, 0.42, 0.9}; 
	colorFocused[] = {0.29, 0.42, 0.42, 1};
};

class FBT_BaseTree: PxgGuiRscTree {
	font = "EtelkaMonospacePro"; 
};

class FBT_BaseList: PxgGuiRscListBox {
	font = "EtelkaMonospacePro"; 
};

class FBT_BaseCombo: PxgGuiRscCombo {
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorBackground[] = {0.1, 0.1, 0.1, 1};
	colorSelectBackground[] = {0.29, 0.42, 0.42, 1}; 
};

class FBT_BaseEdit: RscEdit {
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorBackground[] = {0, 0, 0, 0.5};
	colorText[] = {1, 1, 1, 1};
	colorSelection[] = {0.29, 0.42, 0.42, 1};
};
