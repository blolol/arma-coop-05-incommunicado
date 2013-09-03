/**
 * Main server entry point.
**/

// Initialize mission objectives
call BLOL_fnc_objectives_init;

// Initialize ambient combat
execVM "server\lib\init_ambient_combat.sqf";

// Initialize enemy paradrops
private ["_paradrops"];
_paradrops = compile (preprocessFileLineNumbers "server\lib\paradrops.sqf");
_paradrops spawn _paradrops;

// Initialize garbage collection
[30, 2500] spawn BLOL_fnc_gc_init;
