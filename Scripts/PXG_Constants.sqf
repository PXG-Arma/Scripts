// PXG Centralized Metadata Constants
// This file defines the available camouflage and era types for the PXG template.
// Mission editors can reference these when defining factions.

PXG_Camo_Types = ["Woodland", "Desert", "Snow", "Poly", "Urban", "Winter", "Jungle", "Arid", "Multi", "Night", "Police", "Generic"];
PXG_Era_Types = ["Modern", "Late", "Early", "WW2"];

publicVariable "PXG_Camo_Types";
publicVariable "PXG_Era_Types";

// Resupply Registry: [SupplyName, [Classname, CargoSize, SpecialScript]]
PXG_Resupply_Crate_Registry = createHashMapFromArray [
	["FOB", ["B_supplyCrate_F", 7, "Scripts\Resupply\Functions\PXG_Add_FOB_Option.sqf"]],
	["FARP", ["B_supplyCrate_F", 7, "Scripts\Resupply\Functions\PXG_Add_FARP_Option.sqf"]],
	["Wheel", ["ACE_Wheel", 1, ""]],
	["Track", ["ACE_Track", 2, ""]],
	["Slingloadable Crate (8)", ["B_CargoNet_01_ammo_F", 7, ""]],
	["LAT Resupply", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["MAT Resupply", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["MAT Resupply (HEAT)", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["MAT Resupply (Misc.)", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["HAT Resupply", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["AA Resupply", ["Box_NATO_WpsLaunch_F", 2, ""]],
	["40mm Heavy", ["Box_NATO_Grenades_F", 1, ""]],
	["40mm Grenades", ["Box_NATO_Grenades_F", 1, ""]],
	["Grenades", ["Box_NATO_Grenades_F", 1, ""]],
	["Hand Grenades", ["Box_NATO_Grenades_F", 1, ""]],
	["40mm Flares", ["Box_NATO_Support_F", 1, ""]],
	["40mm Smoke Rounds", ["Box_NATO_Support_F", 1, ""]],
	["Smoke Grenades", ["Box_NATO_Support_F", 1, ""]],
	["Stun Grenades", ["Box_NATO_Support_F", 1, ""]],
	["Misc. Medical Supplies", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Basic Medical Supplies", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Advanced Medical Supplies", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Autoinjectors", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Bandages", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Blood IVs", ["Land_PlasticCase_01_medium_gray_F", 1, ""]],
	["Breaching Charges", ["Box_NATO_AmmoOrd_F", 1, ""]],
	["Explosives", ["Box_NATO_AmmoOrd_F", 1, ""]],
	["Squad Resupply", ["Box_NATO_WpsSpecial_F", 2, ""]],
	["Parachutes", ["Box_NATO_Equip_F", 1, ""]],
	["Default", ["Box_NATO_Ammo_F", 1, ""]]
];
publicVariable "PXG_Resupply_Crate_Registry";
