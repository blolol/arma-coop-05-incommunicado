////////////////////////////////////////////////
// Add Player Actions
////////////////////////////////////////////////
FAR_Player_Actions =
{
	if (alive player && player isKindOf "Man") then 
	{
		// addAction args: title, filename, (arguments, priority, showWindow, hideOnUse, shortcut, condition, positionInModel, radius, radiusView, showIn3D, available, textDefault, textToolTip)
		player addAction ["<t color=""#C90000"">" + "Revive" + "</t>", "vendor\FAR_revive\FAR_handleAction.sqf", ["action_revive"], 10, true, true, "", "[] call FAR_Check_Revive"];
		player addAction ["<t color=""#C90000"">" + "Suicide" + "</t>", "vendor\FAR_revive\FAR_handleAction.sqf", ["action_suicide"], 9, false, true, "", "[] call FAR_Check_Suicide"];
		player addAction ["<t color=""#C90000"">" + "Drag" + "</t>", "vendor\FAR_revive\FAR_handleAction.sqf", ["action_drag"], 9, false, true, "", "[] call FAR_Check_Dragging"];
	};
};

////////////////////////////////////////////////
// Handle Death
////////////////////////////////////////////////
FAR_HandleDamage_EV =
{
	private ["_unit", "_amountOfDamage", "_isUnconscious"];
	_unit = _this select 0;
	_amountOfDamage = _this select 2;
	_killer = _this select 3;
	_isUnconscious = _unit getVariable "FAR_isUnconscious";
	
	if (alive _unit && _amountOfDamage >= 1 && _isUnconscious == 0) then 
	{
		_unit setDamage 0;
		_unit allowDamage false;
		[_unit, _killer] spawn FAR_Player_Unconscious;
	};
	
	_amountOfDamage
};

////////////////////////////////////////////////
// Make Player Unconscious
////////////////////////////////////////////////
FAR_Player_Unconscious =
{
	private["_unit", "_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
	
	// Death message
	if (FAR_EnableDeathMessages && !isNil "_killer" && isPlayer _killer && _killer != _unit) then
	{
		FAR_deathMessage = [1, _unit, _killer];
		publicVariable "FAR_deathMessage";
		[0, [1, _unit, _killer]] call FAR_public_EH;
	};
	
	if (isPlayer _unit) then
	{
		disableUserInput true;
		titleText ["", "BLACK FADED"];
	};
	
	// Eject unit if inside vehicle
	if (vehicle _unit != _unit) then 
	{
		unAssignVehicle _unit;
		_unit action ["eject", vehicle _unit];
		
		sleep 2;
	};
	
	_unit setDamage 0;
    _unit setVelocity [0,0,0];
    _unit allowDamage false;
	_unit setCaptive true;
    _unit playMove "AinjPpneMstpSnonWrflDnon_rolltoback";
	
	sleep 4;
    
	if (isPlayer _unit) then
	{
		titleText ["", "BLACK IN", 1];
		disableUserInput false;
	};
	
	_unit switchMove "AinjPpneMstpSnonWrflDnon";
	_unit enableSimulation false;
	_unit setVariable ["FAR_isUnconscious", 1, true];
	
	// [Debugging] Call this code only on players
	if (isPlayer _unit) then 
	{
		_bleedOut = time + FAR_BleedOut;
		
		while { !isNull _unit && alive _unit && _unit getVariable "FAR_isUnconscious" == 1 && (FAR_BleedOut <= 0 || time < _bleedOut) } do
		{
			hintSilent format["Bleedout in %1 seconds\n\n%2", round (_bleedOut - time), call FAR_CheckFriendlies];
			
			sleep 0.5
		};
		
		// Player bled out
		if (FAR_BleedOut > 0 && time > _bleedOut) then
		{
			_unit setDamage 1;
			_unit setVariable ["FAR_isUnconscious", 0, true];
			_unit setVariable ["FAR_isDragged", 0, true];
		}
		else
		{
			// Player got revived
			sleep 6;
			
			// Clear the "medic nearby" hint
			hintSilent "";
			
			_unit enableSimulation true;
			_unit allowDamage true;
			_unit setDamage 0;
			_unit setCaptive false;
			
			_unit playMove "amovppnemstpsraswrfldnon";
			_unit playMove "";
		};
	}
	else
	{
		// [Debugging] Bleedout for AI
		_bleedOut = time + FAR_BleedOut;
		
		while { !isNull _unit && alive _unit && _unit getVariable "FAR_isUnconscious" == 1 && (FAR_BleedOut <= 0 || time < _bleedOut) } do
		{
			sleep 0.5;
		};
		
		// AI bled out
		if (FAR_BleedOut > 0 && time > _bleedOut) then
		{
			_unit setDamage 1;
			_unit setVariable ["FAR_isUnconscious", 0, true];
			_unit setVariable ["FAR_isDragged", 0, true];
		}
	};
};

////////////////////////////////////////////////
// Revive Player
////////////////////////////////////////////////
FAR_HandleRevive =
{
	private ["_target", "_targets"];
	_targets = nearestObjects [player, ["Man"], 2];

	if (count _targets > 1) then
	{
		_target = _targets select 1;
	
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		_target setVariable ["FAR_isUnconscious", 0, true];
		_target setVariable ["FAR_isDragged", 0, true];
		
		sleep 6;
		
		// [Debugging] Code below is only relevant if revive script is enabled for AI
		if (!isPlayer _target) then
		{
			_target enableSimulation true;
			_target allowDamage true;
			_target setDamage 0;
			_target setCaptive false;
			
			_target playMove "amovppnemstpsraswrfldnon";
		};
	
	};
};

////////////////////////////////////////////////
// Drag Injured Player
////////////////////////////////////////////////
FAR_Drag =
{
	private ["_target", "_targets"];
	
	_targets = nearestObjects [player, ["Man"], 2];
	
	if (count _targets > 1) then
	{
		FAR_isDragging = true;
		_target = _targets select 1;
		
		_target attachTo [player, [0, 1.1, 0.092]];
		_target setDir 180;
		_target setVariable ["FAR_isDragged", 1, true];
		
		player playMoveNow "AcinPknlMstpSrasWrflDnon";
		
		// Rotation fix
		FAR_isDragging_EH = [0, _target];
		publicVariable "FAR_isDragging_EH";
		
		// Add release action and save its id so it can be removed
		_id = player addAction ["<t color=""#C90000"">" + "Release" + "</t>", "vendor\FAR_revive\FAR_handleAction.sqf", ["action_release"], 10, true, true, "", "true"];
		
		hint "Press 'C' if you can't move.";
		
		// Wait until release action is used
		waitUntil { !Alive player || player getVariable "FAR_isUnconscious" == 1 || isNull _target || !alive _target || _target getVariable "FAR_isUnconscious" == 0 || !FAR_isDragging || _target getVariable "FAR_isDragged" == 0 };

		// Handle release action
		FAR_isDragging = false;
		
		if (!isNil "_target" && Alive _target) then
		{
			_target switchMove "AinjPpneMstpSnonWrflDnon";
			_target setVariable ["FAR_isDragged", 0, true];
			detach _target;
		};
		
		player playMove "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";
		player removeAction _id;
	};
};

FAR_Release =
{
	FAR_isDragging = false;
};

////////////////////////////////////////////////
// Event handler for public variables
////////////////////////////////////////////////
FAR_public_EH =
{
	_params = _this select 1;
	
	if(count _params < 2) exitWith {};
	
	_action  = _params select 0;
	
	// FAR_isDragging
	_target = _params select 1;
	
	if (_action == 0 && !isNull _target) then
	{
		_target setDir 180;
	};
	
	// FAR_deathMessage
	if (count _params < 3) exitWith {};
	
	_killed = _params select 1;
	_killer = _params select 2;
	
	if (_action == 1 && isPlayer _killed && isPlayer _killer) then
	{
		systemChat format["%1 was injured by %2", name _killed, name _killer];
	};
};

////////////////////////////////////////////////
// Revive Action Check
////////////////////////////////////////////////
FAR_Check_Revive = 
{
	private ["_target", "_targets"];
	_return = false;
	_targets = nearestObjects [player, ["Man"], 2];
	
	// Unit that will excute the action
	_isPlayerUnconscious = player getVariable "FAR_isUnconscious";
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	
	if (alive player && _isPlayerUnconscious == 0 && !FAR_isDragging && count _targets > 1) then
	{
		// Target of the action
		_target = _targets select 1;
		_isTargetUnconscious = _target getVariable "FAR_isUnconscious";
		_isDragged = _target getVariable "FAR_isDragged"; 
		
		// Make sure target is unconscious
		if (alive _target && _isTargetUnconscious == 1 && _isDragged == 0 && (_isMedic == 1 || FAR_CasualMode)) then
		{
			_return = true;
		};
	};
	
	_return
};

////////////////////////////////////////////////
// Suicide Action Check
////////////////////////////////////////////////
FAR_Check_Suicide =
{
	_return = false;
	_isPlayerUnconscious = player getVariable "FAR_isUnconscious";
	
	if (alive player && _isPlayerUnconscious == 1) then 
	{
		_return = true;
	};
	
	_return
};

////////////////////////////////////////////////
// Dragging Action Check
////////////////////////////////////////////////
FAR_Check_Dragging =
{
	private ["_target", "_targets"];
	_return = false;
	_targets = nearestObjects [player, ["Man"], 2];
	
	if(count _targets > 1) then
	{
		_isPlayerUnconscious = player getVariable "FAR_isUnconscious";
		
		// Target of the action
		_target = _targets select 1;
		_isTargetUnconscious = _target getVariable "FAR_isUnconscious";
		_isDragged = _target getVariable "FAR_isDragged"; 
		
		if(alive player && _isPlayerUnconscious == 0 && !FAR_isDragging && Alive _target && _isTargetUnconscious == 1 && _isDragged == 0) then
		{
			_return = true;
		};
	};
	
	_return
};

////////////////////////////////////////////////
// Show Nearby Friendly Medics
////////////////////////////////////////////////
FAR_IsFriendlyMedic =
{
	private ["_unit"];
	
	_return = false;
	_unit = _this select 0;
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "attendant");
				
	if (alive _unit && (isPlayer _unit || FAR_Debugging) && side _unit == FAR_PlayerSide && _unit getVariable "FAR_isUnconscious" == 0 && (_isMedic == 1 || FAR_CasualMode)) then
	{
		_return = true;
	};
	
	_return
};

FAR_CheckFriendlies =
{
	private ["_unit", "_units", "_medics", "_hintMsg"];
	
	_units = nearestObjects [getpos player, ["Man", "Car", "Air", "Ship"], 800];
	_medics = [];
	_dist = 800;
	_hintMsg = "";
	
	// Find nearby friendly medics
	if (count _units > 1) then
	{
		{
			if (_x isKindOf "Car" || _x isKindOf "Air" || _x isKindOf "Ship") then
			{
				if (alive _x && count (crew _x) > 0) then
				{
					{
						if ([_x] call FAR_IsFriendlyMedic) then
						{
							_medics = _medics + [_x];
							
							if (true) exitWith {};
						};
					} forEach crew _x;
				};
			} 
			else 
			{
				if ([_x] call FAR_IsFriendlyMedic) then
				{
					_medics = _medics + [_x];
				};
			};
			
		} forEach _units;
	};
	
	if (count _medics > 0) then
	{
		// Sort medics by distance
		{
			if (player distance _x < _dist) then
			{
				_unit = _x;
				_dist = player distance _x;
			};
		
		} forEach _medics;
		
		if (!isNull _unit) then
		{
			_unitName	= name _unit;
			_distance	= floor (player distance _unit);
			
			_hintMsg = format["Nearby Medic:\n%1 is %2m away.", _unitName, _distance];
		};
	} 
	else 
	{
		_hintMsg = "No medic nearby.";
	};
	
	_hintMsg
};



