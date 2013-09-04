/**
 * Initializes player spawn points on clients and server.
**/

private ["_spawnPointCount", "_spawnInclusionRadius", "_spawnMarkerOptions"];
_spawnPointCount = 4;
_spawnInclusionRadius = 3;
_spawnMarkerOptions = [];

[["west", _spawnPointCount, _spawnInclusionRadius, _spawnMarkerOptions]]
	call (compile (preprocessFileLineNumbers "vendor\shk_startingPositionRandomizer.sqf"));
