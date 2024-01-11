#include "..\script_component.hpp"
/*
 * Author: Lambda.Tiger
 * This function adds rounds using their config init EH

 * Arguments:
 * 0: _projectile <OBJECT> - The object created
 * 
 * Return Value:
 * None
 *
 * Example:
 * [_proj] call ace_frag_fnc_initRound;
 *
 * Public: No
 */
params [
    ["_projectile", objNull, [objNull]]
];


private _ammo = typeOf _projectile;
if (_ammo isEqualTo "" || {isNull _projectile}) exitWith {
    TRACE_2("bad ammo or projectile",_ammo,_projectile);
};

private _shouldFrag = _ammo call FUNC(shouldFrag);
if (_doFrag) then {
    _projectile addEventHandler [
        "Explode",
        {
            params ["_proj"];
            private _shotParents = getShotParents _proj;
            private _ammo = typeOf _proj;
            // wait for frag damage to kill units before spawning fragments
            [
                FUNC(doFrag),
                _this + [_ammo, _shotParents]
            ] call CBA_fnc_execNextFrame;
        }
    ];
};


private _shouldSpall = _ammo call FUNC(shouldSpall);
if (GVAR(spallEnabled) && {_shouldSpall}) then 
{
    _projectile addEventHandler [
        "HitPart",
        {
            params ["_proj", "_hitObj", "",
                "_posASL", "_vel", "_sNorm", "",
                "", "_surfType"
            ];
            private _shotPrnt = getShotParents _proj;
            private _ammo = typeOf _proj;
            private _vUp = vectorUp _proj;
            [
                QGVAR(spall_eh),
                [_proj, _hitObj, _posASL, _vel, _sNorm, _surfType, _ammo, _shotPrnt, _vUp]
            ] call CBA_fnc_serverEvent;
		};
    ];
};