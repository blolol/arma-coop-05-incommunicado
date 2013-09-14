/**
 * CBA functions.
**/

class Common {
	class defaultParam {
		file = "vendor\cba\fnc_defaultParam.sqf";
		description = "Gets a value from parameters list (usually _this) with a default";
	};

	class getArg {
		file = "vendor\cba\fnc_getArg.sqf";
		description = "Get default named argument from list";
	};
};

class Hash {
	class hashCreate {
		file = "vendor\cba\fnc_hashCreate.sqf";
		description = "Creates a Hash";
	};

	class hashEachPair {
		file = "vendor\cba\fnc_hashEachPair.sqf";
		description = "Iterate through all keys and values in a Hash";
	};

	class hashGet {
		file = "vendor\cba\fnc_hashGet.sqf";
		description = "Gets a value for a given key from a Hash";
	};

	class hashHasKey {
		file = "vendor\cba\fnc_hashHasKey.sqf";
		description = "Check if a Hash has a value defined for a key";
	};

	class hashRem {
		file = "vendor\cba\fnc_hashRem.sqf";
		description = "Removes given key from given Hash";
	};

	class hashSet {
		file = "vendor\cba\fnc_hashSet.sqf";
		description = "Sets a value for a given key in a Hash";
	};

	class isHash {
		file = "vendor\cba\fnc_isHash.sqf";
		description = "Check if a value is a Hash data structure";
	};
};
