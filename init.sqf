/**
 * Main mission entry point.
**/

if (isServer) then {
	execVM "server\init.sqf";
};

if (hasInterface) then {
	execVM "client\init.sqf";
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
