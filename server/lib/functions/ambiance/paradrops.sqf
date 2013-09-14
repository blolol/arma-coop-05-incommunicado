/**
 * Periodically lands enemy troops near players via helicopter.
**/

#define MIN_DISTANCE_FROM_SPAWN 1000
#define MAX_NEARBY_HELIPADS 3
#define NEARBY_HELIPADS_RADIUS 250

private ["_debug"];
_debug = { ["BLOL_fnc_ambiance_paradrops", _this] call BLOL_fnc_debug };

while { true } do {
	private ["_delay"];

	_delay = [120, 240] call BIS_fnc_randomInt;

	["Waiting %1 seconds until next paradrop attempt...", _delay] call _debug;

	sleep _delay;

	private ["_player"];
	_player = (call BLOL_fnc_players_all) call BIS_fnc_selectRandom;

	if (!(isNil "_player")) then {
		if (alive _player) then {
			private ["_position"];
			_position = position _player;

			if (!(isNil "_position")) then {
				private ["_distanceToSpawn", "_nearbyHelipads"];

				_distanceFromSpawn = _position distance (call BLOL_fnc_players_spawnPosition);
				_nearbyHelipads = count (_position nearObjects ["Land_helipadEmpty_F",
					NEARBY_HELIPADS_RADIUS]);

				if ((_distanceFromSpawn >= MIN_DISTANCE_FROM_SPAWN) && (_nearbyHelipads < MAX_NEARBY_HELIPADS)) then {
					private ["_minDistance", "_maxDistance", "_minDistanceFromObjects",
						"_terrainType", "_maxGradient", "_mustBeShore", "_blacklist",
						"_defaultPositions", "_target"];

					_minDistance = 50;
					_maxDistance = 200;
					_minDistanceFromObjects = 1;
					_terrainType = 0; // Cannot be in water
					_maxGradient = 0; // Maximum terrain gradient in meters
					_mustBeShore = 0; // Does not need to be along the shore
					_blacklist = [];
					_defaultPositions = [_position];

					_target = [_position, _minDistance, _maxDistance, _minDistanceFromObjects,
						_terrainType, _maxGradient, _mustBeShore, _blacklist, _defaultPositions]
						call BIS_fnc_findSafePos;

					[_target] call BLOL_fnc_ambiance_paradrop;
				} else {
					["Skipping paradrop because it is too close to the spawn point or there are " +
						"already %1 helipads near %2", _nearbyHelipads, _player] call _debug;
				};
			} else {
				"Skipping paradrop because the chosen player's location could not be fetched" call _debug;
			};
		} else {
			"Skipping paradrop because the chosen player is dead" call _debug;
		};
	} else {
		"Skipping paradrop attempt because the chosen player is nil" call _debug;
	};
};
