/*
  SHK_randstapos - Starting position randomizer with object mover
  Author: Shuko (IRC: shuko@quakenet, email: miika@miikajarvinen.fi)
  Version: 0.2
  http://forums.bistudio.com/showthread.php?162423-SHK_startingPositionRandomizer

  Randomly selects a location for each side from predefined, editor placed, markers.

  IMPORTANT!
    The positions of all units and objects to be moved are based on their relative position to the
    first marker (for example startpos_east). What this means is that you should place your
    objects around/on top of the first marker.

    For example, if the randomizer decides that the starting position is startpos_east_2 instead of
    startpos_east. All the objects will be moved and placed to same direction and distance from
    the position 2 marker that they were from position marker startpos_east.

  Marker naming:
    All markers need to start with "startpos", following an underscore and side. Then an underscore
    and an incremental integer. Only exception is the first marker, it has no number.

    Examples:
      startpos_east
      startpos_east_1

      startpos_west
      startpos_west_1
      startpos_west_2

    Tip: if you first create the marker without number, you can copy & paste that and rest of the
    markers will be named correctly.

  Supported sides:
    "east", "west", "guer", "civ"

  Syntax:
    [["side",number,<objectrange>,[]],["side",number,[object1,object2],["color","type","text"]],...] call compile preprocessfile "shk_randstapos.sqf"

  Parameters:
    0   String    One of the four sides.
    1   Integer   How many possible positions (markers) there is for this side.

  Optional parameters:
    2   Number    Range in meters from the first marker to move all vehicles etc objects.
        Array     List of objects to move besides playableunits.
    3   Array     If given an empty array ([]) a green "Start" type marker will be shown at the selected starting position.
                  Settings to define the appearance of the start marker.
                  0  Color  Valid colors: black, blue, green, orange, red, white, yellow
                  1  Type   Marker types: http://community.bistudio.com/wiki/cfgMarkers
                  2  Text   Optional. Text to display next to the marker.

  Examples:
    [["west",3]] call compile preprocessfile "shk_randstapos.sqf"
    [["west",3],["east",2]] call compile preprocessfile "shk_randstapos.sqf"
    [["west",2,20],["east",5,[car1,truck4]]] call compile preprocessfile "shk_randstapos.sqf"
    [["west",3,0,[]]] call compile preprocessfile "shk_randstapos.sqf"
    [["west",3,50,["blue","b_inf","Infantry"]]] call compile preprocessfile "shk_randstapos.sqf"

  Briefing:
    If marker parameter(s) is defined for a side, a marker with name "startpos" is created at the starting location.
    This marker will be different for each side, but has same name on each client, which means you can link to this marker
    in briefing and/or notes and it will point to a location of the player's starting position.

  Version history:
    0.2  Switch to Arma 3, changed start marker to A3 equivalent. Now object height is also taken into account.
*/

// [object, position of old point of reference, position of new point of reference]
SHK_fnc_move = {
  private ["_dir","_dst","_obj","_new","_old"];
  _obj = _this select 0;
  _old = _this select 1;
  _new = _this select 2;
  _dir = ((getpos _obj select 0) - (_old select 0)) atan2 ((getpos _obj select 1) - (_old select 1));
  _dst = _old distance _obj;
  _obj setpos [((_new select 0) + (_dst * sin _dir)),((_new select 1) + (_dst * cos _dir)),(getpos _obj select 2)];
};

if isserver then {
  private ["_side","_rand","_oldPos","_newPos","_range"];
  SHK_randstapos_selected = [];
  {
    _side = tolower(_x select 0);
    _rand = floor(random (_x select 1));
    SHK_randstapos_selected set [count SHK_randstapos_selected, [_side,_rand]];

    // only move if randomly selected position is other than the current position
    if (_rand > 0) then {
      _oldPos = getmarkerpos format ["startpos_%1",_side];
      _newPos = getmarkerpos format ["startpos_%1_%2",_side,_rand];

      // move playable units
      {
        if (_side == tolower(format ["%1",side _x])) then {
          [_x,_oldPos,_newPos] call SHK_fnc_move;
        };
      } foreach (if ismultiplayer then {playableunits} else {switchableunits});

      // move non-playable objects
      if (count _x > 2) then {
        _range = _x select 2;
        // list of objects
        if (typename _range  == (typename [])) then {
          if (count _range > 0) then {
            {
              [_x,_oldPos,_newPos] call SHK_fnc_move;
            } foreach _range;
          };

        // only range given
        } else {
          if (_range > 0) then {
            private ["_objects","_xPos","_dir","_dst"];
            _objects = nearestobjects [_oldPos,[],_range];

            {
              _xPos = getpos _x;
              _dir = ((_xPos select 0) - (_oldPos select 0)) atan2 ((_xPos select 1) - (_oldPos select 1));
              _dst = _oldPos distance _xPos;
              _x setpos [((_newPos select 0) + (_dst * sin _dir)),
                        ((_newPos select 1) + (_dst * cos _dir)),
                        0];
            } foreach _objects;
          };
        };
      };
    };
  } foreach _this;
  publicvariable "SHK_randstapos_selected";
};

if (hasInterface) then {
  _this spawn {
    private ["_s","_m","_p"];
    waituntil {!isnull player};
    waituntil {!isnil "SHK_randstapos_selected"};

    _s = tolower(str(side player));

    private ["_markerIndex", "_markerName"];
    {
      private ["_side", "_rand"];
      _side = _x select 0;
      _rand = _x select 1;

      if (_side == _s) then {
        _markerIndex = _rand;
      };
    } forEach SHK_randstapos_selected;

    if (!(isNil "_markerIndex")) then {
      private ["_markerName", "_oldPos", "_newPos", "_spawnMarker", "_outpostMarker",
        "_respawnMarker"];

      _markerName = if (_markerIndex > 0) then {
        format ["startpos_%1_%2", _s, _markerIndex];
      } else {
        format ["startpos_%1", _s];
      };

      _oldPos = getPos player;
      _newPos = getMarkerPos _markerName;

      if (_markerIndex > 0) then {
        [player, _oldPos, _newPos] call SHK_fnc_move;
      };

      _spawnMarker = createMarkerLocal ["startpos", _newPos];
      _spawnMarker setMarkerShapeLocal "ICON";
      _spawnMarker setMarkerTypeLocal "mil_start";
      _spawnMarker setMarkerColorLocal "ColorBLUFOR";
      _spawnMarker setMarkerTextLocal "BLUFOR Insertion";

      _outpostMarker = format ["outpost_%1_%2", _s, _markerIndex];
      _outpostMarker setMarkerShapeLocal "ICON";
      _outpostMarker setMarkerTypeLocal "mil_objective";
      _outpostMarker setMarkerColorLocal "ColorOPFOR";
      _outpostMarker setMarkerTextLocal "OPFOR Outpost";

      _respawnMarker = createMarkerLocal ["respawn_west", _newPos];
      _respawnMarker setMarkerTypeLocal "empty";
    };
  };
};
