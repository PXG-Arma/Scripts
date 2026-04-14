#include "..\..\macros.hpp"

// Get selected item from Side Listbox
private _selectedSideIdx = lbCurSel IDC_RESUPPLY_SIDE;
private _targetSide = switch (_selectedSideIdx) do {
	case 0: {"BLUFOR"};
	case 1: {"OPFOR"};
	case 2: {"INDEP"};
	default {""};
};

// Clear dependent lists
lbClear IDC_RESUPPLY_SUPPLIES_LB;
private _displayResupply = findDisplay IDD_RESUPPLY;
(_displayResupply displayCtrl IDC_RESUPPLY_CONTENTS_TEXT) ctrlSetStructuredText parseText "";

// Populate Faction Tree using central utility
[IDC_RESUPPLY_FACTION_TREE, _targetSide, "PXG_Resupply_Memory_Faction"] call compile preprocessFile "Scripts\Factions\PXG_Build_Faction_Tree.sqf";