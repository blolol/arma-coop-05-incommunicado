/**
 * Periodically spawns enemy chopper that paradrops near players.
**/

private ["_paradrops"];
_paradrops = _this;

sleep ((if (BLOL_debug) then { [10, 15] } else { [180, 480] }) call BIS_fnc_randomInt);

if (isNil "BLOL_paradrops") then {
	BLOL_paradrops = 0;
};

if (BLOL_paradrops < 2) then {
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
		[false, false, false, false], // LZ smoke, cover smoke, flares, chemlights
		nil, // Group
		nil, // Unit init
		nil, // ID
		true // Automatically target live players
	] execVM "vendor\lv\reinforcementChopper.sqf";

	BLOL_paradrops = BLOL_paradrops + 1;

	if (BLOL_debug) then {
		diag_log (format ["Spawned paradrop. Active paradrops: %1", BLOL_paradrops]);
	};
} else {
	if (BLOL_debug) then {
		diag_log (format ["Skipping paradrop spawn because there are already %1 active paradrops", BLOL_paradrops]);
	};
};

_paradrops spawn _paradrops;
