/**
 * Main mission entry point.
**/

#define DEBUG false
BLOL_debug = DEBUG || ((paramsArray select 0) > 0);

// Initialize spawn point
call (compile (preprocessFileLineNumbers "lib\init_player_spawn.sqf"));

// Initialize SHK_Taskmaster
call (compile (preprocessFileLineNumbers "vendor\shk_taskmaster.sqf"));

// Initialize clients
if (hasInterface) then {
	execVM "client\init.sqf";
};

// Initialize server
if (isServer) then {
	execVM "server\init.sqf";
};

// Initialize Farooq's Revive
call (compile (preprocessFileLineNumbers "vendor\FAR_revive\FAR_revive_init.sqf"));
