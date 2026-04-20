/*
    Modular_Legacy_Template.sqf
    ----------------------------
    Template for legacy faction Weapons.sqf scripts to support the BigArmory discovery protocol.
*/

params["_side","_faction","_variant", "_loadout", ["_mode", "APPLY"], ["_weapon", ""], ["_weaponGroup", ""], ["_roleGroup", ""]]; 

// ====================================================================================
// MODE: SLOTGROUP (Maps Roles to Groups.)
// ====================================================================================
if (_mode == "SLOTGROUP") exitWith {
	_group = switch (_loadout) do {
		case "plt";
		case "tacp";
		case "sqd_ld": { "Lead Elements" };

		case "sqd_med";
		case "sqd_eng";
		case "sqd_lat";
		case "sqd_ar": { "Squad Members" };

		default { "" };
	};
	_group
};

// ====================================================================================
// MODE: GUNGROUP (Weapon Groups Mapping)
// ====================================================================================
if (_mode == "GUNGROUP") exitWith {
	_guns = switch (_loadout) do {
		case "Assault Rifles": { ["arifle_MX_F", "arifle_MX_Black_F"] };
		case "Machine Guns": { ["LMG_Mk200_F"] };
		default { [] };
	};
	_guns
};

// ====================================================================================
// MODE: WEAPASSIGN (Selectable Weapons for the UI)
// ====================================================================================
if (_mode == "WEAPASSIGN") exitWith {
	_list = switch (_loadout) do {
		case "Lead Elements": { ["Assault Rifles"] };
		case "Squad Members": { ["Assault Rifles"] };
		case "sqd_ar": { ["Machine Guns"] };
		default { [] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics)
// ====================================================================================
if (_mode == "SCOPES") exitWith {
	_scopes = switch (_roleGroup) do {
		case "Squad Members";
		case "Lead Elements": {
			switch (_weaponGroup) do {
				case "Assault Rifles": { ["optic_ACO", "optic_Holosight"] };
				case "Machine Guns": { ["optic_ACO"] };
				default { [] };
			};
		};
		default { [] };
	};
	_scopes
};

// ====================================================================================
// MODE: ATTACHMENTS (Standard Attachments)
// ====================================================================================
if (_mode == "ATTACHMENTS") exitWith {
	_attachments = switch (_weapon) do {
		case "arifle_MX_F": { ["", "acc_pointer_IR", ""] };
		default { ["", "", ""] };
	};
	_attachments
};

// ====================================================================================
// MODE: APPLY (Original Gear Application)
// ====================================================================================
if (_mode == "APPLY") exitWith {
    // Add primary weapon
    switch (_loadout) do {
        default { player addWeapon "arifle_MX_F"; };
        case "sqd_ar": { player addWeapon "LMG_Mk200_F"; };
    };

    // Add secondary weapon
    player addWeapon "hgun_P07_F";

    // Add launcher
    switch (_loadout) do {
        case "sqd_lat": { player addWeapon "launch_NLAW_F"; };
    };
};
