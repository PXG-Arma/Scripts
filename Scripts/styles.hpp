import RscObject;
import RscText;
import RscFrame;
import RscLine;
import RscProgress;
import RscPicture;
import RscPictureKeepAspect;
import RscVideo;
import RscHTML;
import RscButton;
import RscShortcutButton;
import RscEdit;
import RscCombo;
import RscListBox;
import RscListNBox;
import RscXListBox;
import RscTree;
import RscSlider;
import RscXSliderH;
import RscActiveText;
import RscActivePicture;
import RscActivePictureKeepAspect;
import RscStructuredText;
import RscToolbox;
import RscControlsGroup;
import RscControlsGroupNoScrollbars;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoVScrollbars;
import RscButtonTextOnly;
import RscButtonMenu;
import RscButtonMenuOK;
import RscButtonMenuCancel;
import RscButtonMenuSteam;
import RscMapControl;
import RscMapControlEmpty;
import RscCheckBox;

class PxgGuiBackground: RscFrame 
{
	colorBackground[] = {0.1, 0.1, 0.1, 1}; 
	style = 128;
};

class PxgGuiRscTree: RscTree
{
	colorBackground[] = {0,0,0,0.3};
	rowHeight = 0.05;
};

class PxgGuiRscButton: RscButton
{

};

class PxgGuiRscButtonPicture: RscButton
{
	style = 48; // ST_PICTURE
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	colorBackgroundActive[] = {1,1,1,0.1};
};

class PxgGuiRscText: RscText
{

};

class PxgGuiRscListBox: RscListBox
{

};

class PxgGuiRscCombo: RscCombo
{
	wholeHeight = 0.45;
	colorSelectBackground[] = {1, 1, 1, 0.25};
};

class PxgGuiRscStructuredText: RscStructuredText
{
	colorBackground[] = 			
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
};

class PxgGuiRscPicture: RscPictureKeepAspect
{
	    colorText[] = {1,1,1,1};
};

class PxgGuiRscControlsGroup: RscControlsGroup
{
    class VScrollbar {
        color[] = {1, 1, 1, 1};
        width = 0.021 * safezoneW;
        autoScrollEnabled = 1;
    };
    class HScrollbar {
        color[] = {1, 1, 1, 0}; // Transparent to remove white bar
        height = 0;             // 0 height to ensure no space is taken
    };
};