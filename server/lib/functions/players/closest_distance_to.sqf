/**
 * Returns the distance between the object and the closest live, non-captive player.
**/

private ["_object", "_players", "_distances"];
_object = _this select 0;

_players = if ((count _this) > 1) then {
	_this select 1;
} else {
	call BLOL_fnc_players_all;
};

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceTo] Object: %1 %2", (typename _object), _object]);
	diag_log (format ["[BLOL_fnc_closestDistanceTo] Players: %1", _players]);
};

_distances = [];

{
	private ["_player", "_distance"];
	_player = _x;
	_distance = _object distance _player;
	[_distances, _distance] call BIS_fnc_arrayPush;
} forEach _players;

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceTo] Distances: %1", _distances]);
};

_minDistance = [_distances, 0] call BIS_fnc_findExtreme;

(if BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_closestDistanceTo] Closest distance: %1 meters", _minDistance]);
};

_minDistance;
