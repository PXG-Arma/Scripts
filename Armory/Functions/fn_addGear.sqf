params["_loadout"];

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
if (getNumber (_loadout >> "HasGPS") == 1) then {
	player linkItem "ItemGPS";
};

private _NVGs = player getVariable ["PXG_armory_NVGsSelected", ""];
player linkItem _NVGs;

private _binoculars = player getVariable ["PXG_armory_binocularsSelected", ""];
player addWeapon _binoculars;


private _gearArray = [];

private _coreGear = getArray (_loadout >> "coreGear");

for "_i" from 0 to (count _coreGear-1) step 2 do {
	private _items = [_coreGear select _i, _coreGear select _i+1];
	_gearArray pushBack _items; 	
};	

private _eraGear = getArray (_loadout >> "eraGear");

for "_i" from 0 to (count _eraGear-1) step 2 do {
	private _items = [_eraGear select _i, _eraGear select _i+1];
	_gearArray pushBack _items; 	
};

private _factionGear = getArray (_loadout >> "factionGear");

for "_i" from 0 to (count _factionGear-1) step 2 do {
	private _items = [_factionGear select _i, _factionGear select _i+1];
	_gearArray pushBack _items; 	
};

{
	private _item = _x select 0;
	private _count = _x select 1;
	
	[player, _item, _count] call compile preprocessFile "scripts\Armory\Functions\fn_addToAnywhere.sqf";

} forEach _gearArray;