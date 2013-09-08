/**
 * Returns the number of live, non-captive human players.
**/

{ isPlayer _x } count (call BLOL_fnc_players_all);
