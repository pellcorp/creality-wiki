# RPI Base Printer Definitions

If you are not using a predefined printer definition you will need to craft or download a basic printer config

## What should be in this file?

This definition should **not** include any kind of probe configuration **in the main printer.cfg section**, this should just have the basics (the installer will automatically remove some problematic definitions):

- extruder
- heater_bed
- heater_fan
- stepper_x
- stepper_y
- stepper_z (or multiple stepper_z for multi-z)
- the `[printer]` section
- fan
- fan_generic
- filament_switch_sensor

## K1, K1M, Ender 5 Max and Ender 3 V3 KE Definitions

If you have updating the mainboard in one of these printers and want to be able to play with different mounts, you need to let the installer
know it's for a specific model of printer with a `# MODEL:` header at the beginning of the file, currently supported models are:

- `k1` (K1, K1C, K1SE)
- `k1m` (K1 Max)
- `f004` (Ender 5 Max)
- `f005` (Ender 3 V3 KE)
- `ender3v3se` (Ender 3 V3 SE)

So just stick it into the header of the file like this:

```
# MODEL: k1
```

If you want to support Klicky, Microprobe and Bltouch in your base printer.cfg you will need to do a bit more work, specifically
you need to prefix your main printer.cfg definitions with `-- printer.cfg` and then provide additional sections for each of klicky.cfg, microprobe.cfg and bltouch.cfg, like this:

```
-- bltouch.cfg
[bltouch]
sensor_pin: ^PC14
control_pin: PC13

-- microprobe.cfg
[probe]
pin: ^!PC14

[output_pin probe_enable]
pin: PC13

-- klicky.cfg
[probe]
pin: ^!PC14
```

Where of course the pins will be relative to the mainboard you are using
