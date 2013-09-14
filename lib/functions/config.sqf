/**
 * Returns a CfgBlolol configuration value.
 *
 * ["number", "AmbientCivilianVehicles", "LocationTypes", "NameVillage", "maxVehicles"] call BLOL_fnc_config;
**/

private ["_type", "_path", "_config"];

_type = _this select 0;
_path = [_this, 1] call BIS_fnc_subSelect;

_config = (missionConfigFile >> "CfgBlolol");
{ _config = (_config >> _x) } forEach _path;

switch (_type) do {
	case "array": { getArray _config };
	case "number": { getNumber _config };
	case "string": { getText _config };
	default { _config };
};
