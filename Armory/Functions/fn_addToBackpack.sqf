params ["_unit", "_item", "_quantity"];

if ( _quantity > 0 ) then {
	private _canFit = _unit canAddItemToBackpack [_item, _quantity];

	if ( _canFit ) then {
		for "_i" from 1 to _quantity do { 
			_unit addItemToBackpack _item;
		};
	} else {
		hint format ["Could not add %1 to Backpack.", _item];
	};
};
