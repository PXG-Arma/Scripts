// Welcome to the Faction Weapons file, This should be called "Weapons_FactionName"
// In this file you assign which role gets what weapon
// The equipment given in the -default {} script gets given to everyone, only replaced by cases
// When assigning gear to a case for one role use -case "role": equipment script, when you want multiple roles to follow that specific script use -case "role"; above the assigned gear. take note of the : and ;
// Things of note, PL, TACP, SL, Grenadier, Weapon Team Leads with open backpacks, SF SL, Recon SL and Recon Drone should have grenade launchers. And Backpack deployables go to Uniforms_FactionName isntead.

params["_side","_faction","_variant", "_loadout", ["_mode", "APPLY"], ["_weapon", ""], ["_weaponGroup", ""], ["_roleGroup", ""]]; 

// ====================================================================================
// MODE: SLOTGROUP (Maps Roles to Groups.)
if (_mode == "SLOTGROUP") exitWith {
	_group = switch (_loadout) do {
		case "plt";
		case "tacp";
		case "sqd_ld": { "Lead Elements" };

		case "sqd_med";
		case "sqd_eng";
		case "sqd_lat";
		case "sqd_brc";
		case "sqd_gre";
		case "sqd_hgre";
		case "sqd_ar";
		case "sqd_aar":{ "Squad Members" };

		case "sf_ld";
		case "sf_med";
		case "sf_dmr";
		case "sf_eng":{ "Special Forces" };

		case "rcn_ld";
		case "rcn_sni";
		case "rcn_amr";
		case "rcn_drone": { "Recon" };

		default { "" };
	};
	_group
};

// ====================================================================================
// MODE: GUNGROUP (Weapon Groups Mapping)
if (_mode == "GUNGROUP") exitWith {
	_guns = switch (_loadout) do {
		case "Assault Rifles": { ["rhs_weap_m4a1_carryhandle", "rhs_weap_m4"] };
		case "Lead Rifles": { ["rhs_weap_m4a1_carryhandle_m203S"] };
		case "Machine Guns": { ["rhs_weap_m249_pip_L_para"] };
		case "DMR": { ["rhs_weap_m14ebrri"] };
		case "Snipers": { ["rhs_weap_m40a5_d"] };
		case "AMR": { ["rhs_weap_M107"] };
		case "Shotguns": { ["rhs_weap_M590_8RD"] };
		default { [] };
	};
	_guns
};

// ====================================================================================
// MODE: WEAPASSIGN (Selectable Weapons for the UI)
if (_mode == "WEAPASSIGN") exitWith {
	_list = switch (_loadout) do {
		case "Lead Elements": { ["Lead Rifles"] };
		case "Squad Members": { ["Assault Rifles"] };
		case "Recon": { ["Assault Rifles"] };
		case "Special Forces": { ["Assault Rifles"] };
        
		case "sqd_ar": { ["Machine Guns"] };
		case "rcn_sni": { ["Snipers"] };
		case "rcn_amr": { ["AMR"] };
		case "sqd_brc": { ["Shotguns"] };
		case "sf_dmr": { ["DMR"] };
		
		default { [] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics)
if (_mode == "SCOPES") exitWith {
	_scopes = switch (_roleGroup) do {
		case "Squad Members";
		case "Lead Elements": {
			switch (_weaponGroup) do {
				case "Assault Rifles";
				case "Lead Rifles": { ["rhsusf_acc_compm4", "rhsusf_acc_eotech_xps3"] };
				case "Machine Guns": { ["rhsusf_acc_eotech_xps3"] };
				default { [] };
			};
		};
		case "Recon";
		case "Special Forces": {
			switch (_weaponGroup) do {
				case "Assault Rifles": { ["rhsusf_acc_ACOG_RMR", "rhsusf_acc_compm4", "rhsusf_acc_eotech_xps3"] };
				case "AMR": { ["rhsusf_acc_M8541"] };
				case "DMR": { ["rhsusf_acc_ACOG_RMR"] };
				case "Snipers": { ["rhsusf_acc_M8541_low_d"] };
				default { [] };
			};
		};
		default { [] };
	};
	_scopes
};

// ====================================================================================
// MODE: ATTACHMENTS (Standard Attachments)
if (_mode == "ATTACHMENTS") exitWith {
	_attachments = switch (_weapon) do {
		case "rhs_weap_m4a1_carryhandle": { ["", "rhsusf_acc_anpeq15_bk_top", "rhsusf_acc_grip3"] };
		case "rhs_weap_m4a1_carryhandle_m203S": { ["", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_grip_m203_blk"] };
		case "rhs_weap_m14ebrri": { ["", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_harris_bipod"] };
		case "rhs_weap_m40a5_d": { ["", "", "rhsusf_acc_harris_swivel"] };
		default { ["", "", ""] };
	};
	_attachments
};

// ====================================================================================
// MODE: APPLY (Original Gear Application)
// ====================================================================================
if (_mode == "APPLY") exitWith {
    private _gun = "";
    if (_weapon != "") then {
        _gun = _weapon;
    } else {
        _gun = switch (_loadout) do {
            case "plt";
            case "tacp";
            case "sup_mmg_l";
            case "sup_hmg_l";
            case "sup_mat_l";
            case "sup_hat_l";
            case "sup_aa_l";
            case "rcn_ld";
            case "rcn_drone";
            case "sf_ld";
            case "sqd_gre";
            case "sqd_ld":{ "rhs_weap_m4a1_carryhandle_m203S" };
            case "sqd_hgre": { "rhs_weap_m32" };
            case "sf_med";
            case "sqd_ar": { "rhs_weap_m249_pip_L_para" };
            case "sqd_brc": { "rhs_weap_M590_8RD" };
            case "sf_dmr": { "rhs_weap_m14ebrri" };
            case "rcn_sni": { "rhs_weap_m40a5_d" };
            case "rcn_amr": { "rhs_weap_M107" };
            case "sup_mmg_g": { "rhs_weap_m240G" };
            case "r_pil";
            case "f_pil";
            case "ar_ld";
            case "ar_c": { "rhs_weap_m4" };
            default { "rhs_weap_m4a1_carryhandle" };
        };
    };

    player addWeapon _gun;

    // Apply Standard Attachments (Muzzle, Rail, Bipod)
    private _stdAttachments = [_side, _faction, _variant, _loadout, "ATTACHMENTS", _gun] call compile preprocessFile _fnc_scriptName;
    { if (_x != "") then { player addPrimaryWeaponItem _x }; } forEach _stdAttachments;

    // add secondary weapon
    switch (_loadout) do {
        default {player addWeapon "rhsusf_weap_m9"};
    };

    // add launcher
    switch (_loadout) do {
        default {};
        case "sf_eng": {player addWeapon "rhs_weap_M136";};
        case "sqd_lat": {
            unitBackpack player addItemCargoGlobal["rhs_weap_M136",1];
            player addWeapon "rhs_weap_M136";
        };
        case "sup_mat_g": {player addWeapon "rhs_weap_maaws";
                           player addSecondaryWeaponItem "rhs_optic_maaws"};
        case "sup_hat_g": {	player addWeapon "rhs_weap_fgm148";
                            player addSecondaryWeaponItem "rhs_fgm148_magazine_AT";};					   
        case "sup_aa_g": {	player addWeapon "rhs_weap_fim92"};					
    };
};
