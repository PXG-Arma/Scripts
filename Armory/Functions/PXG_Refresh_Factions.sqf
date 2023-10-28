// Get selected item from Side Listbox
_selectedSide = lbCurSel 431500;

// Select side based on item from Side Listbox
_side = switch (_selectedSide) do {
	case 0: {"Blue"};
	case 1: {"Red"};
	case 2: {"Green"};
	default { };
};

_variants = "getText (_x >> 'side') == _side" configClasses (missionConfigFile >> "PXGfactions");

// Clear the faction tree list 
tvClear 431501;
// Clear the loadout tree list
tvClear 431503;


private _factionsArray = [];

{
	private _parentFaction = getText (_x >> "faction");
	if (_parentFaction in _factionsArray) then {
		// Do nothing 
	}	else {
		_factionsArray pushBack _parentFaction;
	};
} forEach _variants;

{
	tvadd [431501, [],_x];
} forEach _factionsArray;




// Fill the faction tree list
{
	// Add faction to tree list
	private _parentFaction = _forEachIndex;

	private _faction =  _x;

	{
		if (getText(_x >> "faction") == _faction) then {
			tvAdd [431501, [_parentFaction], getText (_x >> "name")];
		}
	}	forEach _variants;

}	forEach _factionsArray;

_factionMemory = player getVariable ["PXG_Armory_Memory_Faction", [-1]];
if (_factionMemory select 0 != -1) then {tvSetCurSel [431501, _factionMemory]};

call compile preprocessFile "Scripts\Armory\Functions\PXG_Preview_Loadout.sqf";
call compile preprocessFile "Scripts\Armory\Functions\PXG_ButtonPress.sqf";
