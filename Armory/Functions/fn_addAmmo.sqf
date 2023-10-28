params ["_loadout"];

private _ammoToAdd = []; 

private _primaryWeapon = player getVariable ["PXG_armory_primarySelected", ""];

private _primaryMagazines = getArray (_loadout >> "primaryMagazines");
private _secondaryMagazines = getArray (_loadout >> "secondaryMagazines");
private _launcherMagazines = getArray (_loadout >> "launcherMagazines");

private _assistantMagazines = getArray (_loadout >> "assistantMagazines");
private _throwables = getArray (_loadout >> "throwables");

for "_i" from 0 to (count _throwables - 1) step 2 do {
	private _items = [_throwables select _i, _throwables select _i + 1];
	_ammoToAdd pushBack _items;
};

for "_i" from 0 to (count _primaryMagazines - 1) step 2 do {
	private _isCompatible = _primaryMagazines select _i in compatibleMagazines _primaryWeapon;
	private _items = [_primaryMagazines select _i, _primaryMagazines select _i + 1];
	
	if (_isCompatible) then {
		_ammoToAdd pushBack _items;
	};
};

for "_i" from 0 to (count _secondaryMagazines - 1) step 2 do {
	private _items = [_secondaryMagazines select _i, _secondaryMagazines select _i + 1];
	_ammoToAdd pushBack _items;
};

for "_i" from 0 to (count _launcherMagazines - 1) step 2 do {
	private _items = [_launcherMagazines select _i, _launcherMagazines select _i + 1];
	_ammoToAdd pushBack _items;
};

for "_i" from 0 to (count _assistantMagazines - 1) step 2 do {
	private _items = [_assistantMagazines select _i, _assistantMagazines select _i + 1];
	_ammoToAdd pushBack _items;
};

{
	private _item = _x select 0;
	private _count = _x select 1;
	
	[player, _item, _count] call compile preprocessFile "scripts\Armory\Functions\fn_addToAnywhere.sqf";

} forEach _ammoToAdd;