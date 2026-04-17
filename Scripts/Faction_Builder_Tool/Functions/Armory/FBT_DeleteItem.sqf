/*
    FBT_DeleteItem.sqf
    -------------------------------
    Handles removal of Roles, Attachments, or Items.
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _dummy = missionNamespace getVariable ["FBT_Preview_Unit", objNull];
private _masterHash = missionNamespace getVariable ["FBT_MasterHash", createHashMap];

// 1. Check if a Slot/Content is selected in Column 3
private _ctrlSlots = _display displayCtrl 456080;
private _slotIdx = lbCurSel _ctrlSlots;

if (_slotIdx != -1) then {
    private _activeSlot = _display getVariable ["FBT_ActiveSlot", ""];
    private _activeCat  = (lbData [456070, lbCurSel 456070]);

    if (_activeSlot != "" && !isNull _dummy) then {
        // Remove attachment
        switch (_activeSlot) do {
            case "optic":  { _dummy removePrimaryWeaponItem (primaryWeaponItems _dummy select 0); };
            case "muzzle": { _dummy removePrimaryWeaponItem (primaryWeaponItems _dummy select 1); };
            case "acc":    { _dummy removePrimaryWeaponItem (primaryWeaponItems _dummy select 2); };
            case "bipod":  { _dummy removePrimaryWeaponItem (primaryWeaponItems _dummy select 3); };
        };
        systemChat format ["Removed %1 from weapon.", _activeSlot];
        
        // Update Hashmap (Clear the key)
        private _tree = _display displayCtrl 456010;
        private _path = tvCurSel _tree;
        if (count _path > 0) then {
            private _roleId = _tree tvData _path;
            private _roleData = (_masterHash get "Armory") getOrDefault [_roleId, createHashMap];
            _roleData deleteAt (_activeCat + "_" + _activeSlot);
        };
    } else {
        // Handle Role Deletion (Original logic)
        private _tree = _display displayCtrl 456010;
        private _path = tvCurSel _tree;
        if (count _path > 0) then {
            private _roleId = _tree tvData _path;
            // Remove from sequence and armory
            private _seq = _masterHash getOrDefault ["ArmorySequence", []];
            private _newSeq = _seq select { (_x select 0) != _roleId };
            _masterHash set ["ArmorySequence", _newSeq];
            (_masterHash get "Armory") deleteAt _roleId;
            
            systemChat "Role removed from hierarchy.";
            // Refresh
            [] spawn { uiSleep 0.1; execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf"; };
        };
    };
} else {
    // Standard Role Deletion if no slot is focused
    private _tree = _display displayCtrl 456010;
    private _path = tvCurSel _tree;
    if (count _path > 0) then {
        private _roleId = _tree tvData _path;
        private _seq = _masterHash getOrDefault ["ArmorySequence", []];
        private _newSeq = _seq select { (_x select 0) != _roleId };
        _masterHash set ["ArmorySequence", _newSeq];
        (_masterHash get "Armory") deleteAt _roleId;
        systemChat "Role removed from hierarchy.";
        [] spawn { uiSleep 0.1; execVM "Scripts\Faction_Builder_Tool\Functions\Staging\FBT_SpawnParade.sqf"; };
    };
};
