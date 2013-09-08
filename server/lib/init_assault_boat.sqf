/**
 * Spawns an assault boat with supplies near the spawn point.
**/

private ["_spawn", "_position", "_boat"];

_spawn = call BLOL_fnc_players_spawnPosition;

_position = [_spawn, 1, 5, 0, 0, 1, 1, [], [_spawn, _spawn]] call BIS_fnc_findSafePos;
_boat = "B_Boat_Transport_01_F" createVehicle _position;
_boat setDir (markerDir BLOL_spawnMarkerName);

_position = [_position, 0, 0, 0, 0, 1, 0, [], [_position, _position]] call BIS_fnc_findSafePos;
_supplies = "Box_NATO_AmmoOrd_F" createVehicle _position;
_supplies setDir ([0, 360] call BIS_fnc_randomInt);
_supplies addMagazineCargoGlobal ["DemoCharge_Remote_Mag", ([3, 16] call BIS_fnc_randomInt)];

_supplies = "Box_NATO_Ammo_F" createVehicle _position;
_supplies setDir ([0, 360] call BIS_fnc_randomInt);
