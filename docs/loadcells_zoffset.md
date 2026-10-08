# Load Cells for Z-Offset

This page covers using load cells for auto z-offset alongside another supported probe

!!! klipper-error "Experimental High risk of bed or toolhead damage"

    Load cells for z-offset is **EXTREMELY EXPERIMENTAL**. The nozzle is pushed onto the bed with a force measured by the load cells, if the load cells are not calibrated properly or something else goes wrong you can damage your printer. Be ready to hit the e-stop button in your UI or Grumpyscreen, or the power button, and never leave your printer unattended while starting a print.

!!! warning "Kalico only"

    Load cells for z-offset **REQUIRES [Kalico](kalico.md)**.  The installer will automatically setup kalico for a install or reinstall or if you enable loadcells for z-offset, either for an existing or new installation.

## Supported Printers

| Printer       | Status                     |
|---------------|----------------------------|
| Ender 3 V3    | Tested                     |
| Ender 3 V3 KE | Tested                     |
| Ender 3 V3 SE | Tested                     |
| K1            | Tested                     |
| K1C           | Tested                     |
| K1 SE         | Configured, **not tested** |
| K1 Max        | Configured, **not tested** |


!!! note

    For K1, K1C, K1 Max, K1 SE, Ender 3 V3 CoreXZ and Ender 5 Max the load cell probe reads all four bed load cells together as a single probe, this needs new MCU firmware which the installer takes care of.

## Overview

1. Enable loadcells zoffset support
2. [Calibrate the load cells](#calibration) with a known weight
3. [Test the probe](#test-the-probe) and check its [accuracy](#probe-accuracy)
4. Configure [Nozzle Wipe](nozzle_wipe.md) - currently this must be done manually, we are exploring integrating a default nozzle wipe for load cells soon.

## Setup

!!! warning

    There is an assumption you have already setup a supported probe with kalico

To enable loadcells for z-offset it is a single command for an existing probe:

```
~/pellcorp/installer.sh --loadcells-zoffset
```

To enable loadcells zoffset support will installing or reinstalling you would do, something like this, for this example we are setting up a cartographer, 
but this should work for any probe (except for `--probe loadcells` which is not allowed hopefully for obvious reasons)

```
~/pellcorp/installer.sh --install --probe cartographer --loadcells-zoffset --mount Default
```

You need to [Calibrate the load cells](#calibration) before trying to do a print

## Calibration

!!! warning

    The load cell(s) **must** be calibrated before you can use them for z-offset, until you do the printer will stop with `Load Cell Probe Error: Load Cell not calibrated`. Never guess the calibration value, the safety limits are all in grams and an inaccurate calibration lets the nozzle push far harder than you intend.

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
