/**
 * Garbage collects objects far away from players.
**/

private ["_debug", "_garbageCollectionDistance", "_playableUnits", "_distantObjects",
	"_eligibleObjects"];

_debug = { ["BLOL_fnc_gc_sweep", _this] call BLOL_fnc_debug };
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
		if (!(_unit getVariable ["BLOL_gc_whitelist", false])) then {
			[_distantObjects, _unit] call BIS_fnc_arrayPush;

			["%1 is %2 meters from the closest player and will be garbage collected", _unit,
				_distanceToClosestPlayer] call _debug;
		} else {
			["%1 is whitelisted and will not be garbage collected", _unit] call _debug;
		};
	} else {
		["%1 is %2 meters from the closest player and will not be garbage collected", _unit,
			_distanceToClosestPlayer] call _debug;
	};
} forEach _eligibleObjects;

_distantObjects call BLOL_fnc_gc_mark;

// Clean up empty groups
{
	if ((count (units _x)) == 0) then {
		deleteGroup _x;
	};
} forEach allGroups;
