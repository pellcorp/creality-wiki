# Frequently Asked Questions

## How do I use my beacon for input shaping?

!!! note

    For Simple AF for RPI series you might need to add a `[resonance_tester]` and `[adxl345]` section to
    get this working, because many base printers dont have any input shaper defined!

This just needs a few changes in `printer.cfg`

You can **remove** the `[adxl345]` section

Change the `[resonance_tester]` `accel_chip` from `adxl345` to `beacon`

So your `[resonance_tester]` should look something like this:

```
[resonance_tester]
accel_chip: beacon
accel_per_hz: 75
probe_points:
   110,110,10
```

**Source:** <https://docs.beacon3d.com/config/#resonance_tester>
