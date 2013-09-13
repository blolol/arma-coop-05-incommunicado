/**
 * Spawns military units at military installations.
**/

// TODO Rework military sites so they're a small number of deadly units protecting a high-value
// target, like some NATO vehicle. The server spawns them lazily, and then they get whitelisted so
// they're never GCed. There aren't too many military sites on Altis, so keeping the units around
// shouldn't be too much of a problem? If it's feasible, it would be cool to track which military
// sites have been "cleared" and shouldn't be respawned, so then the units *can* be GCed.

#define PERIOD 15
#define RANGE 1500
#define LOCATION_TYPES ["NameLocal"]

if (isNil "BLOL_militarySiteUnits") then {
	BLOL_militarySiteUnits = [];
};

if (isNil "BLOL_clearedMilitarySites") then {
	BLOL_clearedMilitarySites = [];
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
	sleep PERIOD;

	private ["_locations"];
	_locations = [RANGE, LOCATION_TYPES] call BLOL_fnc_players_nearbyLocations;
	_locations = [_locations, { (toLower (text _x)) == "military" }] call BIS_fnc_conditionalSelect;

	{
		private ["_location", "_hash"];

		_location = _x;
		_hash = _location call BLOL_fnc_targets_hash;

		if (!([BLOL_militarySiteUnits, _hash] call BLOL_fnc_hash_hasKey)) then {
			// TODO Keep track of the military site units
		};

		if (!(_hash in BLOL_clearedMilitarySites)) then {
			private ["_target", "_side", "_radius", "_skills", "_init"];

			["Spawning military site %1...", _hash] call _debug;

			_target = position _location;
			_side = 2;
			_radius = (size _location) call BIS_fnc_arithmeticMean;
			_skills = "default";
			_init = format ["['%1', this] spawn BLOL_fnc_ambiance_trackMilitarySiteUnit", _hash];

			// Larger zone for air patrols
			[_target, _side, (_radius * 0.55), [false, false], [false, false, true], false, 0, [0, 2],
				_skills, nil, _init, nil] spawn LV_fnc_militarize;

			// Smaller zone for ground patrols
			[_target, _side, (_radius * 0.3), [true, false], [true, false, false], false, [6, 4], 0,
				_skills, nil, _init, nil] spawn LV_fnc_militarize;

			// Smallest zone for stationary soldiers
			[_target, _side, (_radius * 0.15), [true, false], [true, false, false], true, [4, 3], 0,
				_skills, nil, _init, nil] spawn LV_fnc_militarize;

			// Fill buildings with soldiers
			[_target, _side, true, 1, 75, _radius, _skills, nil, _init, nil] spawn LV_fnc_fillHouse;

			[BLOL_clearedMilitarySites, _hash] call BIS_fnc_arrayPush;
		};
	} forEach _locations;
};
