/**
 * Eventually despawns a unit when all players are far enough away from it.
**/

private ["_unit", "_despawnDistance"];
_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_despawnDistance = [_this, 1, 1500, [0]] call BIS_fnc_param;

[_unit, _despawnDistance] spawn {
	private ["_unit", "_despawnDistance"];
	_unit = _this select 0;
	_despawnDistance = _this select 1;

	waitUntil {
		sleep 10; // Check distances every ten seconds

		private ["_closestDistance"];
		_closestDistance = _unit call BLOL_fnc_players_closestDistanceToUnit;

		if (BLOL_debug) then {
			diag_log (format ["[BLOL_fnc_despawnEventually] %1 %2 is %3 meters from the closest player",
				(typename _unit), _unit, _closestDistance]);
		};

		_closestDistance >= _despawnDistance;
	};

	[_unit] spawn BIS_fnc_GC;

	if (BLOL_debug) then {
		diag_log (format ["[BLOL_fnc_despawnEventually] %1 %2 has been queued for garbage collection",
			(typename _unit), _unit]);
	};
};

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_despawnEventually] %1 %2 will be despawned when players are at least %3 meters away",
		(typename _unit), _unit, _despawnDistance]);
};
