# Load Cells for Z-Offset

This page covers using load cells for auto z-offset alongside another supported probe

!!! klipper-error "Risk of bed damage"

    The nozzle is pushed onto the bed with a force measured by the load cells, if the load cells are not calibrated properly or something else goes wrong you can damage your printer. Be ready to hit the e-stop button in your UI or Grumpyscreen, or the power button, and never leave your printer unattended while starting a print.

## Nozzle Wipe

By default, when installing or updating to use loadcells for z-offset, we enable a default [Nozzle Wipe Macro](nozzle_wipe.md) that will wipe on the back of
the printer bed for printers with 4 load cells and a front or side mounted primary probe, or on the side for single load cell printers or where your
primary probe is mounted on the back.   If you want to use your own nozzle wipe solution, you just need to remove the `[include loadcells_wipe.cfg]` and add your own `_SAF_NOZZLE_WIPE` implementation.

!!! danger "Rear and Side Mounted Primary Probe"

    The built in _SAF_NOZZLE_WIPE shipped with Simple AF for loadcells for z-offset will wipe on the back of the printer for a side mounted
    probe, please be mindful of this and ensure that a side mounted probe can still clear the left stepper motor and rear lead screw.

    A rear mounted probe will cause the wiper to wipe on the front left of the build plate.

!!! note "K1C / K1SE Brush"

    On K1C and K1SE printers, Simple AF will configure the default nozzle wipe to assume a brush is mounted to the back of the build plate. If you are using an
    aftermarket build plate on a K1C or K1SE that does not have this brush, you should disable the brush by setting `variable_k1c_brush` to `False` in
    the `[gcode_macro _LOAD_CELL_WIPE_VARIABLES]` in the `loadcells_wipe.cfg` and Save and Restart.  By the same token if you are not on a K1C or K1SE,
    but are using a K1C / K1SE build plate with a brush, you should set the `variable_k1c_brush` to `True`.

!!! danger "Brush collision risk"

     If you have a non K1C / K1SE build plate with a silicon brush for wiping on your print bed you should remove the Simple AF default wiper by removing the
     `[include loadcells_wipe.cfg]` from your `printer.cfg`, and manually clean your nozzle or use a [third party nozzle wiper](#third-party-nozzle-wipes). 

!!! note

    If you already are using your own nozzle wipe solution, the installer will not add the default nozzle wipe so you can continue to use your own!

## Supported Printers

- Ender 3 V3
- Ender 3 V3 KE
- Ender 3 V3 SE
- K1
- K1C
- K1 SE
- K1 Max
- Ender 5 Max

!!! note

    For K1, K1C, K1 Max, K1 SE, Ender 3 V3 CoreXZ and Ender 5 Max the load cell probe reads all four bed load cells together as a single probe, this needs new MCU firmware which the installer takes care of.

## Overview

1. Enable loadcells zoffset support
2. [Calibrate the load cells](#calibration) with a known weight
3. [Test the probe](#test-the-probe) and check its [accuracy](#probe-accuracy)
4. The [Nozzle Wipe](#nozzle-wipe) is set up for you

## Setup

To enable loadcells for z-offset it is a single command for an existing probe:

```
~/pellcorp/installer.sh --loadcells-zoffset
```

To enable loadcells for zoffset while installing or reinstalling, for this example we are setting up a cartographer:

```
~/pellcorp/installer.sh --install --probe cartographer --mount Default --loadcells-zoffset
```

!!! warning

    The load cells **must** be calibrated before you can probe with them, until you do the printer will stop with `Load Cells are not calibrated, aborting homing Z!`. Never guess the calibration value, the safety limits are all in grams and an inaccurate calibration lets the nozzle push far harder than you intend.

You must [Calibrate the load cells](#calibration) before trying to home your printer!

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
4. Place your object of known weight in the centre of the bed (or over the load cell at the front left for an Ender 3 V3 SE / KE)
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
2. Run `LOAD_CELL_PROBE_ACCURACY`

--!steps--

## Tuning

The load cell probe settings are in the `[load_cell_probe]` section of `loadcells_zoffset.cfg`, which you can edit from the config editor in Fluidd or Mainsail.

--8<-- "snippets/loadcells/tap_failures.md"

--8<-- "snippets/loadcells/trigger_force.md"

--8<-- "snippets/loadcells/safety_limits.md"


--8<-- "snippets/loadcells/first_print.md"
