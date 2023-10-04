params ["_unit", "_item", "_quantity"];

if ( _quantity > 0 ) then {
	private _canFit = _unit canAddItemToUniform [_item, _quantity];

	if ( _canFit ) then {
		for "_i" from 1 to _quantity do { 
			_unit addItemToUniform _item;
		};
	} else {
		hint format ["Could not add %1 to Uniform.", _item];
	};
};
