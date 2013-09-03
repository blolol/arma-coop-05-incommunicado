/**
 * Initializes mission objectives.
**/

BLOL_objectives = [];

private ["_notes", "_objectives", "_tasks"];
_notes = []; // Notes to distribute to clients
_objectives = call BLOL_fnc_objectives_choose;
_tasks = []; // Tasks to distribute to clients

{
	private ["_targetGroup", "_targetGroupTitle", "_targetGroupDesc", "_targetGroupLoc",
		"_targetGroupSites", "_taskName", "_taskTitle", "_taskDesc", "_taskDestMarkerName",
		"_taskDest", "_task", "_objectiveTargets", "_objective"];

	_targetGroup = _x;
	_targetGroupTitle = _targetGroup select 0;
	_targetGroupDesc = _targetGroup select 1;
	_targetGroupLoc = getMarkerPos (_targetGroup select 2);
	_targetGroupSites = _targetGroup select 3;

	// Set up task details
	_taskName = format ["task_%1", _forEachIndex];
	_taskTitle = format ["Destroy %1", _targetGroupTitle];
	_taskDest = _targetGroupLoc;

	// Create an invisible marker at the task destination to use in task description links
	_taskDestMarkerName = format ["task_%1_marker", _forEachIndex];
	createMarker [_taskDestMarkerName, _targetGroupLoc];
	_taskDestMarkerName setMarkerType "Empty";

	// Assemble task description
	_taskDesc = "Destroy " + (format [_targetGroupDesc, _taskDestMarkerName]);
	_taskDesc = _taskDesc + (format [" at grid <marker name='%1'>%2</marker>.", _taskDestMarkerName,
		(mapGridPosition _targetGroupLoc)]);

	// Create task
	_task = [_taskName, _taskTitle, _taskDesc, WEST, [], "created", _taskDest];
	[_tasks, _task] call BIS_fnc_arrayPush;

	// Track individual targets for the server-side objective
	_objectiveTargets = [];

	{
		private ["_targetSite"];
		_targetSite = _x;
		_targetSiteType = _targetSite select 0;

		if (_targetSiteType == "static") then {
			// Attempt to find the physical target object
			private ["_targetSiteMarker", "_targetSiteLoc", "_targetSiteClass", "_target"];
			_targetSiteMarker = _targetSite select 1;
			_targetSiteLoc = getMarkerPos _targetSiteMarker;
			_targetSiteClass = _targetSite select 2;
			_target = nearestObject [_targetSiteLoc, _targetSiteClass];

			if (!(isNull _target)) then {
				_target addEventHandler ["killed", {
					(_this select 0) call BLOL_fnc_targets_markDestroyed;
					call BLOL_fnc_objectives_checkForCompletion;
				}];

				// Track the state of the target in the server-side objectives
				private ["_id"];
				_id = _target call BLOL_fnc_targets_hash;
				[_objectiveTargets, [_id, false]] call BIS_fnc_arrayPush;
			} else {
				format ["Could not find %1 near %2", _targetSiteClass, _targetSiteMarker]
					call BIS_fnc_error;
			};
		};
	} forEach _targetGroupSites;

	// Track this group's objectives
	_objective = [_taskName, _objectiveTargets];
	[BLOL_objectives, _objective] call BIS_fnc_arrayPush;
} forEach _objectives;

// Distribute tasks and notes to clients
[_tasks, _notes] call SHK_Taskmaster_initServer;
