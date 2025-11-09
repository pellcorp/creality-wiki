# Nozzle Wipe Support

!!! danger

    It can be dangerous to use a rear mounted nozzle wiper with a rear mounted probe, there is a strong likelihood of destroying the probe or damaging the printer!

Simple AF does not package any predefined nozzle wipers but we do provide a [_SAF_NOZZLE_WIPE](custom_hooks.md) custom hook for that, and
the `_SAF_NOZZLE_WIPE` will be passed the `EXTRUDER_TEMP` parameter from START_PRINT to give you a bit more flexibility for implementing your nozzle wiper macros.

So for instance you could use the `EXTRUDER_TEMP` in the `_SAF_NOZZLE_WIPE` macro like this:

```
[gcode_macro _SAF_NOZZLE_WIPE]
gcode:
    {% set EXTRUDER_TEMP=params.EXTRUDER_TEMP|float %}
    
    # lower the temp to something where nozzle does not ooze to do your thing
    M109 S150
    
    # then set the nozzle temp
    M104 S{EXTRUDER_TEMP}
```

This might be useful for instance if you need to adjust the nozzle temp as part of your macro but then set it to the target temp, although
in that case it actually would probably be better to get the existing target temp at the start of your `_SAF_NOZZLE_WIPE` in a different way:

```
[gcode_macro _SAF_NOZZLE_WIPE]
gcode:
    {% set target_nozzle_temp = printer[printer.toolhead.extruder].target %}
    
    # lower the temp to something where nozzle does not ooze to do your thing
    M109 S150
    
    # then restore the previous nozzle temp
    M104 S{target_nozzle_temp}
```

## Nozzle Wipe Options

The following are the nozzle wipe macros I am aware of, I provide absolutely no guarantees about them!

### Purcell Nozzle Wipe

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

### Calin Nozzle Wipe

For Calin solution it's all on the website:
<https://makerworld.com/en/models/1547901-creality-k1-max-silicone-nozzle-wiper>

Calin has updated the docs for their macro to correctly use M106 macro so no changes should be required beyond what is documented on that makerworld site.