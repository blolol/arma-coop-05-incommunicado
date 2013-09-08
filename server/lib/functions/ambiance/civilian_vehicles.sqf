/**
 * Spawns civilian vehicles in villages and cities near players.
**/

#define LOCATION_TYPES ["NameLocal", "NameVillage", "NameCity", "NameCityCapital"]

private ["_debug", "_vehicleClasses"];
_debug = { ["BLOL_fnc_ambiance_civilianVehicles", _this] call BLOL_fnc_debug };

// Initialize BLOL_cfg_civilianVehicles
call BLOL_fnc_ambiance_randomCivilianVehicleClass;
_vehicleClasses = BLOL_cfg_civilianVehicles select 0;

while { true } do {
	sleep 10;

	private ["_locations"];
	_locations = [1000, LOCATION_TYPES] call BLOL_fnc_players_nearbyLocations;

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

		// Determine how many vehicles to spawn
		_spawnCount = ["array", "AmbientCivilianVehicles", "Locations", (type _location),
			"minMaxVehicles"] call BLOL_fnc_config;
		_spawnCount = _spawnCount call BIS_fnc_randomInt;

		["Computed appropriate spawn count of %1 for %2 (%3)", _spawnCount,
			_name, (type _location)] call _debug;

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
				_vehicleClass = call BLOL_fnc_ambiance_randomCivilianVehicleClass;
				_direction = [0, 360] call BIS_fnc_randomInt;
				_damage = call BLOL_fnc_ambiance_randomVehicleDamage;
				_fuel = call BLOL_fnc_ambiance_randomVehicleFuel;

				_vehicle = createVehicle [_vehicleClass, _position, [], 25, "NONE"];
				_vehicle setDir _direction;
				_vehicle setDamage _damage;
				_vehicle setFuel _fuel;

				if (BLOL_debug) then {
					private ["_markerName", "_marker"];

					["Spawned a %1 near %2 with %3 damage and %4 fuel", _vehicleClass, _name,
						_damage, _fuel] call _debug;

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
