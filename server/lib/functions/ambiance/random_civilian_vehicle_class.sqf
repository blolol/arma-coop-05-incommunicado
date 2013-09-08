/**
 * Returns a random civilian vehicle class based on weights.
**/

private ["_debug"];
_debug = { ["BLOL_fnc_ambiance_randomCivilianVehicle", _this] call BLOL_fnc_debug };

if (isNil "BLOL_cfg_civilianVehicles") then {
	_vehicleConfigs = ["config", "AmbientCivilianVehicles", "Vehicles"] call BLOL_fnc_config;
	_vehicleClasses = [];
	_vehicleWeights = [];

	for "_i" from 0 to ((count _vehicleConfigs) - 1) do {
		private ["_vehicle"];
		_vehicle = _vehicleConfigs select _i;
		_class = configName _vehicle;
		_weight = getNumber (_vehicle >> "weight");

		[_vehicleClasses, _class] call BIS_fnc_arrayPush;
		[_vehicleWeights, _weight] call BIS_fnc_arrayPush;
	};

	BLOL_cfg_civilianVehicles = [_vehicleClasses, _vehicleWeights];

	["Vehicle config: %1", BLOL_cfg_civilianVehicles] call _debug;
};

BLOL_cfg_civilianVehicles call BIS_fnc_selectRandomWeighted;
