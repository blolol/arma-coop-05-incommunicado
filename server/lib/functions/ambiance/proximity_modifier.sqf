/**
 * Returns a value between 0 and 1 based on how close the position is to a settlement. Large cities
 * and especially military installations enjoy increased scores.
**/

#define LOCATION_TYPES ["NameLocal", "NameVillage", "NameCity", "NameCityCapital"]
#define RANGE 1500

private ["_position", "_locations"];

_position = _this select 0;
_locations = if ((count _this) > 1) then {
	_this select 1;
} else {
	nearestLocations [_position, LOCATION_TYPES, RANGE];
};

if ((count _locations) > 0) then {
	private ["_location", "_name", "_type", "_distance", "_score", "_modifier"];

	_location = _locations select 0;
	_name = text _location;
	_type = type _location;
	_distance = _position distance _location;

	_score = [[0, RANGE], _distance, [1, 0]] call BIS_fnc_linearConversion;
	_modifier = 1;

	if (_type == "NameLocal") then {
		if ((toLower _name) == "military") then {
			_modifier = 1.75;
		} else {
			if ((count _locations) > 1) then {
				_locations = [_locations, 1] call BIS_fnc_subSelect;
				[_position, _locations] call BLOL_fnc_ambiance_proximityModifier;
			} else {
				_score = 0;
			};
		};
	};

	if (_type in ["NameCity", "NameCityCapital"]) then {
		_modifier = 1.2;
	};

	((_score * _modifier) max 0) min 1;
} else {
	0;
};
