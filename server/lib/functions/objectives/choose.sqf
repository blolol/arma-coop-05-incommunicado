/**
 * Returns a selection of random mission objectives.
**/

private ["_availableObjectives", "_objectiveCount"];

_availableObjectives = call (compile (preprocessFileLineNumbers "resources\objectives.sqf"));
_availableObjectives = _availableObjectives call BIS_fnc_arrayShuffle;

_objectiveCount = if (BLOL_debug) then {
	1;
} else {
	[3, 4] call BIS_fnc_randomInt;
};

[_availableObjectives, 0, (_objectiveCount - 1)] call BIS_fnc_subSelect;
