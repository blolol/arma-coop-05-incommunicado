/**
 * Main client entry point.
**/

// Initialize SHK_Taskmaster
call SHK_Taskmaster_initClient;

// Initialize mission briefing
execVM "client\lib\init_briefing.sqf";

// Initialize loadout persistence
[] spawn BLOL_fnc_loadout_init;

// Set player as neutral for debugging
if (BLOL_debug) then {
	player setCaptive true;
};
