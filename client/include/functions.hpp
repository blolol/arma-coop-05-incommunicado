/**
 * Functions used by clients.
**/

class Client {
	class debug_copyPositionToClipboard {
		file = "client\lib\functions\debug\copy_position_to_clipboard.sqf";
		description = "Copies the unit's position and heading to the clipboard";
	};

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
