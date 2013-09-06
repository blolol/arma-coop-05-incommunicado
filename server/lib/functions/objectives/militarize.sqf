/**
 * Spawns military units on a marker within a given radius.
**/

if (isNil "LV_fnc_militarize") then {
	LV_fnc_militarize = compile (preprocessFileLineNumbers "vendor\lv\militarize.sqf");
};

private ["_marker", "_radius", "_debug"];
_marker = _this select 0;
_radius = _this select 1;
_debug = { ["BLOL_fnc_objectives_militarize", _this] call BLOL_fnc_debug };

["Militarizing %1 meters around %2", _radius, _marker] call _debug;

_side = 2; // OPFOR
_spawnMen = [true, false]; // [Land units, water units]
_spawnVehicles = [true, false, false]; // [Land units, water units, air units]
_stayStill = false; // If false, units patrol around radius and inside buildings
_menRatio = 0.25; // Units spawned = radius * ratio (e.g. 250 m * 0.2 = 50 men)
_vehicleRatio = 0.1; // Units spawned = radius * ratio (e.g. 250 m * 0.1 = 25 vehicles)
_skills = "default";
_init = if (BLOL_debug) then {
	"diag_log (format ['[BLOL_fnc_objectives_militarize] Spawned unit: %1', this]);";
} else {
	"";
};

[_marker, _side, _radius, _spawnMen, _spawnVehicles, _stayStill, _menRatio, _vehicleRatio,
	_skills, nil, _init, nil] spawn LV_fnc_militarize;
