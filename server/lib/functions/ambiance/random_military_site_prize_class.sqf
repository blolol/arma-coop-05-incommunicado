/**
 * Returns a random military site "prize" vehicle class based on weights.
**/

private ["_debug"];
_debug = { ["BLOL_fnc_ambiance_randomMilitarySitePrizeClass", _this] call BLOL_fnc_debug };

if (isNil "BLOL_cfg_militarySitePrizes") then {
	_prizeConfigs = ["config", "MilitarySites", "Prizes"] call BLOL_fnc_config;
	_prizeClasses = [];
	_prizeWeights = [];

	for "_i" from 0 to ((count _prizeConfigs) - 1) do {
		private ["_prize"];
		_prize = _prizeConfigs select _i;
		_class = configName _prize;
		_weight = getNumber (_prize >> "weight");

		[_prizeClasses, _class] call BIS_fnc_arrayPush;
		[_prizeWeights, _weight] call BIS_fnc_arrayPush;
	};

	BLOL_cfg_militarySitePrizes = [_prizeClasses, _prizeWeights];

	["Prize config: %1", BLOL_cfg_militarySitePrizes] call _debug;
};

BLOL_cfg_militarySitePrizes call BIS_fnc_selectRandomWeighted;
