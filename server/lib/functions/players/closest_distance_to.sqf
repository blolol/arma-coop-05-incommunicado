/**
 * Returns the distance between the object and the closest live, non-captive player.
**/

private ["_object", "_valid", "_players", "_distances", "_debug", "_minDistance"];
_object = _this select 0;
_valid = true;
_debug = { ["BLOL_fnc_closestDistanceTo", _this] call BLOL_fnc_debug };

["Object: %1 %2", (typename _object), _object] call _debug;

// If _object is an array, then make sure it's a Position2D or Position3D
if ((typename _object) == (typename [])) then {
	private ["_count", "_numbers"];

	// Is the array two or three elements in length?
	_count = count _object;

	if (_count < 2 || _count > 3) then {
		["Error: tried to get distance from an array with %1 elements", _count] call _debug;
		_valid = false;
	};

	if (_valid) then {
		// Is the array composed entirely of numbers?
		_numbers = true;
		{ _numbers = _numbers && ((typename _x) == (typename 0.0)) } forEach _object;

		if (!_numbers) then {
			"Error: tried to get distance from an array not composed of numbers" call _debug;
			_valid = false;
		};
	};
};

_players = if ((count _this) > 1) then {
	_this select 1;
} else {
	call BLOL_fnc_players_all;
};

if ((count _players) > 0) then {
	["Players: %1", _players] call _debug;
} else {
	"Error: there are no live players" call _debug;
	_valid = false;
};

if (_valid) then {
	_distances = [];

	{
		private ["_player", "_distance"];
		_player = _x;
		_distance = _object distance _player;
		[_distances, _distance] call BIS_fnc_arrayPush;
	} forEach _players;

	["Distances: %1", _distances] call _debug;

	_minDistance = [_distances, 0] call BIS_fnc_findExtreme;

	["Closest distance: %1 meters", _minDistance] call _debug;
} else {
	_minDistance = -1;
};

_minDistance;
