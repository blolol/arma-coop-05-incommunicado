/**
 * Lands enemy troops at a location via helicopter.
**/

if (isNil "BLOL_activeParadrops") then {
	BLOL_activeParadrops = 0;
};

if (isNil "LV_fnc_reinforcementChopper") then {
	LV_fnc_reinforcementChopper = compile (preprocessFileLineNumbers "vendor\lv\reinforcementChopper.sqf");
};

private ["_debug", "_target", "_exactLocation", "_side", "_type", "_captive", "_patrol",
	"_patrolTarget", "_direction", "_approachDistance", "_forceLanding", "_cycleTargetMarkers",
	"_infantryCount", "_skill", "_smoke", "_multiplayer"];

_debug = { ["BLOL_fnc_ambiance_paradrop", _this] call BLOL_fnc_debug };

_target = _this select 0;
_exactLocation = false;
_side = 2; // OPFOR
_type = [1, 4] call BIS_fnc_randomInt; // Type of helicopter
_captive = false;
_patrol = true;
_patrolTarget = bluforFireTeam;
_direction = "random";
_approachDistance = 1500;
_forceLanding = true;
_cycleTargetMarkers = false;
_infantryCount = [3, 8] call BIS_fnc_randomInt;
_skill = "default";
_smoke = [false, false, false, false]; // LZ smoke, cover smoke, flares, chemlights
_multiplayer = true;

[_target, _exactLocation, _side, _type, _captive, _patrol, _patrolTarget, _direction,
	_approachDistance, _forceLanding, _cycleTargetMarkers, _infantryCount, _skill, _smoke,
	nil, nil, nil, _multiplayer] spawn LV_fnc_reinforcementChopper;

BLOL_activeParadrops = BLOL_activeParadrops + 1;

["Paradrop headed to %1. Active paradrops: %2", _target, BLOL_activeParadrops] call _debug;
