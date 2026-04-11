// This file lists all the medical gear that is common accross all Factions, This should never be touched!

params["_side","_faction","_variant", "_loadout"]; 

// add personal medical items
for "_i" from 1 to 6 do { player addItemToUniform "ACE_quikclot"};
for "_i" from 1 to 6 do { player addItemToUniform "ACE_packingBandage"};
for "_i" from 1 to 2 do { player addItemToUniform "ACE_tourniquet"};
for "_i" from 1 to 2 do { player addItemToUniform "ACE_splint"};
for "_i" from 1 to 1 do { player addItemToUniform "kat_Painkiller"};

// add medic medical items
switch (_loadout) do {
	default {};
	case "sqd_med": {
		for "_i" from 1 to 1 do { player addItemToBackpack "ACE_surgicalKit"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_elasticBandage"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_quikclot"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_packingBandage"};
		for "_i" from 1 to 10 do { player addItemToBackpack "kat_IV_16"};
		for "_i" from 1 to 10 do { player addItemToBackpack "kat_larynx"};	
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_tourniquet"};			
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_bloodIV_O_N"};
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_bloodIV_O_N_500"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_morphine"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_epinephrine"};
        for "_i" from 1 to 10 do { player addItemToBackpack "ACE_splint"};
		for "_i" from 1 to 1 do { player addItemToBackpack "kat_Carbonate"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SmokeShellPurple"};
		for "_i" from 1 to 1 do { player addItemToUniform "TOMH_Stencil_Medical"};
	};

	case "plt_med": {
		for "_i" from 1 to 1 do { player addItemToBackpack "ACE_surgicalKit"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_elasticBandage"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_quikclot"};
		for "_i" from 1 to 10 do { player addItemToBackpack "ACE_packingBandage"};
		for "_i" from 1 to 4 do { player addItemToBackpack "kat_TXA"};	
		for "_i" from 1 to 4 do { player addItemToBackpack "kat_EACA"};
		for "_i" from 1 to 10 do { player addItemToBackpack "kat_IV_16"};
		for "_i" from 1 to 10 do { player addItemToBackpack "kat_larynx"};	
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_tourniquet"};			
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_bloodIV_O_N"};
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_bloodIV_O_N_500"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_morphine"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_epinephrine"};
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_IO_FAST"};
        for "_i" from 1 to 10 do { player addItemToBackpack "ACE_splint"};
		for "_i" from 1 to 1 do { player addItemToBackpack "kat_Carbonate"};
		for "_i" from 1 to 1 do { player addItemToBackpack "kat_accuvac"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SmokeShellPurple"};
		for "_i" from 1 to 1 do { player addItemToUniform "TOMH_Stencil_Medical"};
	};
};

// add specialist medical items
switch (_loadout) do {
	default {};
	case "sf_med": {
		for "_i" from 1 to 1 do { player addItemToBackpack "ACE_surgicalKit"};
		for "_i" from 1 to 8 do { player addItemToBackpack "ACE_elasticBandage"};
		for "_i" from 1 to 8 do { player addItemToBackpack "ACE_quikclot"};
		for "_i" from 1 to 8 do { player addItemToBackpack "ACE_packingBandage"};
		for "_i" from 1 to 8 do { player addItemToBackpack "kat_IV_16"};
		for "_i" from 1 to 8 do { player addItemToBackpack "kat_larynx"};	
		for "_i" from 1 to 3 do { player addItemToBackpack "ACE_tourniquet"};			
		for "_i" from 1 to 3 do { player addItemToBackpack "kat_bloodIV_O_N"};
		for "_i" from 1 to 3 do { player addItemToBackpack "kat_bloodIV_O_N_500"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_morphine"};
		for "_i" from 1 to 5 do { player addItemToBackpack "ACE_epinephrine"};
		for "_i" from 1 to 5 do { player addItemToBackpack "kat_IO_FAST"};
        for "_i" from 1 to 5 do { player addItemToBackpack "ACE_splint"};
		for "_i" from 1 to 1 do { player addItemToBackpack "kat_Carbonate"};
		for "_i" from 1 to 1 do { player addItemToBackpack "SmokeShellPurple"};
		for "_i" from 1 to 1 do { player addItemToUniform "TOMH_Stencil_Medical"};
	};
};
