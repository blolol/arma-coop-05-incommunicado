/**
 * Performs objective actions when players are nearby.
**/

#define THRESHOLD_DISTANCE 1500

private ["_debug"];
_debug = { ["BLOL_fnc_objectives_watch", _this] call BLOL_fnc_debug };

if (isNil "BLOL_activeObjectives") then {
	BLOL_activeObjectives = [];
};

while { true } do {
	sleep 10;

	"Beginning objective watch loop..." call _debug;

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

				{
					private ["_action", "_type", "_options"];
					_action = _x;
					_type = _action select 0;
					_options = [_action, 1] call BIS_fnc_subSelect;

					switch (_type) do {
						case "militarize": {
							_options call BLOL_fnc_objectives_militarize;
						};

						default {
							["Error: unrecognized action type: %1", _action] call _debug;
						};
					};
				} forEach _actions;
			};
		} else {
			if (_name call BLOL_fnc_objectives_isActive) then {
				_name call BLOL_fnc_objectives_markInactive;
			};
		};
	} forEach BLOL_objectives;
};
