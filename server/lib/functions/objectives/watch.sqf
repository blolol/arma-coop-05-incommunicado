/**
 * Performs objective actions when players are nearby.
**/

#define THRESHOLD_DISTANCE 1500

if (isNil "BLOL_activeObjectives") then {
	BLOL_activeObjectives = [];
};

while { true } do {
	sleep 10;

	if (BLOL_debug) then {
		diag_log "Beginning objective watch loop...";
	};

	private ["_players"];
	_players = call BLOL_fnc_players_all;

	{
		private ["_objective", "_name", "_location", "_actions", "_distance"];
		_objective = _x;
		_name = _objective select 0;
		_location = _objective select 2;
		_actions = _objective select 3;
		_distance = [_location, _players] call BLOL_fnc_players_closestDistanceTo;

		if (_distance <= THRESHOLD_DISTANCE) then {
			if (!(_name call BLOL_fnc_objectives_isActive)) then {
				_name call BLOL_fnc_objectives_markActive;
			};
		} else {
			if (_name call BLOL_fnc_objectives_isActive) then {
				_name call BLOL_fnc_objectives_markInactive;
			};
		};
	} forEach BLOL_objectives;
};
