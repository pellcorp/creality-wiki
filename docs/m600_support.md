# M600 Manual Filament Change

Simple AF has support for manual filament changes using M600, instead of using PAUSE in Orca Slicer, specify M600

So in Orca Slicer once you have sliced the model, switch the preview pane and choose the layer that you want to
add the filament change to, it should be the layer **before** you want to switch colours, and right click and
choose Add Custom Gcode:

![image](assets/images/orcaslicer_custom_gcode.png)

Add `M600` to this dialog and click OK:
![image](assets/images/custom_gcode_m600.png)

And then reslice the file and then you can send it to print!

## Custom Hooks

If the default load, unload and purge more support is not suitable for you, you can implement custom hooks to create
your own macros.

The custom hooks are:

- `_SAF_FC_LOAD_FILAMENT`
- `_SAF_FC_UNLOAD_FILAMENT`
- `__SAF_FC_PURGE_MORE`

## Legacy Support

To use the macros that Simple AF used to have, you can do that with custom hooks:

```
[gcode_macro _SAF_FC_UNLOAD_FILAMENT]
gcode:
    M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
    RESPOND TYPE=command MSG="Unloading filament..."

    M104 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int - 30}     # Start cooling (don't wait)

    SAVE_GCODE_STATE NAME=_client_movement
    M83
    G4 P5000                       # Wait for initial cooldown
    G1 E30 F180                    # initially purge larger due to nozzle length
    G1 E-12 F600                   # Medium retract -12
    G4 P1000                       # Wait
    G1 E4 F120                     # Small extrude -8
    G1 E-18 F1400                  # Fast retract -26
    G4 P500                        # Wait
    G1 E2 F90                      # Tiny extrude -24
    G1 E-24 F2200                  # Very fast retract -48
    G1 E-50 F2800                  # Final snap retract -98
    RESTORE_GCODE_STATE NAME=_client_movement

    M400

    # turn off extruder to help it avoid overheating
    SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
    BEEP
    # we lowered by -30° before. restore already here to avoid heating at _LOAD_FILAMENT later
    M104 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}

[gcode_macro _SAF_FC_LOAD_FILAMENT]
gcode:
  M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
  RESPOND TYPE=command MSG="Loading filament..."

  _CLIENT_LINEAR_MOVE E=100 F=180
  _CLIENT_RETRACT
  M400

  # turn off extruder to help it avoid overheating
  SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
  BEEP

[gcode_macro _SAF_FC_PURGE_MORE]
gcode:
  M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
  RESPOND TYPE=command MSG="Purging filament..."

  _CLIENT_LINEAR_MOVE E=10 F=180
  _CLIENT_RETRACT
  M400

  # turn off extruder to help it avoid overheating
  SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
  BEEP
```
