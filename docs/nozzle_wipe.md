# Nozzle Wipe Support

The nozzle wipe custom hook is called before any bed mesh or z-offset nozzle touch is performed in START_PRINT.

## Load Cell Wipe

!!! danger "Brush collision risk"

     If you have a silicon brush for wiping on your print bed you should remove the Simple AF default wiper by removing the
     `[include loadcells_wipe.cfg]` from your `printer.cfg`, and manually clean your nozzle or use a [third party nozzle wiper](#third-party-nozzle-wipes) until
     such time as we can fix our built in wiper to deal with silicon brushes.

For the [loadcells](loadcells.md) probe and [loadcells for z-offset](loadcells_zoffset.md) Simple AF installs its own nozzle wipe, `loadcells_wipe.cfg`,
based on Creality's stock nozzle wipe.  Before the bed mesh, START_PRINT taps the bed to find its height, then scrapes the nozzle along a short
line on the bed so plastic on the tip doesn't throw off the load cell taps.

!!! warning

    The load cell wipe needs an up to date [Kalico](kalico.md), with an older Kalico the wipe is skipped with a message telling you to update.

### Where it wipes

| Setup                                                                         | Wipe                                                       |
|-------------------------------------------------------------------------------|------------------------------------------------------------|
| loadcells probe                                                               | back of the bed, middle third of X, 3 to 5mm in from Y max |
| loadcells for z-offset, front or side mounted probe                           | back of the bed                                            |
| loadcells for z-offset, single load cell (Ender 3 V3 SE and Ender 3 V3 KE)    | left side of the bed, one tap 20mm in from the front       |
| loadcells for z-offset, rear mounted probe                                    | left side of the bed                                       |

!!! klipper-error "Rear mounted probes always wipe on the side"

    With loadcells for z-offset and a **rear mounted probe** the wipe is always done on the left side of the bed, a rear wipe could drive the probe
    into the frame, **there is no option to wipe at the back**.

A single load cell sits under the front left of the bed and can't feel a tap much further than 30mm away, so it only taps the start of the line,
20mm in from the front, and uses that height for the whole wipe.

If your probe is mounted to the left of the nozzle the side wipe is moved right, so the probe never goes further left than the nozzle can (X min).

### Running it by hand

The temps default to PLA:

```
_SAF_NOZZLE_WIPE EXTRUDER_TEMP=210 BED_TEMP=60
```

To use your own `_SAF_NOZZLE_WIPE` instead, remove the `[include loadcells_wipe.cfg]` from `printer.cfg`.

## Third Party Nozzle Wipes

The following nozzle wipe solutions are third party and there **is absolutely no support available** for them via the Simple AF discord,
these are just the wipes I am aware of, myself and the support team don't know much about them.

!!! danger

    It can be dangerous to use a rear mounted nozzle wiper with a rear mounted probe, there is a strong likelihood of destroying the probe or damaging the printer!

Apart from the [Load Cell Wipe](#load-cell-wipe) Simple AF does not package any predefined nozzle wipers, but we do provide a [_SAF_NOZZLE_WIPE](custom_hooks.md) custom hook for you.

The `_SAF_NOZZLE_WIPE` will be passed the `EXTRUDER_TEMP` parameter from START_PRINT to give you a bit more flexibility for implementing your nozzle wiper macros.

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
    
    # Do the nozzle wipe thing here whatever it is
    
    # then restore the previous nozzle temp
    M109 S{target_nozzle_temp}
```

## Nozzle Wipe Options

The following are the nozzle wipe macros I am aware of, I provide absolutely no guarantees about them!

Config overrides should save and restore these additional .cfg for you automatically, just make sure its saved directly to the config/ directory
**and not a sub-directory** and you should be good to go!

### Purcell Nozzle Wipe

You can find the advanced_nozzle_cleaner.cfg file at <https://www.printables.com/model/1023575-advanced-nozzle-wiper-for-creality-k1-series>,
and upload it to your config directory.

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
    # make the nozzle wipe be a good citizen and restore the target temp afterwards
    {% set target_nozzle_temp = printer[printer.toolhead.extruder].target %}
    
    WIPE_NOZZLE
    
    # then restore the previous nozzle temp
    M109 S{target_nozzle_temp}
```

### Calin Nozzle Wipe

For Calin solution it's all on the website:
<https://makerworld.com/en/models/1547901-creality-k1-max-silicone-nozzle-wiper>

Calin has updated the docs for their macro to correctly use M106 macro so no changes should be required beyond what is documented on that makerworld site.

### Cart's K1/C Nozzle Wiper
For Cart's Solution, its all on their GitHub: <https://github.com/Cartrigger/cart-k1-wipe>

It should work out of the box with any K1 or K1C if they have a compatible bed.
