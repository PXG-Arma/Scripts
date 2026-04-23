// Welcome to the Faction Gear file, This should be called "Gear_FactionName"
// In this file you assign whatever important equipment needs to change from the Common file and is different on a per faction basis. 
// Notably the UAV and it's terminal are Side dependent, so a Blufor faction should get a Blufor Drone/Terminal. Or if you want another type of NVG, it gets assigned here
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;


params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "plt_eod";
	case "tacp": {player linkItem "B_UavTerminal"};
	case "rcn_drone": {player linkItem "B_UavTerminal";
		player addItemToBackpack "Rev_darter";
		for "_i" from 1 to 3 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	
};

// add Spotting Scope and Scope NVS
switch (_loadout) do {
	case "sqd_dm": {player addItemToBackpack "ACE_Tripod";
	                player addItemToBackpack "BWA3_optic_NSV600"};
};

switch (_loadout) do {
	case "rcn_sni";
	case "rcn_amr": {player addItemToBackpack "BWA3_optic_NSV80";
	                player addItemToBackpack "ACE_Tripod"};
};

switch (_loadout) do {
	case "rcn_ld": {player addItemToBackpack "ACE_SpottingScope";
				   player addItemToBackpack "ACE_RangeCard"};
};

// add Clacker
switch (_loadout) do {
	case "sqd_brc": {player addItemToBackpack "ACE_Clacker"};
};
// NVG swap
// switch (_loadout) do {
//     default {};
//	 case "f_pil": {player addHeadgear "H_PilotHelmetFighter_B"};
// };