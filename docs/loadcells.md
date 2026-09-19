# Load Cells

This page covers installing SimpleAF using the strain gauges (load cells) already built into the bed of your printer as the probe. There is no extra probe hardware to buy or mount, the nozzle taps the bed and the bed load cells detect the contact.

!!! danger

    Load cell probing is **EXTREMELY EXPERIMENTAL**. The nozzle is pushed onto the bed with a force measured by the load cells, if the load cells are not calibrated properly or something else goes wrong you can damage your printer. Be ready to hit the e-stop button in your UI or Grumpyscreen, or the power button, and never leave your printer unattended while homing, probing or bed meshing.

New here? See [Getting Started](getting-started.md).

## Supported Printers

Load cell probing requires [Kalico](kalico.md), it does not work with Klipper.

| Printer | Status |
| --- | --- |
| Ender 3 V3 | Tested |
| K1 | Configured, **not tested** |
| K1 Max | Configured, **not tested** |

Any other printer is not supported, this includes the Ender 3 V3 KE, Ender 5 Max, CR10SE, Nebula Pad and the K1C and K1 SE.

The Ender 3 V3 keeps using its physical endstop for homing Z, the load cells are used for probing and bed meshing.

!!! note

    The load cell probe reads all four bed load cells together as a single probe, this needs new MCU firmware which the installer takes care of.

## Switching Branches

The load cell support is not in the default branches yet, so you need to switch both the pellcorp/creality repo and the pellcorp/kalico repo to the load cell branches.

First get the installer onto the load cell branch:

```
~/pellcorp/installer.sh --branch <installer-branch>
```

Then after the installation below switch Kalico to the load cell branch:

```
~/pellcorp/installer.sh --klipper-branch <kalico-branch>
```

## Installation

!!! warning

    The installation can only be performed on a printer which has been rooted and ssh granted, and you need root access, if you are not already root, then follow the [Enable Root Access](enable-root-access.md) instructions.

If you've installed Guilouz's Helper Script, or installed Fluidd or Mainsail through any other means (such as from Creality directly), you need to [factory reset](factory_reset.md) before continuing.

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

    The load cells **must** be calibrated before you can home or probe with them, until you do the printer will stop with `Load Cell Probe Error: Load Cell not calibrated`. Never guess the calibration value, the safety limits are all in grams and an inaccurate calibration lets the nozzle push far harder than you intend.

### Check the Load Cells

Make sure the bed is empty and run `LOAD_CELL_DIAGNOSTIC`, it collects samples for 10 seconds, press on the bed while it runs.

- `Saturated samples` should be 0
- `Unique values` should be a large part of the samples collected, if it is 1 there is a wiring or configuration problem
- `Sample range` should increase when you press on the bed

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#diagnostics>

### Calibrate the Load Cells

You need an object of known weight, ideally 1 kg or more, weigh it on a kitchen scale.

--steps--

1. Remove everything from the bed
2. Run `LOAD_CELL_CALIBRATE`
3. Run `TARE`
4. Place your object of known weight in the centre of the bed
5. Run `CALIBRATE GRAMS=<weight in grams>` for example `CALIBRATE GRAMS=1000`
6. Run `ACCEPT`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

You can use `ABORT` to cancel at any time.  Afterwards run `LOAD_CELL_DIAGNOSTIC` again and it will report in grams, and `LOAD_CELL_READ` will show the force on the bed.

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#calibration>

### Test the Probe

Run `LOAD_CELL_TEST_TAP`, then gently tap the nozzle or press on the bed 3 times, it will report each tap as it is detected.  If no tap is detected within 30 seconds it fails.

!!! note

    Load cell probes always report not triggered for `QUERY_ENDSTOPS` and `QUERY_PROBE`, use `LOAD_CELL_TEST_TAP` instead.

### Probe Accuracy

Make sure the nozzle is clean and there is no filament oozing from it, and if you are heating the nozzle keep it around 140°C, ooze on the nozzle is the biggest source of bad taps.

--steps--

1. Home All (`G28`)
2. Run `PROBE_ACCURACY`

--!steps--

### Z Offset

The `z_offset` for a load cell probe is `0`, the nozzle itself is the probe, so there is nothing to calibrate.  You should optimise your first layer using baby stepping.

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

These are still required, see the Calibration section of any of the other probe pages, for example [Klicky](klicky.md#calibration).

## Tuning

The load cell probe settings are in `loadcells.cfg`, the full list of options is in the [Kalico Load Cell documentation](https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md).

### Tap Failures

If you see tap validation errors in the console like `TAP_PULLBACK_TOO_SHORT` or `TAP_BREAK_CONTACT_TOO_LATE` the pullback move is too short, increase `pullback_distance` in the `[load_cell_probe]` section.  The default is `0.2`, on the Ender 3 V3 setting it to `0.5` fixed frequent `TAP_PULLBACK_TOO_SHORT` failures.

```
[load_cell_probe]
pullback_distance: 0.5
```

If the errors are `TAP_BREAK_CONTACT_TOO_EARLY` it is too long.

### Trigger Force

`trigger_force` is the force in grams that triggers the probe, the default is `75`.  Probing always overshoots this, so raise it in small steps only if you need to.

## Known Issues

- Only the Ender 3 V3 has been tested, the K1 and K1 Max configuration is based on the stock printer configuration and has not been run on a real printer.
- The leveling MCU has been seen to shut down with `Timer too close` while printing on an Ender 3 V3.  This is still being investigated.

## Switching Back

To go back to a different probe see [Switching Probes](switching_probes.md), and to go back to Klipper run:

```
~/pellcorp/installer.sh --klipper
```

## Where can I get help?

For support, join the [SimpleAF Discord](https://discord.gg/M5rmBQqRSG).
