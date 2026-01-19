# Frequently Asked Questions

## Why is the P argument ignored in the M106 command?

Simple AF implemented support for the P argument into the python code in our klipper and klipper-rpi fork to mitigate performance issues.  

Unfortunately until recently the installer for Simple AF for RPi was not ensuring that the p_selector_map was being set on the `[fan]` config
in order to eanble this feature.   We have recently updated the installer to ensure the p_selector_map gets added to the fan definition.

So if your M106 P1/M106 P2/M106 P3 commands are not working as expected, please ensure you have updated to latest Simple AF!

!!! warning

    You must replace any `M106 P0` references with just `M106` as `P0` is not supported to reference the part fan.  In order to mitigate performance issues that were causing klipper
    to crash with a move queue overflow we had to migrate from `[fan_generic part]` to `[fan]` for the part fan.

