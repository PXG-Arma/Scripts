params["_loadout"];

private _uniforms = getArray (_loadout >> "uniform");

if (count _uniforms > 0) then {
	private _uniform = selectRandom _uniforms;
	player forceAddUniform _uniform;
};

private _vests = getArray (_loadout >> "vest");

if (count _vests > 0) then {
	private _vest = selectRandom _vests;
	player addVest _vest;
};

private _backpacks = getArray (_loadout >> "backpack");

if (count _backpacks > 0) then {
	private _backpack = selectRandom _backpacks;
	player addBackpack _backpack;
};

private _headgears = getArray (_loadout >> "headgear");
private _randomizeHeadgear = getNumber (_loadout >> "randomizeHeadgear");

if (count _headgears > 0) then {
	private _headgear = "";
	if (_randomizeHeadgear == 1) then {
		_headgear = selectRandom _headgears;

	} else {
		_headgear = _headgears select 0;
	};

	player addHeadgear _headgear;
};



