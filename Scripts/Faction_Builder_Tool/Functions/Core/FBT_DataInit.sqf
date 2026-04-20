/*
    FBT_DataInit.sqf
    -------------------------------
    Initializes the master Hashmap and the Pythia Bridge.
*/

// 0. Initialize Pythia Bridge
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Bridge_Init.sqf";
[] call compile preprocessFileLineNumbers "Scripts\Faction_Builder_Tool\Functions\Core\FBT_Pythia_Sync.sqf";

private _masterHash = createHashMap;

// 1. Metadata
private _metadata = createHashMap;
_metadata set ["SIDE", "BLUFOR"];
_metadata set ["FACTIONNAME", "New FBT Faction"];
_metadata set ["SUBFACTION", ""];
_metadata set ["CAMO", "Desert"];
_metadata set ["ERA", "Modern"];
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

// 5. Modular Metadata (BigArmory Integration)
_masterHash set ["SlotGroups", createHashMap];
_masterHash set ["GunGroups", createHashMap];
_masterHash set ["Attachment_Standards", createHashMap];
_masterHash set ["SightGroups", createHashMap];

missionNamespace setVariable ["FBT_MasterHash", _masterHash];

diag_log "[FBT] Master Data Store Initialized.";
