# Frequently Asked Questions

## How do I use my beacon for input shaping?

!!! note

    These instructions do not apply to Simple AF for RPi, although it is certainly possible to use the 
    Cartographer as ADXL on non creality printers.

This just needs a few changes in `printer.cfg`

You need to **remove** the `[adxl345]` section

**Source:** <https://docs.beacon3d.com/config/#resonance_tester>

Change the `[resonance_tester]` `accel_chip` from `adxl345` to `beacon`

So your `[resonance_tester]` should look something like this:

```
[resonance_tester]
accel_chip: beacon
accel_per_hz: 75
probe_points:
   110,110,10
```
