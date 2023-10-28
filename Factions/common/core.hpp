class factionCore {
	class coreLoadout 
	{
		// Loadout settings
		displayInArmory = 0; // whether or not this loadout should be visable in armory  

		// Loadout name role and element 
		displayName = "";	// how this loadout will show up in armory
		element = "";		// the element this loadout belongs to (Squad, Support MAT etc.)
		BFTName = "";		// BFT name for this loadout
		leader = 0; 		// This checks of loadout it a leader element. This has to do with slot restrictions
		medicalPerms = 0;	// ACE permissions for this loadout. 0 for none, 1 for medic 
		engineerPerm = 0; 	// ACE permissions for this loadout. 0 for none, 1 for basic, 2 for magic repair powers (logi)
		HasGPS = 0; 

		// Loadout role and description
		roleDescription = "";	// description shown in armory

		// Loadout radnomization settings
		randomizeUniform = 0;	// whether or not to randomize the uniform
		randomizeVest = 0;		// whether or not to randomize the vest
		randomizeBackpack = 0;	// whether or not to randomize the backpack
		randomizeHelmet = 0;	// whether or not to randomize the helmet
		randomizeGoggles = 0;	// whether or not to randomize the goggles

		randomizePrimary = 0;	// whether or not to randomize the primary weapon
		randomizeSecondary = 0;	// whether or not to randomize the secondary weapon
		randomizeLauncher = 0;	// whether or not to randomize the launcher weapon

		// Items for loadout
		uniform[] = {}; 		// Uniform classname  
		vest[] = {};			// Vest classname
		backpack[] = {}; 		// Backpack classname
		
		headgear[] = {};		// headgear classname
		facewear[] = {}; 		// facewear classname
		NVGs[] = {};			// nightvision classnames
		binoculars[] = {"binocular"};	// binoculars classnames  
		
		// Primary weapons and attachments
		primary[] = {};		// primary weapon classname

		primaryMuzzles[] = {};
		primaryOptics[] = {};
		primaryLights[] = {};
		primaryGrips[] = {};

		// Secondary weapons and attachments
		secondary[] = {};		// secondary weapon classname

		secondaryMuzzles[] = {};
		secondaryOptics[] = {};
		secondaryLights[] = {};
		secondaryGrips[] = {};

		// Launcher weapons and attachments
		launcher[] = {};		// launcher weapon classname

		launcherMuzzles[] = {};
		launcherOptics[] = {};
		launcherLights[] = {};
		launcherGrips[] = {};

		// Personal Ammunition
		primaryMagazines[] = {};	// primary weapon magazines
		secondaryMagazines[] = {};	// secondary weapon magazines
		launcherMagazines[] = {};	// launcher weapon magazines

		// Assistant ammunition AAR, MAT etc. 
		assistantMagazines[] = {};	// assistant weapon magazines

		// Grenades throwables and smokes	
		throwables[] = {};		// Throwable items (grenades, smokes etc.)

		// Items and gear
		factionGear[] = {};			// additional gear 
		eraGear[] = {};				// era specific gear
		roleGear[] = {};				// role specific gear

		// Core stuff, Do not edit unless you know what you are doing.
		coreGear[] = {"ACE_CableTie", 4, "ACE_Flashlight_XL50", 1, "ACE_MapTools", 1, "ACE_EntrenchingTool", 1, "ACE_Fortify", 1}; // core gear for all factions
		
		personalMedical[] = {"ACE_elasticBandage", 4, "ACE_packingBandage", 4, "ACE_quikclot", 4, "ACE_epinephrine", 2, "ACE_morphine", 2, "ACE_tourniquet", 2}; // Core medical gear for all factions 
		medicMedical[] = {"ACE_surgicalKit", 1, "ACE_elasticBandage", 12, "ACE_quikclot", 12, "ACE_packingBandage", 12, "ACE_tourniquet", 6, "ACE_bloodIV", 6, "ACE_bloodIV_500", 6, "ACE_morphine", 6, "ACE_epinephrine", 6};// medical items for medic

		// Radios
		personalRadio = ""; 	// What radio the loadout should have. Black for none.
		longRangeRadio = ""; 	// What long range radio the loadout should have. Black for none.

	};

}; 

class factionModern: factionCore
{
	class eraLoadout:coreLoadout
	{
		personalRadio = "ACRE_PRC343"; 
		eraGear[] = {"ACE_microDAGR", 1, "ACE_IR_Strobe_Item", 1};
		NVGs[] = {"ACE_NVG_Wide_Black"};
	};
};

class factionLate: factionCore 
{
	class eraLoadout:coreLoadout
	{
		personalRadio = "ACRE_PRC343"; 
		eraGear[] = {"ACE_DAGR", 1, "ACE_IR_Strobe_Item", 1};
	};
};

class factionEarly: factionCore
{
	class eraLoadout:coreLoadout
	{
		personalRadio = ""; 
		eraGear[] = {};
	};
};
