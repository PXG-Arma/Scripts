params ["_weaponClass"];


private _picture = "";

if (isNil "_weaponClass") then {
	_weaponClass = "NONE";
};

if (_weaponClass == "NONE") then {
	_picture = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_primary_gs.paa";
	} else {
	_picture = getText (configFile >> "CfgWeapons" >> _weaponClass >> "picture");
	};

_picture
