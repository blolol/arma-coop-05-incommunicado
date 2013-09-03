/**
 * Returns an array of all live, non-captive players.
**/

_allUnits = if (isMultiplayer) then { playableUnits } else { switchableUnits };
_livePlayers = [];

{
	private ["_unit"];
	_unit = _x;

	if ((alive _unit) && !(captive _unit)) then {
		[_livePlayers, _unit] call BIS_fnc_arrayPush;
	};
} forEach _allUnits;

_livePlayers;
