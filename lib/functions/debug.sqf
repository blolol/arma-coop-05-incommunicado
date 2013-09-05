/**
 * Logs a debug message if debug mode is enabled.
 *
 * ["BLOL_fnc_objectives_watch", "Debug message"] call BLOL_fnc_debug;
 *   => [BLOL_fnc_objectives_watch] Debug message
 * ["BLOL_fnc_objectives_watch", ["Debug %1", "message"]] call BLOL_fnc_debug;
 *   => [BLOL_fnc_objectives_watch] Debug message
**/

if (BLOL_debug) then {
	private ["_params", "_prefix"];
	_prefix = _this select 0;
	_params = _this select 1;

	if ((typename _params) != (typename [])) then {
		_params = [_params];
	};

	_params set [0, format ["[%1] %2", _prefix, (_params select 0)]];

	diag_log (format _params);
};
