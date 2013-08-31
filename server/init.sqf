/**
 * Main server entry point.
**/

private ["_availableTargets", "_missionTargets"];

// Groups of static and dynamic radio tower sites
_availableTargets = [
	[
		"north of Kavala", [
			["static", "static_tower_0", "Land_TTowerBig_1_F"],
			["static", "static_tower_1", "Land_TTowerBig_2_F"]
		]
	],
	[
		"west of Galati", [
			["static", "static_tower_2", "Land_TTowerBig_2_F"]
		]
	],
	[
		"between Sofia and Molos", [
			["static", "static_tower_3", "Land_TTowerBig_2_F"],
			["static", "static_tower_4", "Land_TTowerBig_2_F"]
		]
	],
	[
		"southeast of Pyrgos", [
			["static", "static_tower_5", "Land_TTowerBig_2_F"]
		]
	],
	[
		"northwest of Panagia", [
			["static", "static_tower_6", "Land_TTowerBig_2_F"],
			["static", "static_tower_7", "Land_TTowerBig_2_F"]
		]
	]
] call BIS_fnc_arrayShuffle;

// Choose mission targets
_missionTargetCount = [2, 4] call BIS_fnc_randomInt;
_missionTargets = [_availableTargets, 0, (_missionTargetCount - 1)] call BIS_fnc_subSelect;

// Choose spawn point
_spawnPoint = getMarkerPos (["spawn_0", "spawn_1"] call BIS_fnc_selectRandom);
{ _x setPos _spawnPoint } forEach (units (group bluforTeamLeader));
