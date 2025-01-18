Within Simple AF if you want to call a custom gcode macro you can with hooks, the following custom gcode macro hooks are supported and more can be added as needed:

- **_SAF_HOMING_START** - at start of homing
- **_SAF_HOMING_END** - at end of homing
- **_SAF_START_PRINT_AFTER_G28** - After G28 is called in START_PRINT
- **_SAF_BED_MESH_START** - Start of bed mesh calibrate
- **_SAF_BED_MESH_END** - End of bed mesh calibrate
- **_SAF_ON_FILAMENT_RUNOUT** - When filament runout is triggered

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


[gcode_macro M109]
rename_existing: M109.1
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_nozzle VALUE=True
  M109.1 {rawparams}
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_nozzle VALUE=False


[gcode_macro M190]
rename_existing: M190.1
gcode:
  SET_GCODE_VARIABLE MACRO=_KNOMI_STATUS VARIABLE=heating_bed VALUE=True
  M190.1 {rawparams}
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
