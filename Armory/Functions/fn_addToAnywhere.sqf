params ["_unit", "_item", "_quantity"];

private _leftOverItems = [player, _item, _quantity] call compile preprocessFile "scripts\Armory\Functions\fn_addToUniform.sqf";

if (_leftOverItems > 0) then {
	_leftOverItems = [player, _item, _leftOverItems] call compile preprocessFile "scripts\Armory\Functions\fn_addToVest.sqf";
};

if (_leftOverItems > 0) then {
	_leftOverItems = [player, _item, _leftOverItems] call compile preprocessFile "scripts\Armory\Functions\fn_addToBackpack.sqf";
};

if (_leftOverItems > 0) then {
	hint format ["You have %1 items left over.", _leftOverItems];
};