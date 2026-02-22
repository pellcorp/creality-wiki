# M600 Manual Filament Change

Simple AF has support for manual filament changes.

In Orca Slicer once you have sliced the model, switch to the preview pane and choose the layer that you want to
add the filament change to, it should be the layer **before** you want to switch colours, then right click and
choose Add Custom G-code:

![image](assets/images/orcaslicer_custom_gcode.png)

Add `M600` to this dialog and click OK:

![image](assets/images/custom_gcode_m600.png)

And then reslice the file, then you can send it to print!

!!! note

    This functionality is very likely to conflict with the filament sensor `insert_gcode` to auto load filament if you have a CFS or DXC extruder, in that
    case you probably should use PAUSE instead of M600!   I would welcome PRs to Simple AF that allow auto load to work with the
    built in M600 support, one day I might even add it myself as I have a CFS extruder!

## Custom Hooks

If the default load, unload and purge more support is not suitable for you, you can implement custom hooks to create your own macros.

The custom hooks are:

- `_SAF_FC_LOAD_FILAMENT`
- `_SAF_FC_UNLOAD_FILAMENT`
- `_SAF_FC_PURGE_MORE`

## Legacy Support

To use the macros that Simple AF used to have, you can do that with custom hooks:

```
[gcode_macro _SAF_FC_UNLOAD_FILAMENT]
gcode:
    M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
    RESPOND TYPE=command MSG="Unloading filament..."

    # Turn on cooling fan to help with temperature drop
    #M106 S255
    M83

    #### K1* Unicorn Nozzle/Heatbreak/Extruder Geometry:
    ## pipe - heatbreak - pipe - nozzle
    ## 23.6 - 10.5      - 3    - 28.3 - total 65.4mm
    ### Positions:
    ## E-28.3 = unloaded from nozzle/heater
    ## E-36.55 = unloaded from nozzle/hb until middle of heatbreak
    ## E-42.3 = unloaded from nozzle and hb = between heatbreak and extruder drive gears, hand pullable with lever opened
    ## E-77.5 = unloaded from nozzle, hb and extruder = beyond extruder drive gears, hand pullable with lever closed

    #### CHCB-OTC on K1* Nozzle/Heatbreak/Extruder Geometry:
    ## pipe - heatbreak - pipe - nozzle
    ## (23.5 - 10.5      - 3    - 28.5 - total 65.5mm
    ### Positions:
    ## E-28.5 = unloaded from nozzle/heater
    ## E-36.75 = unloaded from nozzle/hb until middle of heatbreak
    ## E-42.5 = unloaded from nozzle and hb = between heatbreak and extruder drive gears, hand pullable with lever opened
    ## E-77.5 = unloaded from nozzle, hb and extruder = beyond extruder drive gears, hand pullable with lever closed

    M104 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int - 30}     # Start cooling (don't wait)
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
      
    M400

    #M106 P0 S0
    #M106 P2 S0

    # turn off extruder to help it avoid overheating
    SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
    BEEP
    # we lowered by -30° before. restore already here to avoid heating at _LOAD_FILAMENT later
    M104 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}

[gcode_macro _SAF_FC_LOAD_FILAMENT]
gcode:
  M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
  RESPOND TYPE=command MSG="Loading filament..."
  M83
  G1 E100 F180
  _CLIENT_RETRACT
  M400
  # turn off extruder to help it avoid overheating
  SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
  BEEP

[gcode_macro _SAF_FC_PURGE_MORE]
gcode:
  M109 S{printer['gcode_macro RESUME'].last_extruder_temp.temp|int}
  RESPOND TYPE=command MSG="Purging filament..."
  M83
  G1 E10 F180
  _CLIENT_RETRACT
  M400
  # turn off extruder to help it avoid overheating
  SET_STEPPER_ENABLE STEPPER=extruder ENABLE=0
  BEEP
```
