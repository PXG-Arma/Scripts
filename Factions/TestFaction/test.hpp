class USAMechanisedModernFaction: factionModern {
	
	name = "USA Mechanised"; 
	faction = "US Army";
	side = "Blue";
	
	class defaultLoadout: eraLoadout 
	{
		// Loadout role and description
		roleDescription = "";	// description shown in armory

		// Items for loadout
		uniform[] = {"rhs_uniform_cu_ocp"}; 				// Uniform classname  
		vest[] = {"rhsusf_spcs_ocp_rifleman_alt"};			// Vest classname
		backpack[] = {"rhsusf_assault_eagleaiii_ocp"}; 		// Backpack classname
		
		headgear[] = {"rhsusf_ach_helmet_headset_ocp_alt"};	// helmet classname
		facewear[] = {}; 		// goggles classname 
		binoculars[] = {"Binocular", "ACE_Vector"};	// Binoculars or range finders

		// Primary weapons and attachments
		primary[] = {"rhs_weap_m4a1_carryhandle"};		// primary weapon classname

		primaryMuzzles[] = {"rhsusf_acc_SF3P556"};
		primaryOptics[] = {"rhsusf_acc_eotech_xps3","optic_Holosight_blk_F"};
		primaryLights[] = {"rhsusf_acc_anpeq15_bk_top","rhsusf_acc_anpeq15side_bk"};
		primaryGrips[] = {"rhsusf_acc_grip3","rhsusf_acc_grip_m203_blk"};

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
		primaryMagazines[] = {"rhs_mag_30Rnd_556x45_M855_Stanag", 4,"rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red",4, "rhs_30Rnd_762x39mm_bakelite_89", 4, "rhs_30Rnd_762x39mm_bakelite_89", 4};	// primary weapon magazines
		secondaryMagazines[] = {};	// secondary weapon magazines
		launcherMagazines[] = {};	// launcher weapon magazines

		// Assistant ammunition AAR, MAT etc. 
		assistantMagazines[] = {};	// assistant weapon magazines

		// Grenades throwables and smokes	
		throwables[] = {"rhs_mag_an_m8hc", 2, "HandGrenade", 2, "SmokeShellGreen", 1, "SmokeShellRed", 1};		// Throwable items (grenades, smokes etc.)

		// Items and gear
		factionGear[] = {};			// additional gear 

		HasGPS = 1; 

	};


	// Platoon element
	class platoonLeader: defaultLoadout
	{
		displayInArmory = 1;

		roleDescription = "Platoon Leader. Lead the platoon to glorious victory!"

		displayName	= "Platoon Leader";
		element = "Platoon";
		BFTName = "PLT";
		leader = 1;

		uniform[] = {"rhs_uniform_cu_ocp","m93_dm"}; 				// Uniform classname

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finders

		primary[] = {"rhs_weap_m4a1_carryhandle_m203S"};
		secondaryAmmo[] = {"1Rnd_HE_Grenade_shell", 5, "1Rnd_Smoke_Grenade_shell", 2, "1Rnd_SmokeRed_Grenade_shell", 2, "1Rnd_SmokeGreen_Grenade_shell", 2, "UGL_FlareWhite_F", 2}; 

		longRangeRadio = "ACRE_PRC117F";
	};

	class logi:platoonLeader
	{	

		roleDescription = "Logi, the taxi driver."

		displayName	= "Logi";
		BFTName = "LOGI";
		engineerPerm = 2;
		
		primary[] = {"rhs_weap_m4a1_carryhandle"};
		secondaryAmmo[] = {};
	};
	
	class tacp:platoonLeader
	{	

		roleDescription = "TACP, the call center operator."

		displayName	= "TACP";
		BFTName = "TACP";
		engineerPerm = 1;

		primary[] = {"rhs_weap_m4a1_carryhandle"};
		secondaryAmmo[] = {};

		binoculars[] = {"Laserdesignator"}; //Only Laserdesignator allowed, to prevent TACT from accidentally taking a rangefinder
	};

	// squad roles 

	class squadLeader: defaultLoadout
	{	

		roleDescription = "Squad Leader, the cat herder."

		displayInArmory = 1;

		displayName	= "Squad Leader";
		element = "Squad";
		BFTName = "Squad";
		leader = 1;

		primary[] = {"rhs_weap_m4a1_carryhandle_m203S"};
		secondaryAmmo[] = {"1Rnd_HE_Grenade_shell", 10, "1Rnd_Smoke_Grenade_shell", 2, "1Rnd_SmokeRed_Grenade_shell", 2, "1Rnd_SmokeGreen_Grenade_shell", 2, "UGL_FlareWhite_F", 2};

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finders

		longRangeRadio = "ACRE_PRC152";
	};

	class medic: defaultLoadout
	{	
		roleDescription = "Medic, the bandaid applier."

		displayInArmory = 1;

		displayName	= "Medic";
		element = "Squad";
		BFTName = "Squad";
		medicalPerms = 1;

	};

	// AR
	class autorifleman: defaultLoadout
	{	
		roleDescription = "Autorifleman, compensating for something."

		displayInArmory = 1;

		displayName	= "Autorifleman";
		element = "Squad";
		BFTName = "Squad";

		primary[] = {"rhs_weap_m249_pip_S_para"};

		primaryMagazines[] = {"rhsusf_200Rnd_556x45_M855_soft_pouch_coyote", 2, "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch_coyote", 3};
	};

	class assistantAutorifleman: defaultLoadout
	{	
		roleDescription = "Autorifleman assistant, probably a femboy."

		displayInArmory = 1;

		displayName = "Assistant Autorifleman";
		element = "Squad";
		BFTName = "Squad";

		assistantMagazines[] = {"rhsusf_200Rnd_556x45_M855_soft_pouch_coyote", 2, "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch_coyote", 2};

	};

	class LAT: defaultLoadout	
	{	
		roleDescription = "Light Anti-Tank, the only sane person in the squad."

		displayInArmory = 1;

		displayName	= "Light Anti-Tank";
		element = "Squad";
		BFTName = "Squad";

		launcher[] = {"rhs_weap_M136"};

		launcherMagazines[] = {};

	};

	class EOD: defaultLoadout	
	{
		roleDescription = "Explosive Ordnance Disposal, watched The Hurtlocker."

		displayInArmory = 1;

		displayName	= "EOD";
		element = "Squad";
		BFTName = "Squad";

		gear[] = {}; //add explosives
	};

	class MATLeader: defaultLoadout
	{	
		roleDescription = "MAT Leader, the one who can't aim."

		displayInArmory = 1;

		displayName	= "MAT Leader";
		element = "MAT";
		BFTName = "";
		leader = 1;

		assistantMagazines[] = {"rhs_mag_smaw_HEAA", 2, "rhs_mag_smaw_HEDP", 1};

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finders
	};

	class MATGunner: defaultLoadout
	{
		roleDescription = "MAT Gunner, premajure ejaculator."

		displayInArmory = 1;

		displayName	= "MAT Gunner";
		element = "MAT";
		BFTName = "";

		launcher[] = {"rhs_weap_smaw_green"};

		launcherMagazines[] = {"rhs_mag_smaw_HEAA", 2, "rhs_mag_smaw_HEDP", 1};

	};

	class MMGLeader: defaultLoadout
	{
		roleDescription = "MMG Leader, definetly a femboy."

		displayInArmory = 1;

		displayName	= "MMG Leader";
		element = "MMG";
		BFTName = "";
		leader = 1;

		assistantMagazines[] = {"rhsusf_100Rnd_762x51_m61_ap", 2, "rhsusf_100Rnd_762x51_m62_tracer", 1};

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finder
	};

	class MMGGunner: defaultLoadout	
	{
		roleDescription = "MMG Gunner, drives big trucks."

		displayInArmory	= 1;

		displayName	= "MMG Gunner";
		element = "MMG";
		BFTName = "";

		primary[] = {"rhs_weap_m240B"};

		primaryMagazines[] = {"rhsusf_100Rnd_762x51_m61_ap", 2, "rhsusf_100Rnd_762x51_m62_tracer", 1};

	};

	class HATLeader: defaultLoadout
	{
		roleDescription = "HAT Leader, also can't aim.";

		displayInArmory = 1;

		displayName	= "HAT Leader";
		element = "HAT";
		BFTName = "";
		leader = 1;

		assistantMagazines[] = {"rhs_fgm148_magazine_AT", 2};

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finder
	};

	class HATGunner: defaultLoadout
	{
		roleDescription = "HAT Gunner, likes point and click adventures.";

		displayInArmory = 1;

		displayName	= "HAT Gunner";
		element = "HAT";
		BFTName = "";

		launcher[] = {"rhs_weap_fgm148"};

		launcherMagazines[] = {"rhs_fgm148_magazine_AT", 2};

	};

	class AALeader: defaultLoadout
	{
		roleDescription = "AA Leader, clinically insane.";

		displayInArmory = 1;

		displayName	= "AA Leader";
		element = "AA";
		BFTName = "";

		assistantMagazines[] = {"rhs_fim92_mag", 2};

	};

	class AAGunner: defaultLoadout
	{
		roleDescription = "AA Gunner, has a thing for planes.";

		displayInArmory = 1;

		displayName	= "AA Gunner";
		element = "AA";
		BFTName = "";

		launcher[] = {"rhs_weap_fim92"};

		launcherMagazines[] = {"rhs_fim92_mag", 2};

	};

	class MortarLeader: defaultLoadout
	{
		roleDescription = "Mortar Leader, professional geo-guesser player.";

		displayInArmory = 1;

		displayName	= "Mortar Leader";
		element = "Mortar";
		BFTName = "";
		leader = 1;

		backpack[] = {"B_Mortar_01_weapon_F"};

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finder
	};

	class MortarGunner: defaultLoadout
	{
		roleDescription = "Mortar Gunner, drives small cars, has really big feet. Probably a clown.";

		displayInArmory = 1;

		displayName	= "Mortar Gunner";
		element = "Mortar";
		BFTName = "";

		backpack[] = {"B_Mortar_01_weapon_F"};

	};

	class reconLeader: squadLeader
	{
		roleDescription = "Recon Leader, speshial forsses.";

		displayName	= "Recon Leader";
		element = "Recon";
		BFTName = "";

		binoculars[] = {"Binocular", "ACE_Vector", "Laserdesignator"};	// Binoculars or range finder

		// give suppressor for primary weapon
		primaryMuzzles[] = {"rhsusf_acc_SF3P556"};

		longRangeRadio = "ACRE_PRC117F";
	};

	class reconSpecialist: defaultLoadout
	{
		roleDescription = "Recon Specialist, stealthy bandaid applier.";

		displayInArmory = 1;

		displayName	= "Recon Specialist";
		element = "Recon";
		BFTName = "";
		medicalPerms = 1;


		// give suppressor for primary weapon
		primaryMuzzles[] = {"rhsusf_acc_SF3P556"};
	};

	class reconDroneOperator: defaultLoadout
	{
		roleDescription = "Recon Drone Operator, plays with toys. Really good at chess... ";

		displayInArmory = 1;

		displayName	= "Recon Drone Operator";
		element = "Recon";
		BFTName = "";

		// give suppressor for primary weapon
		primaryMuzzles[] = {"rhsusf_acc_SF3P556"};

		// give drone
		roleGear[] = {"B_UavTerminal",1};
	};

	class reconMarksman: defaultLoadout
	{
		roleDescription = "Recon Marksman, really wanted to be a pilot.";

		displayInArmory = 1;

		displayName	= "Recon Marksman";
		element = "Recon";
		BFTName = "";

		primary[] = {"rhs_weap_sr25_ec"};
		primaryMagazines[] = {"rhsusf_20Rnd_762x51_SR25_m118_special_Mag", 8};

		// give suppressor for primary weapon
		primaryMuzzles[] = {"rhsusf_acc_SF3P556"};
	};

	class armorLeader: defaultLoadout
	{
		roleDescription = "Armor Leader, does ATC for that plane game.";

		displayInArmory = 1;

		displayName	= "Armor Commander";
		element = "Armor";
		BFTName = "";

		binoculars[] = {"Binocular, ACE_Vector", "Laserdesignator"};	// Binoculars or range finder

		longRangeRadio = "ACRE_PRC152";
	};

	class armorCrewman: defaultLoadout
	{
		roleDescription = "Armor Crewman, a really cool dude.";

		displayInArmory = 1;

		displayName	= "Armor Crewman";
		element = "Armor";
		BFTName = "";

	};

	class randomGuy: defaultLoadout
	{
		roleDescription = "Random Guy, the guy who is always late.";

		displayInArmory = 1;

		displayName	= "Random Guy";
		element = "Random";
		BFTName = "";

		primary[] = {"rhs_weap_m4a1_carryhandle", "rhs_weap_m70b3n"};

	};
}; 