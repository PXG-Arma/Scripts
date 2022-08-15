params["_side","_faction","_variant", "_loadout"]; 

// add UAV terminal
switch (_loadout) do {
	default {};
	case "rcn_drone": {player linkItem "O_UavTerminal";
					   player addItemToBackpack "ITC_Land_O_AR2e_Packed";
		for "_i" from 1 to 2 do { player addItemToBackpack "ACE_UAVBattery"};
	};
	case "rcn_ld": {player addItemToBackpack "ACE_Cellphone";
					player addItemToBackpack "ITC_Land_O_AR2e_Packed";
		for "_i" from 1 to 2 do { player addItemToBackpack "ACE_UAVBattery"};
	};
};

// add DMS
switch (_loadout) do {
	default {};
	case "sqd_ld": {
		for "_i" from 1 to 6 do { player addItemToBackpack "ACE_DeadManSwitch"};
	};
};

