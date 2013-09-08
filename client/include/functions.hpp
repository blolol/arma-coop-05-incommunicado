/**
 * Functions used by clients.
**/

class Client {
	class loadout_get {
		file = "vendor\a3-loadout\get_loadout.sqf";
		description = "Gets a unit's loadout";
	};

	class loadout_init {
		file = "client\lib\functions\loadout\init.sqf";
		description = "Initializes loadout persistence";
	};

	class loadout_set {
		file = "vendor\a3-loadout\set_loadout.sqf";
		description = "Sets a unit's loadout";
	};
};
