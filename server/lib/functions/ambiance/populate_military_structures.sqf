/**
 * Populates military structures within the given radius with OPFOR units.
**/

#define BUILDING_TYPES ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F", \
 	"Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V3_F", \
 	"Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", \
 	"Land_Medevac_HQ_V1_F", "Land_MilOffices_V1_F", "Land_Radar_F", "Land_Research_HQ_F", \
 	"Land_TTowerBig_1_F", "Land_TTowerBig_2_F"]
#define SIDE east
#define UNIT_TYPES ["O_Soldier_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_soldier_M_F", \
	"O_Soldier_AT_F", "O_Soldier_LAT_F", "O_Soldier_lite_F"]

private ["_center", "_radius", "_buildings", "_debug"];
_center = _this select 0;
_radius = _this select 1;
_buildings = nearestObjects [_center, BUILDING_TYPES, _radius];
_debug = { ["BLOL_fnc_ambiance_populateMilitaryStructures", _this] call BLOL_fnc_debug };

{
	private ["_building", "_positions", "_i", "_position"];
	_building = _x;
	_positions = [];
	_i = 0;
	_position = _building buildingPos _i;

	// Check whether this building has placeable unit positions
	if ((str _position) != "[0,0,0]") then {
		private ["_count", "_percentage", "_group"];

		// Collect all of the building's unit positions
		while { (_position select 0) != 0 } do {
			[_positions, _position] call BIS_fnc_arrayPush;
			_i = _i + 1;
			_position = _building buildingPos _i;
		};

		// Figure out what percentage of the building's positions should be filled
		_count = count _positions;
		_percentage = 0.5;

		if (_count < 5) then { _percentage = [0.5, 1.0] call BIS_fnc_randomNum };
		if (_count > 5) then { _percentage = [0.3, 0.5] call BIS_fnc_randomNum };

		// Spawn units
		_group = createGroup SIDE;

		{
			if ((random 1) <= _percentage) then {
				private ["_position", "_dir", "_type", "_skill"];
				_position = _x;
				_dir = ([_center, _position] call BIS_fnc_dirTo) + ([-45, 45] call BIS_fnc_randomNum);
				_type = UNIT_TYPES call BIS_fnc_selectRandom;
				_skill = [0.85, 1.0] call BIS_fnc_randomNum;

				_unit = _group createUnit [_type, _position, [], 0, "NONE"];
				_unit disableAI "MOVE";
				_unit setPosATL _position;
				_unit setDir _dir;
				_unit setUnitPos "UP";
				_unit setUnitAbility _skill;

				["Spawned a %1 at %2", _type, _position] call _debug;
			};
		} forEach _positions;
	};
} forEach _buildings;
