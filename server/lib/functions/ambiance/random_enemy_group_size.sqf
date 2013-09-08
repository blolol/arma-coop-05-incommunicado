/**
 * Returns a reasonable number of enemy infantry to spawn, based on the current number of players.
**/

_players = call BLOL_fnc_players_count;
_modifier = (random 4) + 2;
_min = 2;
_max = (getNumber (missionConfigFile >> "Header" >> "maxPlayers")) * 3;

((round (_players * _modifier)) min _max) max _min;
