# Eddy NG

!!! klipper-error "Build Plate Damage Alert"

    Your build plate must be spring steel with a magnetic sheet attached to your underlying printer bed.  Do not try and use this probe with embedded magnets or 
    some crappy magnetic flex plate that is not spring steel, your nozzle will dig a big hole in it.

This page covers installing SimpleAF using a BTT Eddy probe with eddy-ng firmware. New here? See [Getting Started](getting-started.md).

RPi / SBC users: install SimpleAF via [SimpleAF for RPi](rpi.md). The rest of this page &mdash; probe firmware, mount options, and calibration &mdash; applies to your setup too.

## Firmware requirements

--8<-- "snippets/probe/limits_on_x_and_y_microsteps_32.md"

### K1 Series

This guide assumes you have a K1, K1C, K1SE or K1 Max and you are running stock creality firmware 1.3.3.5 or **higher** (The firmware 1.3.3.5 is much older than 1.3.3.46 for example), **or alternately** you can use [my prerooted firmware](prerooted_firmware.md).

### Ender 5 Max

This probe is currently not supported on Ender 5 Max

### Ender 3 V3 KE

This guide assumes you have a stock Ender 3 V3 KE with Nebula Pad with Root enabled, when you get to installation below, you should specify the `--mount Default` to install
Simple AF on the KE for Eddy-NG.

Please note that you will need to change the screen orientation to horizontal, here is a model for that <https://www.printables.com/model/727362-ender-3-v3-ke-screen-holder-landscape-for-guppyscr>,
but please do **not** follow the installation instructions on that page, just print the model and remount your screen only!
An alternative model which honestly seems a bit cleaner: <https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### Nebula Pad

This probe is currently not supported on Nebula Pad, but support can be added if there is interest.

### CR10SE

This probe is currently not supported on CR10SE, but support can be added if there is interest.

### RPi or SBC

See [Simple AF for RPi](rpi.md)

## BTT Eddy Firmware

!!! warning

    It is assumed that you have flashed your eddy with the firmware from <https://github.com/pellcorp/klipper/blob/master/fw/K1/btteddy.uf2> **before** starting the installation!!!
    
    For K1 Series Simple AF [there is a guide](btteddy_flashing.md)

    For Simple AF for RPi, you can follow this guide <https://github.com/bigtreetech/Eddy?tab=readme-ov-file#compiling-firmware>.   But make sure
    you are not trying to use any fork of klipper than pellcorp/klipper-rpi!  You can also skip this compilation step and just copy 
    the `~/klipper/fw/k1/btteddy.uf2` file to the Eddy after putting it into boot mode.

## Probe Installation

It is **strongly** recommended to connect your probe to the front USB port initially and use it for a while that way to make sure its stable, before
directly wiring it to either the mainboard or making a cable for the lidar port (K1M users only).   If possible avoid destroying the original cable when
you are making your lidar or direct mainboard connection as you might need it in the future!

!!! danger

    If you are not using a side mount you **must** verify config changes for eddyng.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount        | Printer             | URL                                                                                                                                                                     | Notes |
|--------------|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------|
| **Default**  | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/1012524-btteddy-creality-k1-k1c-k1-max-mount><br/><https://www.printables.com/model/1212731-btt-eddy_ng-mount-for-creality-k1-series> |       |
| **Pellcorp** | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/965667-wip-k1-btt-eddy-rear-mount-v4>                                                                                                 |       |
| **Slam**     | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/1195575-btt-eddy-mount-for-k1c>                                                                                                       |       |
| **Default**  | Ender 3 V3 SE       | <https://www.printables.com/model/1202031-ender-3-v3-se-k1-hotend-btt-eddy-mount>                                                                                       |       |
| **Default**   | Ender 3 KE         | <https://www.printables.com/model/1002777-cr-touch-to-btt-eddy-adapter-bracket>                                                                                         |       |

### Nozzle Offset

!!! warning

    The best success seems to be with the coil of a BTT Eddy mounted at about 2.95mm above the tip of the nozzle. This refers to the bottom of the coil PCB, not the bottom of the case.

    For more specific information about this, see <https://github.com/vvuk/eddy-ng/wiki/BTT-Eddy#probe-installation>
    You can try this tool <https://www.printables.com/model/1277844-btt-eddy-and-eddy-ng-setup-helpers>

## Installation

!!! warning

    The installation section does not apply to Simple AF for RPi, See [Simple AF for RPi](rpi.md)

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow the [Enable Root Access](enable-root-access.md) instructions.

--8<-- "snippets/probe/factory_reset.md"

--8<-- "snippets/probe/clone_the_repo.md"

### Run the installer

!!! note

    If you have pellcorp-overrides in github but not stored locally, [you need to recreate the ~/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

To run the script, you must specify the probe you want to use.

```
/usr/data/pellcorp/installer.sh --install eddyng --mount Mount
```

!!! danger "Install Kalico"

    Kalico is not currently supported for EddyNG 

!!! warning

    Replace `Mount` with the specific mount option for the mount you have used, if you do not do this the printer will be incorrectly configured for your mount, and bed meshes, x and y limits and related config will be wrong.   Please refer to [Mount Options](#mount-options) for supported mounts.   

    If you are using a non-supported mount you should specify a mount option as close to your mount as possible and properly adjust your configuration after installation before trying to perform a bed mesh or Screws Tilt Calculate!

## Post Installation

--8<-- "snippets/probe/mcu_firmware_updates_are_pending.md"

--8<-- "snippets/probe/slicer_settings.md"

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Probe Eddy NG Setup](#probe-eddy-ng-setup)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

### Probe Eddy NG Setup

!!! note

    The EddyNG guide recommends heating the bed before doing calibration

--steps--

1. Run `_SET_KIN_MAX_Z` and then **use normal controls to move** the toolhead so that the nozzle is only a few mm above the bed surface
2. Run `M190 S60` to heat the bed to 60c!
3. Run the `STOP_CAMERA` macro to stop the camera
4. Run `PROBE_EDDY_NG_SETUP`, Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! warning

    Do not use a metal feeler gauge for this step, it could damage your eddy!!!

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

Source: <https://github.com/vvuk/eddy-ng/wiki#calibration>

!!! warning

    If you get errors when it comes to tapping as part of printing you may need to [increase the tap drive current](eddyng_troubleshooting.md#tap-failed-with-z-error-during-homing-probe)

--8<-- "snippets/probe/manual_bed_tramming.md"

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

--8<-- "snippets/probe/axis_twist_compensation.md"

--8<-- "snippets/probe/first_print.md"

--8<-- "snippets/probe/other_calibrations.md"

## Where can I get help?

For support, join the [SimpleAF Discord](https://discord.gg/M5rmBQqRSG).

For questions about the upstream eddy-ng project itself, see: <https://github.com/vvuk/eddy-ng/wiki#questions-discussion-help>
