// Parameters passed by the action
_params = _this select 3;
_action = _params select 0;

////////////////////////////////////////////////
// Handle actions
////////////////////////////////////////////////
if (_action == "action_revive") then
{
	[] spawn FAR_HandleRevive;
};

if (_action == "action_suicide") then
{
	player setDamage 1;
};

if (_action == "action_drag") then
{
	[] spawn FAR_Drag;
};

if (_action == "action_release") then
{
	[] spawn FAR_Release;
};