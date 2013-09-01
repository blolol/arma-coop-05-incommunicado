/**
 * Main server entry point.
**/

private ["_availableTargets", "_missionTargets"];

// Groups of static and dynamic radio tower sites
_availableTargets = [
	[
		"Kavala radio towers",
		"the two radio towers <marker name='%1'>north of Kavala<marker>",
		"static_tower_0",
		[
			["static", "static_tower_0", "Land_TTowerBig_1_F"],
			["static", "static_tower_1", "Land_TTowerBig_2_F"]
		]
	],
	[
		"Galati radio tower",
		"the radio tower <marker name='%1'>west of Galati</marker>",
		"static_tower_2",
		[
			["static", "static_tower_2", "Land_TTowerBig_2_F"]
		]
	],
	[
		"Sofia radio towers",
		"the two radio towers <marker name='%1'>between Sofia and Molos</marker>",
		"static_tower_3",
		[
			["static", "static_tower_3", "Land_TTowerBig_2_F"],
			["static", "static_tower_4", "Land_TTowerBig_2_F"]
		]
	],
	[
		"Pyrgos radio tower",
		"the radio tower <marker name='%1'>southeast of Pyrgos</marker>",
		"static_tower_5",
		[
			["static", "static_tower_5", "Land_TTowerBig_2_F"]
		]
	],
	[
		"Panagia radio towers",
		"the two radio towers <marker name='%1'>northwest of Panagia</marker>",
		"static_tower_6",
		[
			["static", "static_tower_6", "Land_TTowerBig_2_F"],
			["static", "static_tower_7", "Land_TTowerBig_2_F"]
		]
	]
] call BIS_fnc_arrayShuffle;

// Choose mission targets
_missionTargetCount = [2, 4] call BIS_fnc_randomInt;
_missionTargets = [_availableTargets, 0, (_missionTargetCount - 1)] call BIS_fnc_subSelect;

// Assign tasks
private ["_tasks", "_notes"];
_tasks = [];
_notes = [];

{
	private ["_targetGroup", "_targetGroupDesc", "_targetGroupSites"];
	_targetGroup = _x;
	_targetGroupTitle = _targetGroup select 0;
	_targetGroupDesc = _targetGroup select 1;
	_targetGroupLoc = getMarkerPos (_targetGroup select 2);
	_targetGroupSites = _targetGroup select 3;

	// Create task
	private ["_taskOwner", "_taskTitle", "_taskMarker", "_taskDestination", "_taskPriority"];
	_taskOwner = true;
	_taskName = format ["task_%1", _forEachIndex];
	_taskTitle = format ["Destroy %1", _targetGroupTitle];
	_taskMarker = _taskTitle;
	_taskDest = _targetGroupLoc;
	_taskState = "Created";
	_taskPriority = 0;

	private ["_taskDestMarkerName"];
	_taskDestMarkerName = format ["task_%1_marker", _forEachIndex];
	createMarker [_taskDestMarkerName, _targetGroupLoc];
	_taskDestMarkerName setMarkerType "Empty";

	private ["_taskDesc"];
	_taskDesc = "Destroy " + (format [_targetGroupDesc, _taskDestMarkerName]);
	_taskDesc = _taskDesc + (format [" at grid <marker name='%1'>%2</marker>.", _taskDestMarkerName, (mapGridPosition _targetGroupLoc)]);

	private ["_task"];
	_task = [_taskName, _taskTitle, _taskDesc, WEST, [], "created", _taskDest];
	[_tasks, _task] call BIS_fnc_arrayPush;

	{
		private ["_targetSite"];
		_targetSite = _x;
		_targetSiteType = _targetSite select 0;

		if (_targetSiteType == "static") then {
			private ["_targetSiteLoc", "_targetSiteClass", "_triggerCondition", "_triggerActivation", "_trigger"];
			_targetSiteLoc = getMarkerPos (_targetSite select 1);
			_targetSiteClass = _targetSite select 2;

			// Create trigger
			_triggerCondition = format ["damage (nearestObject [getPosATL thisTrigger, '%1']) >= 1", _targetSiteClass];
			_triggerActivation = format ["(missionNamespace getVariable '%1') setTaskState 'Succeeded'", _taskName];
			_trigger = createTrigger ["EmptyDetector", _targetSiteLoc];
			_trigger setTriggerArea [10, 10, 0, false];
			_trigger setTriggerStatements [_triggerCondition, _triggerActivation, ""];
		};
	} forEach _targetGroupSites;
} forEach _missionTargets;

[_tasks, _notes] execVM "vendor\shk_taskmaster.sqf";

// Choose spawn point and move players to it
_spawnPoint = getMarkerPos (["spawn_0", "spawn_1"] call BIS_fnc_selectRandom);
{ _x setPos _spawnPoint } forEach (units (group bluforTeamLeader));
