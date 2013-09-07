/**
 * Initializes ambient combat.
**/

#define MIN_DISTANCE_FROM_SPAWN 1000

// Wait until players move away from the spawn point
if (!BLOL_debug) then {
	waitUntil {
		private ["_distance"];
		sleep 10;
		_distance = [(call BLOL_fnc_players_spawnPosition)] call BLOL_fnc_players_closestDistanceTo;
		_distance >= MIN_DISTANCE_FROM_SPAWN;
	};
};

private ["_minRange", "_maxRange", "_minDelay", "_maxDelay", "_maxGroups", "_sideRatios",
	"_targetUnits", "_aiSkill", "_aiCommunicates", "_despawnRange", "_unitInit", "_patrolType",
	"_multiplayer", "_options"];

_minRange = 550;
_maxRange = 1250;

_minDelay = if (BLOL_debug) then { 10 } else { 120 };
_maxDelay = if (BLOL_debug) then { 30 } else { 300 };

_maxGroups = 3;
_sideRatios = [
	0.0, // West
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

_options = [_minRange, _maxRange, _minDelay, _maxDelay, _maxGroups, _sideRatios, _targetUnits,
	_aiSkill, _aiCommunicates, _despawnRange, _unitInit, _patrolType, _multiplayer];
_options execVM "vendor\lv\ambientCombat.sqf";
