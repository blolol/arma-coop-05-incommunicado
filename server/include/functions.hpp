/**
 * Functions used by the server.
**/

class Server {
	class ambiance_civilianVehicles {
		file = "server\lib\functions\ambiance\civilian_vehicles.sqf";
		description = "Spawns civilian vehicles in nearby villages and cities";
	};

	class ambiance_paradrop {
		file = "server\lib\functions\ambiance\paradrop.sqf";
		description = "Lands enemy troops at a location via helicopter";
	};

	class ambiance_paradrops {
		file = "server\lib\functions\ambiance\paradrops.sqf";
		description = "Periodically lands enemy troops near players via helicopter";
	};

	class ambiance_randomCivilianVehicleClass {
		file = "server\lib\functions\ambiance\random_civilian_vehicle_class.sqf";
		description = "Returns a random civilian vehicle class based on weights";
	};

	class ambiance_randomVehicleDamage {
		file = "server\lib\functions\ambiance\random_vehicle_damage.sqf";
		description = "Returns a pseudorandom vehicle damage value based on weights";
	};

	class ambiance_randomVehicleFuel {
		file = "server\lib\functions\ambiance\random_vehicle_fuel.sqf";
		description = "Returns a pseudorandom vehicle fuel value based on weights";
	};

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

	class objectives_isActive {
		file = "server\lib\functions\objectives\is_active.sqf";
		descriptions = "Returns true if the given objective is active (there are nearby players)";
	};

	class objectives_markActive {
		file = "server\lib\functions\objectives\mark_active.sqf";
		description = "Marks an objective as active (there are nearby players)";
	};

	class objectives_markInactive {
		file = "server\lib\functions\objectives\mark_inactive.sqf";
		description = "Marks an objective as inactive (there are no nearby players)";
	};

	class objectives_militarize {
		file = "server\lib\functions\objectives\militarize.sqf";
		description = "Spawns military units on a marker within a given radius";
	};

	class objectives_watch {
		file = "server\lib\functions\objectives\watch.sqf";
		description = "Perform objective actions when players are nearby";
	};

	class players_all {
		file = "server\lib\functions\players\all.sqf";
		description = "Returns an array of all live, non-captive players";
	};

	class players_closestDistanceTo {
		file = "server\lib\functions\players\closest_distance_to.sqf";
		description = "Returns the distance between the location and the closest live player";
	};

	class players_nearbyLocations {
		file = "server\lib\functions\players\nearby_locations.sqf";
		description = "Returns locations near all live players";
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
