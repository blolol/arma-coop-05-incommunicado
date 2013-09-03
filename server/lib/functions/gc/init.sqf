/**
 * Initializes periodic garbage collection of objects distant from players.
**/

private ["_garbageCollectionPeriod", "_garbageCollectionDistance"];
_garbageCollectionPeriod = [_this, 0, 10, [0]] call BIS_fnc_param;
_garbageCollectionDistance = [_this, 1, 1500, [0]] call BIS_fnc_param;

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_gc_init] Initializing garbage collection every %1 seconds of " +
		"units more than %2 meters from players", _garbageCollectionPeriod, _garbageCollectionDistance]);
};

while { true } do {
	sleep _garbageCollectionPeriod;

	if (BLOL_debug) then {
		diag_log "[BLOL_fnc_gc_init] Beginning garbage collection sweep...";
	};

	[_garbageCollectionDistance] call BLOL_fnc_gc_sweep;
};
