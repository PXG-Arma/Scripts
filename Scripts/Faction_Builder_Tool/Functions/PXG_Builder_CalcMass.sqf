/*
    PXG_Builder_CalcMass.sqf
    -------------------------------
    Calculates the total mass of the selected 'Stack' (Item * Amount).
*/
disableSerialization;
private _display = findDisplay 456000;
if (isNull _display) exitWith {};

private _ctrlAmount = _display displayCtrl 456081;
private _ctrlMass   = _display displayCtrl 456082;
private _ctrlList   = _display displayCtrl 456020;

private _amount = parseNumber (ctrlText _ctrlAmount);
if (_amount <= 0) then { _amount = 1; };

private _className = _ctrlList lbData (lbCurSel _ctrlList);
if (_className == "") exitWith { _ctrlMass ctrlSetText "MASS: 0.0"; };

// 1. Fetch Item Mass from Config
private _mass = 0;
private _cfg = configFile >> "CfgWeapons" >> _className;
if (!isClass _cfg) then { _cfg = configFile >> "CfgMagazines" >> _className; };
if (!isClass _cfg) then { _cfg = configFile >> "CfgVehicles" >> _className; };

if (isClass (_cfg >> "ItemInfo")) then {
    _mass = getNumber (_cfg >> "ItemInfo" >> "mass");
} else {
    _mass = getNumber (_cfg >> "mass");
};

// 2. Display Result
private _totalMass = _mass * _amount;
_ctrlMass ctrlSetText format ["MASS: %1", _totalMass];
_ctrlMass ctrlCommit 0;
