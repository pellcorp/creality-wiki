# Frequently Asked Questions

Why is the P argument ignored in the M106 command?

So Simple AF actually implemented support for the P argument into the python code in our klipper and klipper-rpi fork, we have recently updated
the installer to ensure the p_selector_map gets added to the fan definition with a default value, which is:

```angular2html
p_selector_map: chamber, auxiliary, chamber
```

Which means that `M106 P1 S255` and `M106 P3 S255` both turn the chamber fan on to max
And `M106 P2 S255` turns on the auxiliary to max, in my experience Orca Slicer uses both P1 and P3 or at least has in the past,
so that is why there is a mapping for both.

!!! warning

    You must replace any `M106 P0` references with just `M106` as `P0` is not supported to reference the part fan.  In order to mitigate performance issues that were causing klipper
    to crash with a move queue overflow we had to migrate from `[fan_generic part]` to `[fan]` for the part fan.
