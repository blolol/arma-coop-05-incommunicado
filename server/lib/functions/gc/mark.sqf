/**
 * Marks one or more objects for garbage collection.
**/

private ["_objects"];
_objects = _this;

if ((typename _objects) != (typename [])) then {
	_objects = [_objects];
};

_objects spawn BIS_fnc_GC;

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_gc_mark] Marked objects for garbage collection: %1", _objects]);
};
