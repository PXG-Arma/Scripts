params["_loadout"];

private _primary = player getVariable ["PXG_armory_primarySelected", ""];
player addWeapon _primary;

// add attachements 
private _primaryOptic = player getVariable ["PXG_armory_primaryOpticsSelected", ""];
player addPrimaryWeaponItem _primaryOptic;

private _primaryMuzzle = player getVariable ["PXG_armory_primaryMuzzlesSelected", ""];
player addPrimaryWeaponItem _primaryMuzzle;

private _primaryGrip = player getVariable ["PXG_armory_primaryGripsSelected", ""];
player addPrimaryWeaponItem _primaryGrip;

private _primaryLight = player getVariable ["PXG_armory_primaryLightsSelected", ""];
player addPrimaryWeaponItem _primaryLight;


private _launcher = player getVariable ["PXG_armory_launcherSelected", ""];
player addWeapon _launcher;

private _launcherOptic = player getVariable ["PXG_armory_launcherOpticsSelected", ""];
player addSecondaryWeaponItem _launcherOptic;

private _launcherMuzzle = player getVariable ["PXG_armory_launcherMuzzlesSelected", ""];
player addSecondaryWeaponItem _launcherMuzzle;

private _launcherGrip = player getVariable ["PXG_armory_launcherGripsSelected", ""];
player addSecondaryWeaponItem _launcherGrip;

private _launcherLight = player getVariable ["PXG_armory_launcherLightsSelected", ""];
player addSecondaryWeaponItem _launcherLight;



private _secondary = player getVariable ["PXG_armory_secondarySelected", ""];
player addWeapon _secondary;

private _secondaryOptic = player getVariable ["PXG_armory_secondaryOpticsSelected", ""];
player addHandgunItem _secondaryOptic;

private _secondaryMuzzle = player getVariable ["PXG_armory_secondaryMuzzlesSelected", ""];
player addHandgunItem _secondaryMuzzle;

private _secondaryGrip = player getVariable ["PXG_armory_secondaryGripsSelected", ""];
player addHandgunItem _secondaryGrip;

private _secondaryLight = player getVariable ["PXG_armory_secondaryLightsSelected", ""];
player addHandgunItem _secondaryLight;




