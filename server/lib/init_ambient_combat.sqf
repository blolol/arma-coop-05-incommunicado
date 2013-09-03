/**
 * Initializes ambient combat.
**/

// Wait a few minutes before spawning first ambient combat units
if (!BLOL_debug) then {
	sleep ([300, 600] call BIS_fnc_randomInt);
};

private ["_minRange", "_maxRange", "_minDelay", "_maxDelay", "_maxGroups", "_sideRatios",
	"_targetUnits", "_aiSkill", "_aiCommunicates", "_despawnRange", "_unitInit", "_patrolType",
	"_multiplayer", "_options"];

_minRange = 450;
_maxRange = 900;

_minDelay = if (BLOL_debug) then { 10 } else { 120 };
_maxDelay = if (BLOL_debug) then { 30 } else { 300 };

_maxGroups = 6;
_sideRatios = [
	0.5, // West
	1.0, // East
	0.0  // Independent
];

_targetUnits = []; // Overridden by "_multiplayer"

_aiSkill = "default";
_aiCommunicates = 1;

_despawnRange = 1500;

_unitInit = if (BLOL_debug) then {
	"diag_log (format ['Spawned ambient combat unit: %1', this]);";
} else {
	nil;
};

_patrolType = 1;

_multiplayer = true;

_options = [_minRange, _maxRange, _minDelay, _maxDelay, _maxGroups, _sideRatios, _targetUnits, _aiSkill,
	_aiCommunicates, _despawnRange, _unitInit, _patrolType, _multiplayer];
_options execVM "vendor\lv\ambientCombat.sqf";
