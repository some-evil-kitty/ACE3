[
    QGVAR(enable), "CHECKBOX",
    [LSTRING(ModuleSettings_enable), LSTRING(ModuleSettings_enable_Description)],
    [LELSTRING(OptionsMenu,CategoryLogistics), LLSTRING(openMenu)],
    true,
    true,
    {[QGVAR(enable), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(loadTimeCoefficient), "SLIDER",
    [LSTRING(loadTimeCoefficient), LSTRING(loadTimeCoefficient_description)],
    [LELSTRING(OptionsMenu,CategoryLogistics), LLSTRING(openMenu)],
    [0, 10, 5, 1],
    true,
    {[QGVAR(loadTimeCoefficient), _this, true] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(paradropTimeCoefficent), "SLIDER",
    [LSTRING(paradropTimeCoefficent), LSTRING(paradropTimeCoefficent_description)],
    [LELSTRING(OptionsMenu,CategoryLogistics), LLSTRING(openMenu)],
    [0, 10, 2.5, 1],
    true,
    {[QGVAR(paradropTimeCoefficent), _this, true] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(cargoNetType), "LIST",
    [LSTRING(cargoNetType), LSTRING(cargoNetType_description)],
    [LELSTRING(OptionsMenu,CategoryLogistics), LLSTRING(openMenu)],
    [["CargoNet_01_box_F", "Land_WoodenBox_02_F"], [LSTRING(cargoNetType_modernStyle), LSTRING(cargoNetType_ww2)], 0],
    true,
    {[QGVAR(cargoNetType), _this, true] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;
