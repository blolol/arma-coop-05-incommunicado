/**
 * Returns locations near all live players.
**/

#define LOCATION_TYPES ["NameLocal", "NameVillage", "NameCity", "NameCityCapital"]

private ["_radius", "_locations", "_debug"];
_radius = _this select 0;
_locations = [];
_debug = { ["BLOL_fnc_players_nearbyLocations", _this] call BLOL_fnc_debug };

{
	private ["_player", "_locationsNearPlayer"];
	_player = _x;
	_locationsNearPlayer = nearestLocations [(position _player), LOCATION_TYPES, _radius];

	["Found %1 locations near %2", (count _locationsNearPlayer), _player] call _debug;

	{
		private ["_location", "_name"];
		_location = _x;
		_name = text _location;

		if (({ _name == (text _x) } count _locations) == 0) then {
			[_locations, _location] call BIS_fnc_arrayPush;
		};
	} forEach _locationsNearPlayer;
} forEach (call BLOL_fnc_players_all);

if (BLOL_debug) then {
	private ["_locationNames"];
	_locationNames = [];
	{ [_locationNames, (text _x)] call BIS_fnc_arrayPush } forEach _locations;
	["Found %1 locations within %2 meters of players: %3",
		(count _locations), _radius, _locationNames] call _debug;
};

_locations;
