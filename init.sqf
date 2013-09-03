/**
 * Main mission entry point.
**/

#define DEBUG false
BLOL_debug = DEBUG || ((paramsArray select 0) > 0);

/**
 * Set up SHK_Taskmaster.
**/

call (compile (preprocessFileLineNumbers "vendor\shk_taskmaster.sqf"));

/**
 * Kick off client- and server-specific initialization.
**/

if (hasInterface) then {
	execVM "client\init.sqf";
};

if (isServer) then {
	execVM "server\init.sqf";
};

/**
 * Set up Farooq's Revive.
**/

call (compile (preprocessFileLineNumbers "vendor\FAR_revive\FAR_revive_init.sqf"));

/**
 * Choose spawn point and move players to it.
**/

private ["_spawnPointCount", "_spawnInclusionRadius", "_spawnMarkerOptions"];
_spawnPointCount = 4;
_spawnInclusionRadius = 3;
_spawnMarkerOptions = [];

[["west", _spawnPointCount, _spawnInclusionRadius, _spawnMarkerOptions]]
	call (compile (preprocessFileLineNumbers "vendor\shk_startingPositionRandomizer.sqf"));
