params ["_unit", "_item", "_quantity"];

private _leftoverItems = 0;
private _itemsThatFit = 0;

if ( _quantity > 0 ) then {
	private _canFit = _unit canAddItemToUniform [_item, _quantity];

	if ( _canFit ) then {
		for "_i" from 1 to _quantity do { 
			_unit addItemToUniform _item;
		};
		_itemsThatFit = _quantity;
	} else {
		for "_i" from 1 to _quantity do {
			if ( _unit canAddItemToUniform [_item, 1] ) then {
				_unit addItemToUniform _item;
				_itemsThatFit = _itemsThatFit + 1;
			};
		};
	};
};

_leftoverItems = _quantity - _itemsThatFit;

_leftoverItems 