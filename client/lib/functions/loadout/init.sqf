/**
 * Initializes loadout persistence.
**/

waitUntil { !(isNull player) };

BLOL_loadout = [player] call BLOL_fnc_loadout_get;

player addEventHandler ["Respawn", {
	[player, BLOL_loadout] spawn BLOL_fnc_loadout_set;
}];
