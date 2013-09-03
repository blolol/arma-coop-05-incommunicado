/**
 * Main server entry point.
**/

// Initialize mission objectives
call BLOL_fnc_objectives_init;

/**
 * Set up ambient combat.
**/

[
	450, // Min range
	900, // Max range
	(if (BLOL_debug) then { 10 } else { 120 }), // Min spawn delay
	(if (BLOL_debug) then { 10 } else { 300 }), // Max spawn delay
	6, // Max AI groups alive at once
	[0.5, 1, 0], // West, east, independent spawn ratios
	[], // Center units
	"default", // AI skill
	1, // AI communication
	1500, // Despawn distance
	(if (BLOL_debug) then { "diag_log (format ['Spawned ambient combat unit: %1', this]);" } else { nil }), // Unit init
	1, // Patrol type
	true // Multiplayer sync
] execVM "vendor\lv\ambientCombat.sqf";

/**
 * Set up periodic enemy paradrops.
**/

private ["_paradrops"];
_paradrops = compile (preprocessFileLineNumbers "server\lib\paradrops.sqf");
_paradrops spawn _paradrops;

/**
 * Initialize garbage collection of objects distant from players.
**/

[10, 1500] spawn BLOL_fnc_gc_init;
