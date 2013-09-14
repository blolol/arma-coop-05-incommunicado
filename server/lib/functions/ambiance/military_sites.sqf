/**
 * Spawns military units at military installations.
**/

// TODO Rework military sites so they're a small number of deadly units protecting a high-value
// target, like some NATO vehicle. The server spawns them lazily, and then they get whitelisted so
// they're never GCed. There aren't too many military sites on Altis, so keeping the units around
// shouldn't be too much of a problem? If it's feasible, it would be cool to track which military
// sites have been "cleared" and shouldn't be respawned, so then the units *can* be GCed.

#define SEARCH_INTERVAL 15
#define SEARCH_RANGE 1500
#define LOCATION_TYPES ["NameLocal"]

if (isNil "BLOL_spawnedMilitarySites") then {
	BLOL_spawnedMilitarySites = [];
};

if (isNil "LV_fnc_fillHouse") then {
	LV_fnc_fillHouse = compile (preprocessFileLineNumbers "vendor\lv\fillHouse.sqf");
};

if (isNil "LV_fnc_militarize") then {
	LV_fnc_militarize = compile (preprocessFileLineNumbers "vendor\lv\militarize.sqf");
};

private ["_debug"];
_debug = { ["BLOL_fnc_ambiance_militarySites", _this] call BLOL_fnc_debug };

while { true } do {
	sleep SEARCH_INTERVAL;

	private ["_locations"];
	_locations = [SEARCH_RANGE, LOCATION_TYPES] call BLOL_fnc_players_nearbyLocations;
	_locations = [_locations, { (toLower (text _x)) == "military" }] call BIS_fnc_conditionalSelect;

	{
		private ["_location", "_hash"];

		_location = _x;
		_hash = _location call BLOL_fnc_targets_hash;

		if (!(_hash in BLOL_spawnedMilitarySites)) then {
			private ["_position", "_radius"];

			["Spawning military site %1...", _hash] call _debug;

			_position = position _location;
			_radius = ((size _location) call BIS_fnc_arithmeticMean) * 1.25;

			[(position _location), _radius] call BLOL_fnc_ambiance_populateMilitaryStructures;

			[BLOL_spawnedMilitarySites, _hash] call BIS_fnc_arrayPush;
		};
	} forEach _locations;
};
