#include "..\..\macros.hpp"

// Get selected item from Side Listbox
private _selectedSideIdx = lbCurSel IDC_ARMORY_SIDE;
private _targetSide = switch (_selectedSideIdx) do {
	case 0: {"BLUFOR"};
	case 1: {"OPFOR"};
	case 2: {"INDEP"};
	default {""};
};

// Clear dependent trees
tvClear IDC_ARMORY_LOADOUT_TREE;

// Populate Faction Tree using central utility
[IDC_ARMORY_FACTION_TREE, _targetSide, "PXG_Armory_Memory_Faction"] call compile preprocessFile "Scripts\Factions\PXG_Build_Faction_Tree.sqf";
