/**
 * Marks an objective as "inactive" (there are nearby players).
**/

BLOL_activeObjectives = BLOL_activeObjectives - [_this];

if (BLOL_debug) then {
	diag_log (format ["[BLOL_fnc_objectives_markInactive] Marked %1 as inactive. " +
		"Active objectives: %2", _this, BLOL_activeObjectives]);
};
