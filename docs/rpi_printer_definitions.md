# RPI Base Printer Definitions

If you are not using a predefined printer definition you will need to craft or download a basic printer config

## What should be in this file?

This definition should **not** include any kind of probe configuration **in the main printer.cfg section**, this should just have the basics:

- `mcu`
- `extruder`
- `heater_bed`
- `heater_fan`
- `stepper_x`
- `tmcXXXX stepper_x`
- `stepper_y`
- `tmcXXXX stepper_y`
- `stepper_z`
- `tmcXXXX stepper_z`
- `printer`
- `fan`
- `fan_generic`
- `filament_switch_sensor`
- `temperature_sensor`
- `duplicate_pin_override`
- `temperature_fan`
- `verify_heater`
- `output_pin`

### Optional

The following can be included:

- `input_shaper` (predefined / hard coded input shaper values)
- `adxl345`
- `lis2dw`
- `resonance_tester`
- `gcode_arcs`

### Illegal Sections

The installer will exit if it finds any `[include ]` or SAVE_CONFIG sections.

### Not required

The following sections are defined elsewhere in Simple AF and will automatically be removed from the printer definition before its used:

- `bltouch`
- `probe`
- `safe_z_home`
- `homing_override`
- `force_move`
- `pause_resume`
- `bed_mesh`
- `idle_timeout`
- `display_status`
- `virtual_sdcard`
- `exclude_object`
- `axis_twist_compensation`
- `screws_tilt_adjust`

## Support Probes and Mounts

If you are updating the mainboard on one of the printers that supports multiple probes and/or mounts, you should let the installer know what model of printer your config is for, this is done by specifying the model of printer with a `# MODEL:` header at the beginning of the file!

The supported models are:

- `k1` (K1, K1C, K1SE)
- `k1m` (K1 Max)
- `f004` (Ender 5 Max)
- `f005` (Ender 3 V3 KE)
- `e3v3se` (Ender 3 V3 SE)

So just stick it into the beginning of the file like this:

```
# MODEL:k1
```

!!! warning

    The MODEL is case sensitive, so K1 is **not** the same as k1!


If you want to support Klicky, Microprobe and Bltouch in your base printer.cfg you will need to do a bit more work, specifically you need to prefix your main printer.cfg definitions with `-- printer.cfg` and then provide additional sections for each of `klicky.cfg`, `microprobe.cfg` and `bltouch.cfg`, like this:

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

Check out <https://github.com/pellcorp/creality/blob/main/rpi/printers/creality-ender3-v3-se.cfg> for an example.
