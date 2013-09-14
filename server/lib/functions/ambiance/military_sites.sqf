/**
 * Spawns military units at military installations.
**/

#define SEARCH_INTERVAL 15
#define SPAWN_RANGE 1500

if (isNil "BLOL_militarySites") then {
	BLOL_militarySites = [] call CBA_fnc_hashCreate;
};

if (isNil "LV_fnc_militarize") then {
	LV_fnc_militarize = compile (preprocessFileLineNumbers "vendor\lv\militarize.sqf");
};

private ["_debug"];
_debug = { ["BLOL_fnc_ambiance_militarySites", _this] call BLOL_fnc_debug };

// Read military site configuration
_militarySites = ["config", "MilitarySites", "Locations"] call BLOL_fnc_config;
for "_i" from 0 to ((count _militarySites) - 1) do {
	private ["_config", "_key", "_value"];
	_config = _militarySites select _i;
	_key = configName _config;

	// Hide the "center" marker on clients
	(getText (_config >> "center")) setMarkerAlpha 0;

	_value = [[
		["config", _config],
		["spawned", false]
	]] call CBA_fnc_hashCreate;

	[BLOL_militarySites, _key, _value] call CBA_fnc_hashSet;
};

while { true } do {
	sleep SEARCH_INTERVAL;

	[BLOL_militarySites, {
 		private ["_name", "_site", "_config", "_spawned", "_centerMarker", "_center", "_distance"];

 		_name = _key;
 		_site = _value;
 		_config = [_site, "config"] call CBA_fnc_hashGet;
 		_spawned = [_site, "spawned"] call CBA_fnc_hashGet;
 		_centerMarker = getText (_config >> "center");
 		_center = getMarkerPos _centerMarker;
 		_distance = [_center] call BLOL_fnc_players_closestDistanceTo;

 		if ((!_spawned) && (_distance <= SPAWN_RANGE)) then {
 			private ["_radius", "_init", "_prizeType", "_prizePositions", "_prizePos", "_prize"];
 			_radius = (getMarkerSize _centerMarker) call BIS_fnc_arithmeticMean;
 			_init = "this call BLOL_fnc_gc_whitelist";

 			["Spawning %1...", _name] call _debug;

 			// Populate military structures with observers
 			(_config >> "Groups") call BLOL_fnc_ambiance_populateMilitaryStructures;

 			// Spawn "prize" vehicle
 			_prizeType = call BLOL_fnc_ambiance_randomMilitarySitePrizeClass;
 			_prizePos = getMarkerPos ((getArray (_config >> "prizes"))
 				call BIS_fnc_selectRandom);
 			_prize = createVehicle [_prizeType, _prizePos, [], 2, "NONE"];
 			_prize call BLOL_fnc_gc_whitelist;
 			_prize setDir ([0, 360] call BIS_fnc_randomInt);
 			_prize setDamage (call BLOL_fnc_ambiance_randomVehicleDamage);
 			_prize setFuel (call BLOL_fnc_ambiance_randomVehicleFuel);
 			["Spawned a %1 prize vehicle at %2", _prizeType, _name] call _debug;

 			// Spawn guards around the "prize" vehicle
 			[_prize, 2, 5, [true, false], [false, false, false], true, [4, 2], 0, 0.8, nil,
 				_init, nil] spawn LV_fnc_militarize;

 			// Spawn ground vehicle patrols
 			[_center, 2, (_radius * 0.75), [false, false], [true, false, false], false, 0, [1, 2], "default",
 				nil, _init, nil] spawn LV_fnc_militarize;

 			// Spawn an air patrol
 			_minMaxAirPatrols = getArray (_config >> "minMaxAirPatrols");
 			[_center, 2, _radius, [false, false], [false, false, true], false, 0, _minMaxAirPatrols,
 				"default", nil, _init, nil] spawn LV_fnc_militarize;

 			[_site, "spawned", true] call CBA_fnc_hashSet;
 		};
 	}] call CBA_fnc_hashEachPair;
};
