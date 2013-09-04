/**
 * Functions used by the server.
**/

class Server {
	class gc_init {
		file = "server\lib\functions\gc\init.sqf";
		description = "Initializes periodic garbage collection of objects far away from players";
	};

	class gc_mark {
		file = "server\lib\functions\gc\mark.sqf";
		description = "Marks an object for garbage collection";
	};

	class gc_sweep {
		file = "server\lib\functions\gc\sweep.sqf";
		description = "Garbage collects entities far away from players";
	};

	class objectives_checkForCompletion {
		file = "server\lib\functions\objectives\check_for_completion.sqf";
		description = "Checks to see if any objectives have been completed";
	};

	class objectives_choose {
		file = "server\lib\functions\objectives\choose.sqf";
		description = "Choose mission objectives";
	};

	class objectives_init {
		file = "server\lib\functions\objectives\init.sqf";
		description = "Initialize mission objectives";
	};

	class players_all {
		file = "server\lib\functions\players\all.sqf";
		description = "Returns an array of all live, non-captive players";
	};

	class players_closestDistanceToUnit {
		file = "server\lib\functions\players\closest_distance_to_unit.sqf";
		description = "Returns the distance between the unit and the closest live player";
	};

	class players_spawnPosition {
		file = "server\lib\functions\players\spawn_position.sqf";
		description = "Returns the randomly-selected BLUFOR spawn position";
	};

	class targets_hash {
		file = "server\lib\functions\targets\hash.sqf";
		description = "Generate a deterministic unique ID for the target";
	};

	class targets_markDestroyed {
		file = "server\lib\functions\targets\mark_destroyed.sqf";
		description = "Mark a target as destroyed";
	};
};
