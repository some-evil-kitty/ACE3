#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Starts ammunition detonating from an object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Destroy when finished <BOOL> (default: false)
 * 2: Source <OBJECT> (default: objNull)
 * 3: Instigator <OBJECT> (default: objNull)
 * 4: Initial delay <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call ace_cookoff_fnc_detonateAmmunition
 *
 * Public: No
 */

if (!isServer) exitWith {};

params ["_object", ["_destroyWhenFinished", false], ["_source", objNull], ["_instigator", objNull], ["_initialDelay", 0]];

if (isNull _object) exitWith {};

// Don't have an object detonate its ammo twice
if (_object getVariable [QGVAR(isAmmoDetonating), false]) exitWith {};

_object setVariable [QGVAR(isAmmoDetonating), true, true];

_object setVariable [QGVAR(cookoffMagazines), _object call FUNC(getVehicleAmmo)];

// TODO: When setMagazineTurretAmmo and magazineTurretAmmo are fixed (https://feedback.bistudio.com/T79689),
// we can add gradual ammo removal during cook-off
if (GVAR(removeAmmoDuringCookoff)) then {
    clearMagazineCargoGlobal _object;

    {
        [QEGVAR(common,removeMagazinesTurret), [_object, _x select 0, _x select 1], _object, _x select 1] call CBA_fnc_turretEvent;
    } forEach (magazinesAllTurrets _object);
};

[FUNC(detonateAmmunitionServer), [_object, _destroyWhenFinished, _source, _instigator], _initialDelay] call CBA_fnc_waitAndExecute;
