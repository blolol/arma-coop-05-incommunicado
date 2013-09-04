/**
 * Marks an objective as active (there are nearby players).
**/

if (!(_this call BLOL_fnc_objectives_isActive)) then {
	[BLOL_activeObjectives, _this] call BIS_fnc_arrayPush;

	if (BLOL_debug) then {
		diag_log (format ["[BLOL_fnc_objectives_markActive] Marked %1 as active. " +
			"Active objectives: %2", _this, BLOL_activeObjectives]);
	};
};
