// This file assigns the names and corresponding gear to the loadout list. This example has every role within our group so YOU SHOULD ONLY BE TAKING STUFF OUT, NEVER ADDING!
// The first line are the different role groups.
// The second line are the roles under those groups. 
// The third line are the assigned script names that assign the loadouts to the roles above.

_avialableLoadouts = 
	[
		["Platoon HQ", "Squad", "Sniper Team", "Air Cavalry"],
		[["Platoon Lead", "Logistics", "Platoon EOD", "Platoon Medic", "TACP"], ["Squad Lead", "Combat Medic", "Combat Engineer", "Breacher", "Designated Marksman"], ["Spotter", "Sniper", "Anti-Material Rifleman", "Drone Operator"], ["Rotary Pilot"]],
		[["plt", "logi", "plt_eod", "plt_med", "tacp"], ["sqd_ld", "sqd_med", "sqd_eng", "sqd_brc", "sf_dmr"], ["rcn_ld", "rcn_sni", "rcn_amr", "rcn_drone"], ["r_pil"]]
	];

_avialableLoadouts