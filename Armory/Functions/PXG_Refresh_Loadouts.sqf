// Get selected item from faction list
 _indexFaction = tvCurSel 431501;

// Get faction name 
_factionName = tvText [431501, _indexFaction];
_faction = "getText (_x >> 'name') == _factionName" configClasses (missionConfigFile >> "PXGfactions");

_loadouts = "getNumber (_x >> 'displayInArmory') == 1" configClasses (_faction select 0);

_elementsArray = [];

// go through each subcllass in the faction and check if its displayed in armory

{
	_element = getText (_x >> "element");
	if (_element in _elementsArray) then {
		// do nothing
	} else {
		_elementsArray pushBack _element;
	};
} forEach _loadouts;

tvClear 431503;

{
	tvAdd [431503, [], _x];
} forEach _elementsArray;
// Clear loadout tree list 

{
	// Add element to tree list
	// Position of element in tree list
	_parentElement = _forEachIndex; 

	_element = _x; 

	{
		if (getText (_x >> "element") == _element) then{
			tvAdd[431503, [_parentElement], getText (_x >> "displayName")]
		};
	} forEach _loadouts;

}	forEach _elementsArray;

_loadoutMemory = player getVariable ["PXG_Armory_Memory_Loadout", [-1,-1]];
if (_loadoutMemory select 0 != -1) then {tvSetCurSel [431503, _loadoutMemory]};

call compile preprocessFile "Scripts\Armory\Functions\PXG_Preview_Loadout.sqf";
call compile preprocessFile "Scripts\Armory\Functions\PXG_ButtonPress.sqf";


