# Load Cells

This page covers installing SimpleAF using the strain gauges (load cells) already built into the bed of your printer as the probe. There is no extra probe hardware to buy or mount, the nozzle taps the bed and the bed load cells detect the contact.

Looking for Load Cells for Z-Offset? See [Load Cells for Z-Offset](loadcells_zoffset.md).

!!! klipper-error "High risk of bed damage"

    The nozzle is pushed onto the bed with a force measured by the load cells, if the load cells are not calibrated properly or something else goes wrong you can damage your printer. Be ready to hit the e-stop button in your UI or Grumpyscreen, or the power button, and never leave your printer unattended while homing, probing or bed meshing.

New here? See [Getting Started](getting-started.md).

## Nozzle Wipe

For the [loadcells](loadcells.md) probe and [loadcells for z-offset](loadcells_zoffset.md) Simple AF installs its own nozzle wipe, `loadcells_wipe.cfg`,
based on Creality's stock nozzle wipe.  Before the bed mesh, START_PRINT taps the bed to find its height, then scrapes the nozzle along a short
line on the bed so plastic on the tip doesn't throw off the load cell taps.

!!! note "K1C / K1SE Brush"

    On K1C and K1SE printers, Simple AF will configure the default nozzle wipe to assume a brush is mounted to the back of the build plate. If you are using an
    aftermarket build plate on a K1C or K1SE that does not have this brush, you should disable the brush by setting `variable_k1c_brush` to `False` in
    the `[gcode_macro _LOAD_CELL_WIPE_VARIABLES]` in the loadcells_wipe.cfg and Save and Restart.  By the same token if you are not on a K1C or K1SE,
    but are using a K1C / K1SE build plate with a brush, you should set the `variable_k1c_brush` to `True`.

!!! danger "Brush collision risk"

     If you have a non K1C / K1SE build plate with a silicon brush for wiping on your print bed you should remove the Simple AF default wiper by removing the
     `[include loadcells_wipe.cfg]` from your `printer.cfg`, and manually clean your nozzle or use a [third party nozzle wiper](#third-party-nozzle-wipes) until
     such time as we can fix our built in wiper to deal with silicon brushes. 

!!! note

    If you already are using your own nozzle wipe solution note that it will be used when you switch to loadcells because your existing include
    will be restored, please be aware of this as it might come as a surprise!

## Supported Printers

| Printer     | Status                     |
|-------------|----------------------------|
| Ender 3 V3  | Tested                     |
| K1          | Tested                     |
| K1C         | Configured, **not tested** |
| K1 SE       | Configured, **not tested** |
| K1 Max      | Tested                     |
| Ender 5 Max | Tested                     |

Any other printer is not supported, this includes the Ender 3 V3 KE, Ender 5 Max, CR10SE, Nebula Pad.

The Ender 3 V3 keeps using its physical endstop for homing Z, the load cells are used for probing and bed meshing.

!!! note

    The load cell probe reads all four bed load cells together as a single probe, this needs new MCU firmware which the installer takes care of.

## Overview

1. [Install](#installation) with the `loadcells` probe
2. Power cycle the printer so the new [MCU firmware](#post-installation) is applied
3. [Calibrate the load cells](#calibration) with a known weight
4. [Test the probe](#test-the-probe) and check its [accuracy](#probe-accuracy)
5. Run a [bed mesh](#bed-mesh)
6. Do [PID tuning and input shaping](#pid-tuning-and-input-shaping)
7. The [Nozzle Wipe](#nozzle-wipe) is set up for you

!!! warning

    The load cells **must** be calibrated before you can probe with them, until you do the printer will stop with `Load Cells are not calibrated, aborting homing Z!`. Never guess the calibration value, the safety limits are all in grams and an inaccurate calibration lets the nozzle push far harder than you intend.

## Installation

!!! warning

    The installation can only be performed on a printer which has been rooted and ssh granted, and you need root access, if you are not already root, then follow the [Enable Root Access](enable-root-access.md) instructions.

If you've installed Guilouz's Helper Script, or installed Fluidd or Mainsail through any other means (such as from Creality directly), you need to [factory reset](factory_reset.md) before continuing.

--8<-- "snippets/probe/clone_the_repo.md"

### Run the installer

```
/usr/data/pellcorp/installer.sh --install loadcells
```

## Post Installation

--8<-- "snippets/probe/mcu_firmware_updates_are_pending.md"

## Calibration

--8<-- "snippets/loadcells/check_the_load_cells.md"

### Calibrate the Load Cells

You need an object of known weight, weigh it on a kitchen scale.

!!! tip

    On the Ender 3 V3 a known weight of ~3 kg (around `3000` grams) was needed during testing, 

    On the K1 a known weight of ~6 kg (around `6000` grams) was needed during testing,

    a lighter weight fails with the `Tare and Calibration readings are less than 1% different!` error, see [Calibration Errors](#calibration-errors).

    New spools of filament work well, a brand new spool is typically 1000 g of filament plus the spool itself, which is about 250 g for a bamboo plastic spool or about 175 g for a cardboard spool.  Weight whatever you use on a kitchen scale and enter the real weight.

--steps--

1. Remove everything from the bed
2. Run `LOAD_CELL_CALIBRATE`
3. Run `TARE`
4. Place your object of known weight in the centre of the bed
5. Run `CALIBRATE GRAMS=<weight in grams>` for example `CALIBRATE GRAMS=3000`
6. Run `ACCEPT`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

You can use `ABORT` to cancel at any time.  Afterwards run `LOAD_CELL_DIAGNOSTIC` again, and `LOAD_CELL_READ` will it will report the force on the bed in grams.

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#calibration>

--8<-- "snippets/loadcells/calibration_errors.md"

--8<-- "snippets/loadcells/test_the_probe.md"

### Probe Accuracy

Make sure the nozzle is clean and there is no filament oozing from it, and if you are heating the nozzle keep it around 140°C, ooze on the nozzle is the biggest source of bad taps.

--steps--

1. Home All (`G28`)
2. Make sure the nozzle is centred on the bed
3. Run `PROBE_ACCURACY`

--!steps--

### Bed Mesh

--steps--

1. Home All (`G28`)
2. Make sure the nozzle is clean
3. Run `BED_MESH_CALIBRATE`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

Watch the first bed mesh, the nozzle taps the bed at each point.

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print before any calibration you will most likely have poor quality.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

## Tuning

The load cell probe settings are in the `[load_cell_probe]` section of `loadcells.cfg`, which you can edit from the config editor in Fluidd or Mainsail.

--8<-- "snippets/loadcells/tap_failures.md"

--8<-- "snippets/loadcells/trigger_force.md"

--8<-- "snippets/loadcells/safety_limits.md"

## Switching Back

To go back to a different probe see [Switching Probes](switching_probes.md).

!!! warning

    Do not switch to Klipper while `loadcells` is still your probe, Klipper does not support the load cell probe and will not start correctly.  Switch to a different probe first, and then if you want to go back to Klipper run:

    ```
    ~/pellcorp/installer.sh --klipper
    ```

--8<-- "snippets/loadcells/first_print.md"

--8<-- "snippets/probe/other_calibrations.md"

--8<-- "snippets/probe/where_can_i_get_help.md"
