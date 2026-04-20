#include "..\..\macros.hpp"

// Get selected item from Side Listbox
private _selectedSideIdx = lbCurSel IDC_MOTORPOOL_SIDE;
private _targetSide = switch (_selectedSideIdx) do {
	case 0: {"BLUFOR"};
	case 1: {"OPFOR"};
	case 2: {"INDEP"};
	default {""};
};

// Feature Restoration: Save side to memory
player setVariable ["PXG_Motorpool_Memory_Side", _selectedSideIdx];

// Clear dependent lists
tvClear IDC_MOTORPOOL_VEHICLE_LB;

// Populate Faction Tree using central utility
[IDC_MOTORPOOL_FACTION_TREE, _targetSide, "PXG_Motorpool_Memory_Faction"] call compile preprocessFile "Scripts\Factions\PXG_Build_Faction_Tree.sqf";