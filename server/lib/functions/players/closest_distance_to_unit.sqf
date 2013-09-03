/**
 * Returns the distance between the unit and the closest live, non-captive player.
**/

private ["_unit", "_players", "_distances"];
_unit = _this;
_players = call BLOL_fnc_players_all;

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceToUnit] Unit: %1 %2", (typename _unit), _unit]);
	diag_log (format ["[BLOL_fnc_closestDistanceToUnit] Players: %1", _players]);
};

_distances = [];

{
	private ["_player", "_distance"];
	_player = _x;
	_distance = _unit distance _player;
	[_distances, _distance] call BIS_fnc_arrayPush;
} forEach _players;

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceToUnit] Distances: %1", _distances]);
};

_minDistance = [_distances, 0] call BIS_fnc_findExtreme;

(if BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceToUnit] Closest distance: %1 meters", _minDistance]);
};

_minDistance;
