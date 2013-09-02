//
// Farooq's Revive 1.4a
//

//------------------------------------------//
// Parameters - Feel free to edit these
//------------------------------------------//

// Seconds until unconscious unit bleeds out and dies. Set to 0 to disable.
FAR_BleedOut = 500;	

// Enable teamkill notifications
FAR_EnableDeathMessages = true;

// If set to false, only medics will be able to revive
FAR_CasualMode = false;

//------------------------------------------//

call compile preprocessFile "vendor\FAR_revive\FAR_revive_funcs.sqf";

#define SCRIPT_VERSION "1.4a"

FAR_isDragging = false;
FAR_deathMessage = [];
FAR_isDragging_EH = [];
FAR_Debugging = true;

if (isDedicated) exitWith {};

////////////////////////////////////////////////
// Player Initialization
////////////////////////////////////////////////
[] spawn
{
    waitUntil {!isNull player};

	// Public event handlers
	"FAR_isDragging_EH" addPublicVariableEventHandler FAR_public_EH;
	"FAR_deathMessage" addPublicVariableEventHandler FAR_public_EH;
	
	[] spawn FAR_Player_Init;
	
	hintSilent format["Farooq's Revive %1 is initialized.", SCRIPT_VERSION];

	// Event Handlers
	player addEventHandler 
	[
		"Respawn", 
		{ 
			[] spawn FAR_Player_Init;
		}
	];
};

// Drag & Carry animation fix
[] spawn
{
	while {true} do
	{
		if (animationState player == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || (!FAR_isDragging && animationState player == "AcinPknlMstpSrasWrflDnon")) then
		{
			player switchMove "AcinPknlMstpSrasWrflDnon";
		};
			
		sleep 10;
	}
};

FAR_Player_Init =
{
	// Cache player's side
	FAR_PlayerSide = side player;

	player addEventHandler ["HandleDamage", FAR_HandleDamage_EV];
	player addEventHandler 
	[
		"Killed",
		{
			// Remove dead body of player (for missions with respawn enabled)
			_body = _this select 0;
			
			[_body] spawn 
			{
			
				waitUntil { Alive player };
				_body = _this select 0;
				deleteVehicle _body;
			}
		}
	];
	
	player setVariable ["FAR_isUnconscious", 0, true];
	player setVariable ["FAR_isDragged", 0, true];
	FAR_isDragging = false;
	
	[] spawn FAR_Player_Actions;
};

////////////////////////////////////////////////
// [Debugging] Add revive to playable AI units
////////////////////////////////////////////////
if (!FAR_Debugging) exitWith {};

_allUnits = playableUnits;

// For editor
if (!isMultiplayer) then
{
	_allUnits = switchableUnits;
};

// For multiplayer
{
	if (!isPlayer _x) then 
	{
		_x addEventHandler ["HandleDamage", FAR_HandleDamage_EV];
		_x setVariable ["FAR_isUnconscious", 0, true];
		_x setVariable ["FAR_isDragged", 0, true];
	}
} forEach _allUnits;

_allUnits = nil;
