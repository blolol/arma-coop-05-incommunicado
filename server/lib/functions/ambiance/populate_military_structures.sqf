/**
 * Populates military structures within the given radius with OPFOR units.
**/

#define SIDE east
#define UNIT_TYPES ["O_Soldier_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_soldier_M_F", \
	"O_Soldier_AT_F", "O_Soldier_LAT_F", "O_Soldier_lite_F"]

private ["_groups", "_debug"];
_groups = _this;
_debug = { ["BLOL_fnc_ambiance_populateMilitaryStructures", _this] call BLOL_fnc_debug };

for "_i" from 0 to ((count _groups) - 1) do {
	private ["_config", "_name", "_positions", "_fillPercentage", "_group"];
	_config = _groups select _i;
	_name = configName _config;
	_positions = getArray (_config >> "positions");
	_fillPercentage = (getArray (_config >> "minMaxFill")) call BIS_fnc_randomNum;
	_group = createGroup SIDE;

	["Spawning %1...", _name] call _debug;

	{
		if ((random 1) <= _fillPercentage) then {
			private ["_position", "_dir", "_type", "_skill"];
			_position = [_x, 0, 2] call BIS_fnc_subSelect;
			_dir = (_x select 3) + ([-30, 30] call BIS_fnc_randomNum);
			_type = UNIT_TYPES call BIS_fnc_selectRandom;
			_skill = [0.85, 1.0] call BIS_fnc_randomNum;

			_unit = _group createUnit [_type, _position, [], 0, "NONE"];
			_unit call BLOL_fnc_gc_whitelist;
			_unit disableAI "MOVE";
			_unit setPosATL _position;
			_unit setDir _dir;
			_unit setUnitPos "UP";
			_unit setUnitAbility _skill;

			["Spawned a %1 at %2", _type, _name] call _debug;
		};
	} forEach _positions;
};
