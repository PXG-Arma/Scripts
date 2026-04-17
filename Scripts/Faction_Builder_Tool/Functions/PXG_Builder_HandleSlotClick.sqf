/*
    PXG_Builder_HandleSlotClick.sqf
    -------------------------------
    Fired when: User clicks a Slot/Category in the 3rd Column.
*/
params ["_ctrl", "_index"];
disableSerialization;

private _display = findDisplay 456000;
private _slotType = _ctrl lbData _index; // e.g. "optic", "medic", etc.
private _ctrlList = _display displayCtrl 456020; // Middle Browser
private _dummy = missionNamespace getVariable ["PXG_Builder_Preview_Unit", objNull];

// Store the active slot so ApplyGear knows where to put the item
_display setVariable ["PXG_Builder_ActiveSlot", _slotType];

// 1. Logic for Weapons
if (_slotType in ["optic", "muzzle", "acc", "bipod"]) then {
    private _compat = [_dummy, _slotType] call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_GetCompatibleItems.sqf");
    
    lbClear _ctrlList;
    {
        private _idx = _ctrlList lbAdd (_x select 0);
        _ctrlList lbSetPicture [_idx, _x select 2];
        _ctrlList lbSetData [_idx, _x select 1];
    } forEach _compat;
    systemChat format ["Filtering for compatible %1 items...", _slotType];
};

// 2. Logic for Containers & Ammo
if (_slotType in ["medic", "ammo", "grenade", "misc"]) then {
    lbClear _ctrlList;

    if (_slotType == "ammo") then {
        private _compMags = call (compile preprocessFile "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_GetCompatibleMags.sqf");
        {
            private _idx = _ctrlList lbAdd (_x select 0);
            _ctrlList lbSetPicture [_idx, _x select 2];
            _ctrlList lbSetData [_idx, _x select 1];
        } forEach _compMags;
        systemChat "Intelligent Magazine Filter Active.";
    };

    // Placeholder for other supply groups
    if (_slotType in ["medic", "grenade", "misc"]) then {
        systemChat format ["Populating %1 supplies...", _slotType];
    };
    
    // Refresh Mass calculation for new list
    [] execVM "Scripts\Faction_Builder_Tool\Functions\PXG_Builder_CalcMass.sqf";
};

