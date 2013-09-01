/**
 * Marks a target as destroyed.
**/

private ["_destroyedTarget", "_destroyedTargetId", "_objectives"];
_destroyedTarget = _this;
_destroyedTargetId = _destroyedTarget call BLOL_fnc_targets_hash;
_objectives = missionNamespace getVariable "BLOL_objectives";

{
	private ["_objective", "_objectiveTargets"];
	_objective = _x;
	_objectiveTargets = _objective select 1;

	{
		private ["_objectiveTarget", "_objectiveTargetId"];
		_objectiveTarget = _x;
		_objectiveTargetId = _objectiveTarget select 0;

		if (_objectiveTargetId == _destroyedTargetId) then {
			_objectiveTarget set [1, true];
		};
	} forEach _objectiveTargets;
} forEach _objectives;

missionNamespace setVariable ["BLOL_objectives", _objectives];
