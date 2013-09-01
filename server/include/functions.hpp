/**
 * Functions used by the server.
**/

class Server {
	class objectives_checkForCompletion {
		file = "server\lib\functions\objectives\check_for_completion.sqf";
		description = "Checks to see if any objectives have been completed";
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
