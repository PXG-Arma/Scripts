params ["_control", "_selectedIndex", "_targetIDC"];

// Prevent error if index is -1
if (_selectedIndex == -1) exitWith {
	ctrlSetText [_targetIDC, ""];
};

// Get classname from the selected list item
_rawPath = _control lbData _selectedIndex;
_pathArray = _rawPath splitString "|";
_className = if (count _pathArray > 0) then { _pathArray select 0 } else { "" };

// Reset preview if no valid classname
if (_className == "" || _className == "default") exitWith {
	ctrlSetText [_targetIDC, ""];
};

// Fetch picture from CfgWeapons
_picture = "";
if (_className == "ironsights") then {
	// Use the custom ironsights texture from the mission folder
	_picture = "Textures\ironsights.paa"; 
} else {
	_picture = getText (configFile >> "CfgWeapons" >> _className >> "picture");
};

// Update the target preview control
ctrlSetText [_targetIDC, _picture];
