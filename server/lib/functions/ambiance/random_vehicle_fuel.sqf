/**
 * Returns a pseudorandom vehicle fuel value based on weights.
**/

private ["_fuelValues", "_fuelWeights", "_fuel"];
_fuelValues =  [0.00, 0.25, 0.30, 0.50, 0.75, 1.00];
_fuelWeights = [0.25, 0.40, 1.00, 0.85, 0.10, 0.05];

_fuel = [_fuelValues, _fuelWeights] call BIS_fnc_selectRandomWeighted;
_fuel = (_fuel * (random 1.15)) + 0.15;
_fuel = (_fuel min 1) max 0;

_fuel;
