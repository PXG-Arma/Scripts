params["_side","_faction","_variant", "_loadout"]; 

// Sets default value for short and long range radio
_srCh = 1;
_lrCh1 = 1;   // e.g. PRC-152
_lrCh2 = 3;   // e.g. PRC-152 TACP SR
_lrCh3 = 1;   // e.g. PRC-117F
_lrCh4 = 2;   // e.g. PRC-117F Air

// Gets slot ID 
_slotGroup = player getVariable "PXG_Slot_Group"; 
_slotRole = player getVariable "PXG_Slot_Role";

// Assigns correct channel based on ID 
switch (_slotGroup) do {
	default { };
	case "plt": {_srCh = 1};
	case "logi": {_srCh = 1};
	case "sqd1": {_srCh = 2};
	case "sqd2": {_srCh = 3};
	case "sqd3": {_srCh = 4};
	case "sup1": {_srCh = 5};
	case "sup2": {_srCh = 6};
	case "sup3": {_srCh = 7};
	case "sup4": {_srCh = 8};
	case "sup5": {_srCh = 9};
	case "sup6": {_srCh = 10};
	case "sup7": {_srCh = 11};
	case "sf1": {_srCh = 12};
	case "sf2": {_srCh = 13};
	case "rcn1": {_srCh = 14};
	case "rcn2": {_srCh = 15};
	case "ar1": {_srCh = 16};
	case "ar2": {_srCh = 17};
	case "ar3": {_srCh = 18};
	case "ar4": {_srCh = 19};
};

// Wait for all radios to initialize 
waitUntil { ([] call acre_api_fnc_isInitialized) };

/// Check for radio type
_hasRadio343 = [player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio;
_hasRadio152 = [player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio;
_hasRadio117 = [player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio;

// set radio channel, default channel 1 is correct for most 152s and 117. Hence only swap channel in specific case.
if (_hasradio343) then { [(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), _srCh] call acre_api_fnc_setRadioChannel};
//if (_hasradio152 && _slotGroup == "plt") then { [(["ACRE_PRC152"] call acre_api_fnc_getRadioByType), _srCh] call acre_api_fnc_setRadioChannel};
if (_hasradio152 && _loadout == "r_pil") then { [(["ACRE_PRC152"] call acre_api_fnc_getRadioByType), _lrCh4] call acre_api_fnc_setRadioChannel};
if (_hasradio152 && _loadout == "f_pil") then { [(["ACRE_PRC152"] call acre_api_fnc_getRadioByType), _lrCh4] call acre_api_fnc_setRadioChannel};

// Set LR radio channel (117F) only if FAC1
if (_hasRadio117 && _slotRole == "fac1") then {
    private _radio = ["ACRE_PRC117F"] call acre_api_fnc_getRadioByType;
    [_radio, _lrCh3] call acre_api_fnc_setRadioChannel;
};

// Set LR radio channel (117F) only if FAC2
if (_hasRadio117 && _slotRole == "fac2") then {
    private _radio = ["ACRE_PRC117F"] call acre_api_fnc_getRadioByType;
    [_radio, _lrCh4] call acre_api_fnc_setRadioChannel;
};

// Set LR radio channel (152) only if FAC1
if (_hasRadio152 && _slotRole == "fac1") then {
    private _radio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;
    [_radio, _lrCh2] call acre_api_fnc_setRadioChannel;
};

// Set LR radio channel (152) only if FAC2
if (_hasRadio152 && _slotRole == "fac2") then {
    private _radio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;
    [_radio, _lrCh2] call acre_api_fnc_setRadioChannel;
};