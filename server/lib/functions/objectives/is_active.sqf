/**
 * Returns true if the given objective is marked as active (there are nearby players).
**/

private ["_isActive"];
_isActive = false;

{
	if (_x == _this) exitWith {
		_isActive = true;
	};
} forEach BLOL_activeObjectives;

_isActive;
