/**
 * Main client entry point.
**/

// Initialize SHK_taskmaster
 private ["_notes"];

_notes = [
	[
		"Overview",
		"You and your team have landed on Altis under cover of the morning fog. You are " +
			"equipped with explosives. Your mission is to knock out the enemy's military " +
			"communications ahead of BLUFOR's main assault.<br /><br />OPFOR's key military " +
			"radio towers are marked on your map. Find transportation and complete your objectives.",
		WEST
	]
];

[[], _notes] call SHK_Taskmaster_initClient;

// Initialize loadout persistence
[] spawn BLOL_fnc_loadout_init;
