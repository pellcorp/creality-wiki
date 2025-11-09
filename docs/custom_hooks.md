Within Simple AF if you want to call a custom gcode macro you can with hooks, the following custom gcode macro hooks are supported and more can be added as needed:

- **_SAF_HOMING_START** - at start of homing
- **_SAF_HOMING_END** - at end of homing
- **_SAF_START_PRINT_BEFORE_G28** - Before G28 is called in START_PRINT
- **_SAF_START_PRINT_AFTER_G28** - After G28 is called in START_PRINT
- **_SAF_START_PRINT_BEFORE_BED_MESH** - Before bed mesh calibrate is called in START_PRINT
- **_SAF_START_PRINT_AFTER_BED_MESH** - After bed mesh calibrate is called in START_PRINT
- **_SAF_NOZZLE_WIPE** - A nozzle wipe macro that can be defined for eddyny, beacon, cartographer and cartotouch only, will be called before bed mesh for eddny and beacon, and after bed mesh for cartographer and cartotouch
- **_SAF_BED_MESH_START** - Start of bed mesh calibrate
- **_SAF_BED_MESH_END** - End of bed mesh calibrate
- **_SAF_ON_FILAMENT_RUNOUT** - When filament runout is triggered
- **_SAF_ON_CANCEL** - When cancel print is triggered
- **_SAF_START_PRINT_START** - Very start of START_PRINT
- **_SAF_START_PRINT_BEFORE_LINE_PURGE** - Just before Line Purge in start print
- **_SAF_START_PRINT_END** - Very end of START_PRINT
- **_SAF_END_PRINT_START** - Very start of END_PRINT
- **_SAF_END_PRINT_END** - Very end of END_PRINT
- **_SAF_HEATING_NOZZLE_START** - At start of M109 macro
- **_SAF_HEATING_NOZZLE_END** - At start of M109 macro
- **_SAF_HEATING_BED_START** - At start of M190 macro
- **_SAF_HEATING_BED_END** - At end of M190 macro

So the way this works is you define your own custom config file (make sure it has a `.cfg` file extension), and add it to printer.cfg like so:

```
[include MyCustomMacros.cfg]
```

!!! note

    It does not need to be called `MyCustomMacros.cfg`, you can call it whatever you like, but it must end with `.cfg` and it must be saved directly in the config directory, **not** a sub-directory!

Your config file should implement as many of the above macros as you want to, you do **not** need to implement them all, so for example if you wanted to do something after G28 in START_PRINT, you file might look like:

```
[gcode_macro _SAF_START_PRINT_AFTER_G28]
gcode:
   RESPOND TYPE=command MSG='I am getting called after G28'
```

## Nozzle Wipe Support

Simple AF does not package any predefined nozzle wipers but we do provide a custom hook _SAF_NOZZLE_WIPE for that, and
the _SAF_NOZZLE_WIPE will be passed the `EXTRUDER_TEMP` parameter from START_PRINT to give you a bit more flexibility for
implementing your nozzle wiper macros.

!!! danger

    Do not use a nozzle wiper with a rear mounted probe, there is a strong likelihood of destroying the probe or damaging the printer

### Nozzle Wipe Options

The following are the nozzle wipe macros I am aware of, I provide absolutely no guarantees about them and as you will note all of them
require some tweaking before they will work with Simple AF!

#### Purcell Nozzle Wipe

You can find the advanced_nozzle_cleaner.cfg file at <https://www.printables.com/model/1023575-advanced-nozzle-wiper-for-creality-k1-series>,
and upload it to your config directory

Make sure its included **after** `[include start_end.cfg]` in `printer.cfg`

Then make a few changes to `advanced_nozzle_cleaner.cfg`:

!!! warning

    You must replace any `M106 P0` references with just `M106` as `P0` is not supported to reference the part fan.  In order to mitigate performance issues that were causing klipper
    to crash with a move queue overflow we had to migrate from `[fan_generic part]` to `[fan]` for the part fan.   M106 P argument still works for chamber and auxiliary like before.

You need to disable this:

```
#[gcode_macro CX_NOZZLE_CLEAR]
#rename_existing: _CX_NOZZLE_CLEAR
#gcode:
#  WIPE_NOZZLE
```

Add this:

```
[gcode_macro _SAF_NOZZLE_WIPE]
gcode:
WIPE_NOZZLE
```

#### Calin Nozzle Wipe

For Calin solution its all on the website:
<https://makerworld.com/en/models/1547901-creality-k1-max-silicone-nozzle-wiper>

!!! warning

    The `SET_FAN_SPEED FAN=part SPEED=0` will fail, you should replace this with `M107`.  In order to mitigate performance issues that were causing klipper
    to crash with a move queue overflow we had to migrate from `[fan_generic part]` to `[fan]` for the part fan.   SET_FAN_SPEED still works for auxiliary and
    chamber fans just not for part!

## Knomi Support 

A prime use case for this would be knomi support, which currently might look like this:

```
[gcode_macro _KNOMI_STATUS]
variable_homing: False
variable_probing: False
variable_qgling: False
variable_heating_nozzle: False
variable_heating_bed: False
gcode:


[gcode_macro _SAF_HEATING_NOZZLE_START]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_nozzle VALUE=True


[gcode_macro _SAF_HEATING_NOZZLE_END]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_nozzle VALUE=False


[gcode_macro _SAF_HEATING_BED_START]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_bed VALUE=True


[gcode_macro _SAF_HEATING_BED_END]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_bed VALUE=False


[gcode_macro _SAF_BED_MESH_START]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=probing VALUE=True


[gcode_macro _SAF_BED_MESH_END]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=probing VALUE=False


[gcode_macro _SAF_HOMING_START]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=homing VALUE=True


[gcode_macro _SAF_HOMING_END]
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=homing VALUE=False
```
