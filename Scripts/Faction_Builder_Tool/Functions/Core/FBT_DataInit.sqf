/*
    FBT_DataInit.sqf
    -------------------------------
    Initializes the master Hashmap used to store the faction configuration.
*/

private _masterHash = createHashMap;

// 1. Metadata
private _metadata = createHashMap;
_metadata set ["FactionName", "New FBT Faction"];
_metadata set ["Side", "BLUFOR"];
_metadata set ["Camo", "Desert"];
_metadata set ["Era", "Modern"];
_masterHash set ["Metadata", _metadata];

// 2. Armory (Gear Hashmaps for roles)
private _armory = createHashMap;
_masterHash set ["Armory", _armory];
_masterHash set ["ArmorySequence", []]; // Ordered list of [RoleID, RoleName, GroupName]

// 3. Motorpool (List of selected vehicles)
private _motorpool = createHashMap;
_masterHash set ["Motorpool", _motorpool];
_masterHash set ["MotorpoolSequence", []]; // Ordered list of [VehicleClass, Category]

// 4. Resupply
private _resupply = createHashMap;
_masterHash set ["Resupply", _resupply];

missionNamespace setVariable ["FBT_MasterHash", _masterHash];

diag_log "[FBT] Master Data Store Initialized.";
