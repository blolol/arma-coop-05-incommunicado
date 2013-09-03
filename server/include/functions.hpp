/**
 * Functions used by the server.
**/

class Server {
	class gc_despawnEventually {
		file = "server\lib\functions\gc\despawn_eventually.sqf";
		description = "Despawns a unit when players are far enough away from it";
	};

	class objectives_checkForCompletion {
		file = "server\lib\functions\objectives\check_for_completion.sqf";
		description = "Checks to see if any objectives have been completed";
	};

	class players_all {
		file = "server\lib\functions\players\all.sqf";
		description = "Returns an array of all live, non-captive players";
	};

	class players_closestDistanceToUnit {
		file = "server\lib\functions\players\closest_distance_to_unit.sqf";
		description = "Returns the distance between the unit and the closest live player";
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
