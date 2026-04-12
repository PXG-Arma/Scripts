// This file assigns the names and corresponding gear to the loadout list. This example has every role within our group so YOU SHOULD ONLY BE TAKING STUFF OUT, NEVER ADDING!
// The first line are the different role groups.
// The second line are the roles under those groups. 
// The third line are the assigned script names that assign the loadouts to the roles above.

_avialableLoadouts = 
	[
		["Platoon HQ", "Squad", "Special Forces", "Recon", "Support MMG", "Support HMG", "Support GMG", "Support MAT", "Support HAT", "Support AA", "Support Mortar", "Cavalry", "Air Cavalry"],
		[["Platoon Lead", "Logistics", "Platoon EOD", "Platoon Medic", "TACP"], ["Squad Lead", "Combat Medic", "Combat Engineer", "LAT Rifleman", "Pointman", "Grenadier", "Automatic Rifleman", "Asst. Rifleman"], ["SF Lead", "Combat Medic", "Designated Marksman", "Explosives Specialist"], ["Recon Lead", "Sniper", "Drone Operator"], ["MMG Lead", "MMG Gunner"], ["HMG Lead", "HMG Gunner"], ["GMG Lead", "GMG Gunner"], ["MAT Lead", "MAT Gunner"],["HAT Lead", "HAT Gunner"], ["AA Lead", "AA Gunner"], ["Mortar Lead", "Mortar Gunner"], ["Crew Commander", "Crewman"], ["Rotary Pilot", "Fixed-Wing Pilot"]],
		[["plt", "logi", "plt_eod", "plt_med", "tacp"], ["sqd_ld", "sqd_med", "sqd_eng", "sqd_lat", "sqd_brc", "sqd_gre", "sqd_ar", "sqd_aar"], ["sf_ld", "sf_med", "sf_dmr", "sf_eng"], ["rcn_ld", "rcn_sni", "rcn_drone"], ["sup_mmg_l", "sup_mmg_g"], ["sup_hmg_l", "sup_hmg_g"], ["sup_gmg_l", "sup_gmg_g"], ["sup_mat_l", "sup_mat_g"], ["sup_hat_l", "sup_hat_g"], ["sup_aa_l", "sup_aa_g"], ["sup_mor_l", "sup_mor_g"], ["ar_ld", "ar_c"], ["r_pil","f_pil"]]
	];

_avialableLoadouts