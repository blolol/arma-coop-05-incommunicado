/**
 * Returns a pseudorandom vehicle damage value based on weights.
**/

private ["_damageValues", "_damageWeights", "_damage"];
_damageValues =  [0.00, 0.25, 0.33, 0.50, 0.75];
_damageWeights = [0.10, 0.20, 0.75, 1.00, 0.65];

_damage = [_damageValues, _damageWeights] call BIS_fnc_selectRandomWeighted;
_damage = (_damage * (random 1.15)) + 0.15;
_damage = (_damage min 0.9) max 0;

_damage;
