/**
 * Garbage collects objects far away from players.
**/

private ["_garbageCollectionDistance", "_playableUnits", "_distantObjects", "_eligibleObjects"];
_garbageCollectionDistance = [_this, 0, 1500, [0]] call BIS_fnc_param;
_playableUnits = call BLOL_fnc_players_all;
_distantObjects = [];

_eligibleObjects = allUnits;
_eligibleObjects = [_eligibleObjects, allDead] call BIS_fnc_arrayPushStack;
_eligibleObjects = [_eligibleObjects, vehicles] call BIS_fnc_arrayPushStack;
_eligibleObjects = _eligibleObjects - _playableUnits;

{
	private ["_unit", "_distanceToClosestPlayer"];
	_unit = _x;
	_distanceToClosestPlayer = [_unit, _playableUnits] call BLOL_fnc_players_closestDistanceTo;

	if (_distanceToClosestPlayer >= _garbageCollectionDistance) then {
		[_distantObjects, _unit] call BIS_fnc_arrayPush;

		if (BLOL_debug) then {
			diag_log (format ["[BLOL_fnc_gc_sweep] %1 is %2 meters from the closest player and " +
				"will be garbage collected", _unit, _distanceToClosestPlayer]);
		};
	} else {
		if (BLOL_debug) then {
			diag_log (format ["[BLOL_fnc_gc_sweep] %1 is %2 meters from the closest player and " +
				"will not be garbage collected", _unit, _distanceToClosestPlayer]);
		};
	};
} forEach _eligibleObjects;

_distantObjects call BLOL_fnc_gc_mark;
