/**
 * Copies the player's position and heading to the clipboard in config format.
**/

private ["_target", "_pos", "_dir", "_str"];
_target = _this select 1;
_pos = getPosATL _target;
_dir = getDir _target;
_str = format ["{ { %1, %2, %3 }, %4 }", (_pos select 0), (_pos select 1), (_pos select 2), _dir];

copyToClipboard _str;
hint format ['Copied to clipboard: "%1"', _str];
