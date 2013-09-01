/**
 * Checks to see if any objectives have been completed, and completes their associated tasks.
**/

private ["_objectives"];
_objectives = missionNamespace getVariable "BLOL_objectives";

{
	private ["_objective", "_objectiveTaskName", "_objectiveTargets", "_objectiveComplete"];
	_objective = _x;
	_objectiveTaskName = _objective select 0;
	_objectiveTargets = _objective select 1;
	_objectiveComplete = true;

	{
		private ["_objectiveTarget", "_objectiveTargetDestroyed"];
		_objectiveTarget = _x;
		_objectiveTargetDestroyed = _objectiveTarget select 1;
		_objectiveComplete = _objectiveComplete && _objectiveTargetDestroyed;
	} forEach _objectiveTargets;

	if (_objectiveComplete) then {
		[_objectiveTaskName, "succeeded"] call SHK_Taskmaster_upd;
	};
} forEach _objectives;
