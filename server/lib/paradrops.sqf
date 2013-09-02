/**
 * Periodically spawns enemy chopper that paradrops near players.
**/

private ["_paradrops"];
_paradrops = _this;

sleep ([180, 480] call BIS_fnc_randomInt);

[
	nil, // Target location
	false, // Try to find suitable landing location
	2, // OPFOR
	([1, 2, 3, 4] call BIS_fnc_selectRandom), // Chopper type
	false, // Captive
	true, // Patrol
	bluforFireTeam, // Patrol target
	"random", // Direction from which chopper approaches
	1500, // Approach distance
	true, // Will land even if being fired upon
	false, // Cycle target markers
	([3, 8] call BIS_fnc_randomInt), // Number of infantry
	"default", // AI skill
	[false, true, false, false], // LZ smoke, cover smoke, flares, chemlights
	nil, // Group
	nil, // Unit init
	nil, // ID
	true // Automatically target live players
] execVM "vendor\lv\reinforcementChopper.sqf";

_paradrops spawn _paradrops;
