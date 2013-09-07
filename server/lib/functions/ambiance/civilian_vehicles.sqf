/**
 * Spawns civilian vehicles in villages and cities near players.
**/

private ["_debug", "_vehicleClassesAndWeights", "_vehicleClasses", "_vehicleWeights"];
_debug = { ["BLOL_fnc_ambiance_civilianVehicles", _this] call BLOL_fnc_debug };

_vehicleClassesAndWeights = [
	["C_Hatchback_01_F", 0.5],
	["C_Hatchback_01_sport_F", 0.1],
	["C_Offroad_01_F", 0.95],
	["I_G_Offroad_01_F", 0.75],
	["C_Quadbike_01_F", 0.85],
	["C_SUV_01_F", 0.2],
	["C_Van_01_transport_F", 0.4],
	["C_Van_01_box_F", 0.4]
];

_vehicleClasses = [];
_vehicleWeights = [];

{
	_class = _x select 0;
	_weight = _x select 1;
	[_vehicleClasses, _class] call BIS_fnc_arrayPush;
	[_vehicleWeights, _weight] call BIS_fnc_arrayPush;
} forEach _vehicleClassesAndWeights;

while { true } do {
	sleep 10;

	private ["_locations"];
	_locations = [1000] call BLOL_fnc_players_nearbyLocations;

	{
		private ["_location", "_position", "_name", "_size", "_radius", "_roads",
			"_spawnCount", "_existingCount"];

		_location = _x;
		_position = position _location;
		_name = text _location;

		// Find the largest dimension of the location size (e.g. [500, 400] => 500 m)
		_size = [(size _location), 1] call BIS_fnc_findExtreme;

		// Spawn vehicles within the location and a little bit outside of it
		_radius = _size * 1.25;

		// Find road segments surrounding the location and a little bit outside of it
		_roads = _position nearRoads _radius;

		// Determine how many vehicles to spawn by dividing the largest location size
		// dimension by 100 and rounding to the nearest integer (so that a village that
		// is 230 m on its largest dimension might spawn two vehicles), or, in the weird
		// case that there are less road segments than (SIZE / 100), use the number of
		// nearby road segments. Then, randomize that count a bit.
		_spawnCount = [[round (_size / 100), (count _roads)], 0] call BIS_fnc_findExtreme;
		_spawnCount = round (_spawnCount * (random 0.75));

		["Computed appropriate spawn count of %1 for %2 (%3)", _spawnCount,
			_name, (size _location)] call _debug;

		// Search for existing civilian vehicles within the spawn radius
		_existingCount = count (nearestObjects [_position, _vehicleClasses, _radius]);

		["Found %1 civilian vehicles already spawned near %2", _existingCount, _name] call _debug;

		if (_existingCount < _spawnCount) then {
			private ["_roadSegments"];

			_spawnCount = _spawnCount - _existingCount;

			["Spawning %1 civilian vehicles near %2", _spawnCount, _name] call _debug;

			_roadSegments = [(_roads call BIS_fnc_arrayShuffle), 0, (_spawnCount - 1)]
				call BIS_fnc_subSelect;

			{
				private ["_roadSegment", "_position", "_vehicleClass", "_direction",
					"_damage", "_fuel", "_vehicle"];

				_roadSegment = _x;
				_position = position _roadSegment;
				_vehicleClass = [_vehicleClasses, _vehicleWeights]
					call BIS_fnc_selectRandomWeighted;
				_direction = [0, 360] call BIS_fnc_randomInt;
				_damage = call BLOL_fnc_ambiance_randomVehicleDamage;
				_fuel = call BLOL_fnc_ambiance_randomVehicleFuel;

				_vehicle = createVehicle [_vehicleClass, _position, [], 25, "NONE"];
				_vehicle setDir _direction;
				_vehicle setDamage _damage;
				_vehicle setFuel _fuel;

				if (BLOL_debug) then {
					private ["_markerName", "_marker"];

					["Spawned a %1-damage %2 near %3 with %4 fuel", _damage,
						_vehicleClass, _name, _fuel] call _debug;

					_markerName = format ["spawn_%1_%1", _forEachIndex,
						([0, 1000] call BIS_fnc_randomInt)];
					_marker = createMarkerLocal [_markerName, _position];
					_marker setMarkerShapeLocal "ICON";
					_marker setMarkerTypeLocal "hd_dot";
					_marker setMarkerColor "ColorGreen";
				};
			} forEach _roadSegments;
		} else {
			["Skipping civilian vehicle spawn near %1 because there are already " +
				"enough vehicles", _name] call _debug;
		};
	} forEach _locations;
};
