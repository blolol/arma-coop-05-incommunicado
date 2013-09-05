/**
 * Available mission objectives
 *
 * Each objective consists of a description, general location and one or more targets. We group
 * multiple targets into objectives to prevent players from receiving individual tasks to destroy
 * radio towers which are right next to each other.
 *
 * Each objective is defined like this:
 *
 * [
 *   "TITLE", -- Used as task title and displayed as a task waypoint tooltip.
 *   "DESCRIPTION", -- Used in task description. "%1" is replaced with the name of the objective marker.
 *   "MARKER_NAME", -- Name of a marker located in the general vicinity of the targets.
 *   [ TARGET, (TARGET, (TARGET ...)) ], -- Individual targets
 *   [ ACTION, (ACTION, (ACTION ...)) ] -- Actions to take when players are close to the objective
 * ]
 *
 * Each target is defined like this:
 *
 * [
 *   "TYPE", -- If the target is part of the game world, then "static". If the target is created
 *              on-the-fly by this mission, then "dynamic".
 *   "MARKER_NAME", -- The name of a marker located at the target.
 *   "CLASS_NAME" -- The target's object class. Used to locate the physical target near the marker.
 * ]
**/

[
	[
		"Kavala radio towers",
		"the two radio towers <marker name='%1'>north of Kavala<marker>",
		"static_objective_0",
		[
			["static", "static_tower_0", "Land_TTowerBig_1_F"],
			["static", "static_tower_1", "Land_TTowerBig_2_F"]
		],
		[
			["militarize", "static_objective_0", 30]
		]
	],
	[
		"Galati radio tower",
		"the radio tower <marker name='%1'>west of Galati</marker>",
		"static_tower_2",
		[
			["static", "static_tower_2", "Land_TTowerBig_2_F"]
		],
		[
			["militarize", "static_tower_2", 30],
			["militarize", "static_objective_1_action_0", 30],
			["militarize", "static_objective_1_action_1", 60]
		]
	],
	[
		"Sofia radio towers",
		"the two radio towers <marker name='%1'>between Sofia and Molos</marker>",
		"static_objective_2",
		[
			["static", "static_tower_3", "Land_TTowerBig_2_F"],
			["static", "static_tower_4", "Land_TTowerBig_2_F"]
		],
		[
			["militarize", "static_tower_3", 20],
			["militarize", "static_tower_4", 20]
		]
	],
	[
		"Pyrgos radio tower",
		"the radio tower <marker name='%1'>southeast of Pyrgos</marker>",
		"static_tower_5",
		[
			["static", "static_tower_5", "Land_TTowerBig_2_F"]
		],
		[
			["militarize", "static_tower_5", 20]
		]
	],
	[
		"Panagia radio towers",
		"the two radio towers <marker name='%1'>northwest of Panagia</marker>",
		"static_objective_4",
		[
			["static", "static_tower_6", "Land_TTowerBig_2_F"],
			["static", "static_tower_7", "Land_TTowerBig_2_F"]
		],
		[
			["militarize", "static_tower_6", 20],
			["militarize", "static_tower_7", 20]
		]
	]
];
