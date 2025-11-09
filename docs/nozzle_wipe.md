# Nozzle Wipe Support

Simple AF does not package any predefined nozzle wipers but we do provide a [_SAF_NOZZLE_WIPE](custom_hooks.md) custom hook for that, and
the `_SAF_NOZZLE_WIPE` will be passed the `EXTRUDER_TEMP` parameter from START_PRINT to give you a bit more flexibility for implementing your nozzle wiper macros.

!!! danger

    Do not use a nozzle wiper with a rear mounted probe, there is a strong likelihood of destroying the probe or damaging the printer

## Nozzle Wipe Options

The following are the nozzle wipe macros I am aware of, I provide absolutely no guarantees about them and as you will note all of them
require some tweaking before they will work with Simple AF!

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

For Calin solution its all on the website:
<https://makerworld.com/en/models/1547901-creality-k1-max-silicone-nozzle-wiper>

!!! warning

    The `SET_FAN_SPEED FAN=part SPEED=0` will fail, you should replace this with `M107`.  In order to mitigate performance issues that were causing klipper
    to crash with a move queue overflow we had to migrate from `[fan_generic part]` to `[fan]` for the part fan.   SET_FAN_SPEED still works for auxiliary and
    chamber fans just not for part!
