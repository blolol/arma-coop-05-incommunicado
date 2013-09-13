/**
 * Functions used by clients and the server.
**/

class Common {
	class config {
		file = "lib\functions\config.sqf";
		description = "Returns a CfgBlolol configuration value";
	};

	class debug {
		file = "lib\functions\debug.sqf";
		description = "Logs a debug message if debug mode is enabled";
	};

	class hash_create {
		file = "vendor\cba\hashes\fnc_hashCreate.sqf";
		description = "Creates a Hash";
	};

	class hash_eachPair {
		file = "vendor\cba\hashes\fnc_hashEachPair.sqf";
		description = "Iterate through all keys and values in a Hash";
	};

	class hash_get {
		file = "vendor\cba\hashes\fnc_hashGet.sqf";
		description = "Gets a value for a given key from a Hash";
	};

	class hash_hasKey {
		file = "vendor\cba\hashes\fnc_hashHasKey.sqf";
		description = "Check if a Hash has a value defined for a key";
	};

	class hash_rem {
		file = "vendor\cba\hashes\fnc_hashRem.sqf";
		description = "Removes given key from given Hash";
	};

	class hash_set {
		file = "vendor\cba\hashes\fnc_hashSet.sqf";
		description = "Sets a value for a given key in a Hash";
	};

	class hash_isHash {
		file = "vendor\cba\hashes\fnc_isHash.sqf";
		description = "Check if a value is a Hash data structure";
	};
};
