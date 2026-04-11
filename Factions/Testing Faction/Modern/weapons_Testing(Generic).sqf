// MODE "GIVE" (default): Assigns weapon to player
// MODE "LIST": Returns array of selectable weapons for the role
// MODE "SCOPES": Returns array of allowed scopes for a specific weapon

params["_side","_faction","_variant", "_loadout", ["_mode", "GIVE"], ["_weapon", ""]]; 

// ====================================================================================
// MODE: LIST (Selectable Weapons for the UI)
if (_mode == "LIST") exitWith {
	_list = switch (_loadout) do {
		case "sqd_ld": { ["rhs_weap_m4a1_carryhandle_m203S", "rhs_weap_m4a1_carryhandle"] };
		case "rif": { ["rhs_weap_m4a1_carryhandle"] };
		case "ar": {["BWA3_MG3"]};
		default { ["rhs_weap_m4a1_carryhandle"] };
	};
	_list
};

// ====================================================================================
// MODE: SCOPES (Allowed Optics for each weapon in this faction)
if (_mode == "SCOPES") exitWith {
	_scopes = switch (_weapon) do {
		case "rhs_weap_m4a1_carryhandle_m203S";
		case "rhs_weap_m4a1_carryhandle": { ["rhsusf_acc_compm4", "rhsusf_acc_eotech_xps3"] };
		case "BWA3_MG3": { [] };
		default { [] };
	};
	_scopes
};

// ====================================================================================
// MODE: DEFAULT (Returns the classname of the default weapon for the role)
if (_mode == "DEFAULT") exitWith {
	_default = switch (_loadout) do {
		case "sqd_ld": { "rhs_weap_m4a1_carryhandle_m203S" };
		default { "rhs_weap_m4a1_carryhandle" };
	};
	_default
};

// ====================================================================================
// MODE: DEFAULTSCOPE (Returns the classname of the default scope for the role)
if (_mode == "DEFAULTSCOPE") exitWith {
	_defaultScope = switch (_loadout) do {
		default { "rhsusf_acc_compm4" };
	};
	_defaultScope
};

// ====================================================================================
// MODE: GIVE (Original logic for arming the player)
switch (_loadout) do {
	default { player addWeapon "rhs_weap_m4a1_carryhandle"; };
	case "sqd_ld": { player addWeapon "rhs_weap_m4a1_carryhandle_m203S"; };
};
