# Load Cells

This page covers installing SimpleAF using the strain gauges (load cells) already built into the bed of your printer as the probe. There is no extra probe hardware to buy or mount, the nozzle taps the bed and the bed load cells detect the contact.

!!! danger

    Load cell probing is **EXTREMELY EXPERIMENTAL**. The nozzle is pushed onto the bed with a force measured by the load cells, if the load cells are not calibrated properly or something else goes wrong you can damage your printer. Be ready to hit the e-stop button in your UI or Grumpyscreen, or the power button, and never leave your printer unattended while homing, probing or bed meshing.

!!! warning "Kalico only"

    Load cell probing **REQUIRES [Kalico](kalico.md)**. It does **NOT** work with Klipper. The installer will refuse to install loadcells unless you pass the `--kalico` argument.

New here? See [Getting Started](getting-started.md).

## Supported Printers

| Printer | Status |
| --- | --- |
| Ender 3 V3 | Tested |
| K1 | Configured | Tested |
| K1C | Configured, **not tested** |
| K1 SE | Configured, **not tested** |
| K1 Max | Configured, **not tested** |

Any other printer is not supported, this includes the Ender 3 V3 KE, Ender 5 Max, CR10SE, Nebula Pad.

The Ender 3 V3 keeps using its physical endstop for homing Z, the load cells are used for probing and bed meshing.

!!! note

    The load cell probe reads all four bed load cells together as a single probe, this needs new MCU firmware which the installer takes care of.

## Overview

1. [Install](#installation) with the `loadcells` probe and `--kalico`
2. Power cycle the printer so the new [MCU firmware](#post-installation) is applied
3. [Calibrate the load cells](#calibration) with a known weight
4. [Test the probe](#test-the-probe) and check its [accuracy](#probe-accuracy)
5. Run a [bed mesh](#bed-mesh)
6. Do [PID tuning and input shaping](#pid-tuning-and-input-shaping)

## Installation

!!! warning

    The installation can only be performed on a printer which has been rooted and ssh granted, and you need root access, if you are not already root, then follow the [Enable Root Access](enable-root-access.md) instructions.

If you've installed Guilouz's Helper Script, or installed Fluidd or Mainsail through any other means (such as from Creality directly), you need to [factory reset](factory_reset.md) before continuing.

### Clone the Repo

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
```

!!! note

    If you had already cloned the pellcorp creality repository before being asked to factory reset, the git repo is still there and you can skip the cloning step!

### Run the installer

The `--kalico` argument is required, the installer will refuse to install loadcells without it.

```
/usr/data/pellcorp/installer.sh --install loadcells --mount Default --kalico
```

### Mount Options

#### Default

There is nothing to mount, this is the only option and it is used for all supported printers.

## Post Installation

### MCU Firmware updates are pending

At the end of the installer process if you get this message:

```
WARNING: MCU Firmware updates are pending you need to power cycle your printer!
```

It means that new MCU firmware updates need to be applied and this can only be done by power cycling the printer.  After your printer is power cycled you can verify firmware was updated with the `CHECK_FIRMWARE` macro from Fluidd or Mainsail, if you see this message:

```
INFO: Your MCU Firmware is up to date!
```

Your printer MCU firmware was updated successfully.   If you still see the `MCU Firmware updates are pending you need to power cycle your printer!` message after a power cycle, check the `/tmp/mcu_update.log`, you may be asked to provide this file on Discord if you need additional assistance, sometimes an additional power cycle can solve the problem, there is a very short window of time (15 seconds) in which the MCU firmware can be updated, so  there is a chance it will work after an additional power cycle.

## Calibration

!!! warning

    The load cells **must** be calibrated before you can probe with them, until you do the printer will stop with `Load Cell Probe Error: Load Cell not calibrated`. Never guess the calibration value, the safety limits are all in grams and an inaccurate calibration lets the nozzle push far harder than you intend.

### Check the Load Cells

Make sure the bed is empty and run `LOAD_CELL_DIAGNOSTIC`, it collects samples for 10 seconds, press on the bed while it runs.

- `Saturated samples` should be 0
- `Unique values` should be a large part of the samples collected, if it is 1 there is a wiring or configuration problem
- `Sample range` should increase when you press on the bed

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#diagnostics>

### Calibrate the Load Cells

You need an object of known weight, weigh it on a kitchen scale.

!!! tip

    On the Ender 3 V3 a known weight of ~3 kg (around `3000` grams) was needed during testing, a lighter weight fails with the `Tare and Calibration readings are less than 1% different!` error, see [Calibration Errors](#calibration-errors).

    New spools of filament work well, a brand new spool is typically 1000 g of filament plus the spool itself, which is about 250 g for a bamboo plastic spool or about 175 g for a cardboard spool.  Weigh whatever you use on a kitchen scale and enter the real weight.

--steps--

1. Remove everything from the bed
2. Run `LOAD_CELL_CALIBRATE`
3. Run `TARE`
4. Place your object of known weight in the centre of the bed
5. Run `CALIBRATE GRAMS=<weight in grams>` for example `CALIBRATE GRAMS=3000`
6. Run `ACCEPT`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

You can use `ABORT` to cancel at any time.  Afterwards run `LOAD_CELL_DIAGNOSTIC` again and it will report in grams, and `LOAD_CELL_READ` will show the force on the bed.

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#calibration>

### Calibration Errors

| Error | Cause | Fix |
| --- | --- | --- |
| `Tare and Calibration readings are less than 1% different!` | The weight is too light, the reading has to change by at least 1% of the sensor range | Use more weight, on the Ender 3 V3 about 3 kg (`3000` grams) is needed and 2598 grams was not enough.  The message suggests a higher gain, but `gain` is already at its highest setting (`A-128`), so more weight is the only fix |
| `Sensor is saturated with too much load!` | The weight is too heavy | Use less weight |
| `Tare and Calibration readings are the same!` | The reading did not change | Check the weight is actually on the bed and run `LOAD_CELL_DIAGNOSTIC` to check the sensor |

The calibration is still active after one of these errors, so you can change the weight and run `CALIBRATE GRAMS=<weight in grams>` again.

### Test the Probe

Run `LOAD_CELL_TEST_TAP`, then gently tap the nozzle or press on the bed 3 times, it will report each tap as it is detected.  If no tap is detected within 30 seconds it fails.

!!! note

    Load cell probes always report not triggered for `QUERY_ENDSTOPS` and `QUERY_PROBE`, use `LOAD_CELL_TEST_TAP` instead.

### Probe Accuracy

Make sure the nozzle is clean and there is no filament oozing from it, and if you are heating the nozzle keep it around 140°C, ooze on the nozzle is the biggest source of bad taps.

--steps--

1. Home All (`G28`)
2. Make sure the nozzle is centred on the bed
3. Run `PROBE_ACCURACY`

--!steps--

### Z Offset

The nozzle itself touches the bed, so there is no probe offset to measure and `z_offset` starts at `0`, the installer sets this for you.

If your first layer is too high or too low you can:

- Try running `PROBE_CALIBRATE`, upon completion *`SAVE_CONFIG`*
- Change `z_offset` by a small amount, for example `0.01`

Baby stepping while printing is more reliable, so it is the best way to fine tune your first layer.

### Bed Mesh

--steps--

1. Home All (`G28`)
2. Make sure the nozzle is clean
3. Run `BED_MESH_CALIBRATE`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

Watch the first bed mesh, the nozzle taps the bed at each point.

### Screws Tilt and Axis Twist

These are not available on the Ender 3 V3.  On the K1 and K1 Max the configuration is included but the positions have not been confirmed, check them before you use `SCREWS_TILT_CALCULATE` or `AXIS_TWIST_COMPENSATION_CALIBRATE`.

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print before any calibration you will most likely have poor quality.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

#### Pid Tuning

**Source:** [Calibrate Pid Settings](https://www.klipper3d.org/Config_checks.html?h=pid#calibrate-pid-settings)

For example you might run these:

```
PID_CALIBRATE_BED BED_TEMP=65
PID_CALIBRATE_HOTEND HOTEND_TEMP=230
```

!!! note

    The `PID_CALIBRATE_BED` and `PID_CALIBRATE_HOTEND` macros are located in the `useful_macros.cfg` file and they have defaults values for BED_TEMP and HOTEND_TEMP so you can just run them by clicking on them if you want that same temperature.

#### Input Shaping

There is no default configuration for input shaping so it is essentially disabled out of the box.

You can use the `SHAPER_CALIBRATE` macro to run input shaping, just be sure to `SAVE CONFIG` at the end, to choose the automatically selected shaper config, be aware though that the shaper chosen might be sub-optimal due to a slight difference in vibrations between two options.  So you should probably review the output and potentially choose an alternative if it gives you higher recommended max acceleration for minimal increase in vibration.

[Input Shaper Auto Calibration](https://www.klipper3d.org/Measuring_Resonances.html#input-shaper-auto-calibration)

## Tuning

The load cell probe settings are in the `[load_cell_probe]` section of `loadcells.cfg`, which you can edit from the config editor in Fluidd or Mainsail.

### Tap Failures

If you see tap validation errors in the console like `TAP_PULLBACK_TOO_SHORT` or `TAP_BREAK_CONTACT_TOO_LATE` the pullback move is too short, increase `pullback_distance` in the `[load_cell_probe]` section.  The default is `0.2`, on the Ender 3 V3 setting it to `0.5` fixed frequent `TAP_PULLBACK_TOO_SHORT` failures.

```
[load_cell_probe]
pullback_distance: 0.5
```

If the errors are `TAP_BREAK_CONTACT_TOO_EARLY` it is too long.

### Trigger Force

`trigger_force` is the force in grams that triggers the probe, it is set by the mount, `75` for the Ender 3 V3 and `150` for the K1 and K1 Max.  Probing always overshoots this, so raise it in small steps only if you need to.

### Safety Limits

- `force_safety_limit` (default `2000` grams) is the most force allowed on the bed before a probe move starts.  If it is exceeded you get `force of 3000g exceeds force_safety_limit (2000g) before probing!`, this can be caused by the nozzle already resting on the bed or something pushing on the bed.
- `drift_safety_limit` (default `1000` grams) is the most force allowed while probing before it triggers.  If it is exceeded you get `force exceeded drift_safety_limit before triggering!`.

## Known Issues

- Only the Ender 3 V3 has been tested, the K1 and K1 Max configuration is based on the stock printer configuration and has not been run on a real printer.

## Switching Back

To go back to a different probe see [Switching Probes](switching_probes.md).

!!! warning

    Do not switch to Klipper while `loadcells` is still your probe, Klipper does not support the load cell probe and will not start correctly.  Switch to a different probe first, and then if you want to go back to Klipper run:

    ```
    ~/pellcorp/installer.sh --klipper
    ```

## Where can I get help?

For support, join the [SimpleAF Discord](https://discord.gg/M5rmBQqRSG).
