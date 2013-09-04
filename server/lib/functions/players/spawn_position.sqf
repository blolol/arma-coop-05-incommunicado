/**
 * Returns the randomly-selected BLUFOR player spawn position, or an empty array if one has not yet
 * been selected.
**/

if (!(isNil "BLOL_spawnPosition")) then {
	BLOL_spawnPosition;
} else {
	private ["_spawn"];
	_spawn = [];

	if (!(isNil "SHK_randstapos_selected")) then {
		{
			_side = _x select 0;
			_markerIndex = _x select 1;

			if (_side == "west") exitWith {
				private ["_markerName"];

				_markerName = if (_markerIndex == 0) then {
					"startpos_west";
				} else {
					format ["startpos_west_%1", _markerIndex];
				};

				_spawn = getMarkerPos _markerName;
			};
		} forEach SHK_randstapos_selected;
	};

	BLOL_spawnPosition = _spawn;
	_spawn;
};
