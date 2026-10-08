# Cartotouch

!!! klipper-error "Build Plate Damage Alert"

    Your build plate must be spring steel with a magnetic sheet attached to your underlying printer bed.  Do not try and use this probe with embedded magnets or 
    some crappy magnetic flex plate that is not spring steel, your nozzle will dig a big hole in it.

This page covers installing SimpleAF using a Cartographer probe. New here? See [Getting Started](getting-started.md).

RPi / SBC users: install SimpleAF via [SimpleAF for RPi](rpi.md). The rest of this page &mdash; probe firmware, mount options, and calibration &mdash; applies to your setup too.

!!! warning

    Cartotouch is legacy and is kept here for reference only. New installs should use [Cartographer](cartographer.md) instead.

## Firmware requirements

--8<-- "snippets/probe/limits_on_x_and_y_microsteps_32.md"

### K1 Series

This guide assumes you have a K1, K1C, K1SE or K1 Max and you are running stock creality firmware 1.3.3.5 or **higher** (The firmware 1.3.3.5 is much older than 1.3.3.46 for example), **or alternately** you can use [my prerooted firmware](prerooted_firmware.md).

#### Ender 5 Max

This guide assumes you are running stock Creality firmware 1.2.0.10 or **higher** on your Ender 5 Max.

The stock firmware comes pre-rooted, with the default root password being `Creality@2024_Wh_464`

Please note that you will need to change the screen orientation to horizontal, here is a model for that <https://www.printables.com/model/1246910-ender-5-max-screen-bracket>

#### Ender 3 V3 KE

This guide assumes you have a stock Ender 3 V3 KE with Nebula Pad with Root enabled, when you get to installation below, you should specify the `--mount Default` to install
Simple AF on the KE for Cartographer.

Please note that you will need to change the screen orientation to horizontal, here is a model for that <https://www.printables.com/model/727362-ender-3-v3-ke-screen-holder-landscape-for-guppyscr>,
but please do **not** follow the installation instructions on that page, just print the model and remount your screen only!
An alternative model which honestly seems a bit cleaner: <https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### Nebula Pad

This probe is currently not supported on Nebula Pad.

### CR10SE

This probe is currently not supported on CR10SE.

### RPi or SBC

See [Simple AF for RPi](rpi.md)

## Cartographer Firmware

!!! warning

    For K1 Series (which includes K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max) Simple AF you **must** flash your **V3 Probe** with `CARTOGRAPHER K1 5.0.0`:

    ![image](assets/images/cartographer_k1_500.png)

    For a **V4 Probe** `CARTOGRAPHER V4 6.0.0 Lite`:

    ![image](assets/images/cartographer_v4_600.png)

    For K1 Series (which includes K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max) Simple AF there is the [cartographer flashing guide](cartographer_flashing.md).
    
    For Simple AF for RPi, you can use the standard cartographer guide <https://docs.cartographer3d.com/cartographer-probe/firmware/firmware-updating/via-katapult/usb-flash#usb-katapult-updating>

    If you are using a Pi3 or less (so CB1, CB2, OPi 3, etc) to run klipper, I strongly recommend using the K1/Lite variants of the cartographer firmware, you can do that 
    in the firmware script by enabling Advanced Mode and Enabling Creality K Series Firmware.

## Probe Installation

It is **strongly** recommended to connect your probe to the front USB port initially and use it for a while that way to make sure its stable, before
directly wiring it to either the mainboard or making a cable for the lidar port (K1M users only).   If possible avoid destroying the original cable when
you are making your lidar or direct mainboard connection as you might need it in the future!

!!! danger

    If you are not using a side mount you **must** verify config changes for cartotouch.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount                  | Printer            | Carto                                                   | URL                                                                                                                                                                                      | Notes                                                                                                             |
|------------------------|--------------------|---------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| **Default**            | K1, K1C, K1M, K1SE | V3&nbsp;Right&nbsp;Angle                                | <https://www.printables.com/model/1037606-cartographer-3d-right-angle-k1-series-mount>                                                                                                   |                                                                                                                   |
| **D3vilStock**         | K1, K1C, K1M, K1SE | V3&nbsp;Flat&nbsp;Pack                                  | <https://www.printables.com/model/684338-k1-k1max-eddy-current-mount-cartographer>                                                                                                       |                                                                                                                   |
| **Pellcorp**           | K1, K1C, K1M, K1SE | V4 Right angle variant                                  | <https://www.printables.com/model/1680350-cartographer-v4-rear-mounted-k1>                                                                                                               | May require shimming for correct nozzle offset                                                                    |
| **BootyGantry**        | K1, K1C, K1M, K1SE | V3&nbsp;Right&nbsp;Angle                                | <https://github.com/tlace17/K1-Linear-Rail-Gantry/blob/main/STLs/Probe%20Mounts/Rail%20Carriage%20Carto%20Mount.stl>                                                                     | May require shimming for correct nozzle offset                                                                    |
| **SkeletorMK7**        | K1, K1C, K1M, K1SE | V3&nbsp;Low&nbsp;Profile<br />V4&nbsp;Low&nbsp;Profile  | <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo><br /><br /><b>Get it printed:</b> <https://mk7.tbkm.xyz/>                                   |                                                                                                                   |
| **SkeletorRightAngle** | K1, K1C, K1M, K1SE | All V3 and V4 variants                                  | <https://www.printables.com/model/1362668-skeletor-mk7-side-mounted-cartographer-integration>                                                                                            |                                                                                                                   |
| **PurcellV5**          | K1, K1C, K1M, K1SE | V3&nbsp;Right&nbsp;Angle                                | <https://www.printables.com/model/1071493-cartographer-probe-side-mount-options-for-creality><br /><https://www.printables.com/model/1239076-creality-k1-cartographer-right-angle-mount> | This also works with V3 and V4, probably also V8                                                                  |
| **SimplyHexed**        | Ender 5 Max        | V3&nbsp;Right&nbsp;Angle                                | <https://www.printables.com/model/1209230-ender-5-max-simply-hexed>                                                                                                                      | Requires custom shroud, also a risk it will hit the frame                                                         |
| **Default**            | Ender 3 V3 KE      | V3&nbsp;Right&nbsp;Angle                                | <https://github.com/pellcorp/Creality-Ender-3-V3-SE-KE/blob/main/KE%20Beacon-Cartographer%20Mount/STL%20Files/Ender3V3KE%20BeaconCartographer%20mount.stl>                               | Might require shimming depending on the hotend / nozzle you use<br />Original author removed from printables.com! |
| **Pellcorp**           | Ender 3 V3 SE      | All V3 and V4 variants                                  | <https://www.printables.com/model/1621139-ender-3-v3-se-cartographer-and-beacon-mounts>                                                                                                  | Only works with K1 hotend, might require scaling in Z                                                             |

### Nozzle Offset

!!! warning

    It is vital that you verify the coil to nozzle tip distance is within the valid range of 2.6 to 3mm, you can use this simple tool to verify the range:
    <https://www.printables.com/model/1325363-cartographer-and-beacon-z-offset-goldilocks-tool>

    Just be sure to use digital calipers to verify the print printed with the correct size before relying on it, if you have trouble with 
    your z not being always entirely accurate consider printing the model on its side.

## Installation

!!! warning

     The installation section does not apply to Simple AF for RPi, See [Simple AF for RPi](rpi.md)

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow the [Enable Root Access](enable-root-access.md) instructions.

!!! tip

    ZeroDotCmd (aka Zero on discord) has provided an excellent Cartographer installation video, you can find it <https://www.youtube.com/watch?v=GuxMITM9o4I>

    Please note however that the macros referenced in the video guide have been removed and you should instead follow the Calibration section of this wiki,
    I do not have the time to maintain the old guided macros, but you can still use the QUICK_START macro to do the pid and input shaper tuning.

### Downgrading from Cartographer?

Its really easy to update, you can simply do a probe switch like this:

```
~/pellcorp/installer.sh --update cartotouch --mount %CURRENT%
```

Then do [calibration](#calibration) as normal

--8<-- "snippets/probe/factory_reset.md"

--8<-- "snippets/probe/clone_the_repo.md"

### Run the installer

!!! note

    If you have pellcorp-overrides in github but not stored locally, [you need to recreate the ~/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

To run the script, you must use the following command:

```
/usr/data/pellcorp/installer.sh --install cartotouch --mount Mount
```

!!! tip "Install Kalico"

    If you want to use [Kalico](kalico.md) instead of Klipper, add the `--kalico` installation argument! 

!!! warning

    Replace `Mount` with the specific mount option for the mount you have used, if you do not do this the printer will be incorrectly configured for your mount, and bed meshes, x and y limits and related config will be wrong.   Please refer to [Mount Options](#mount-options) for supported mounts.   

    If you are using a non-supported mount you should specify a mount option as close to your mount as possible and properly adjust your configuration after installation before trying to perform a bed mesh or Screws Tilt Calculate!

## Post Installation

--8<-- "snippets/probe/mcu_firmware_updates_are_pending.md"

--8<-- "snippets/probe/slicer_settings.md"

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Enable Touch Mode](#enable-touch-mode)
    - [Manual Cartographer Calibrate](#manual-cartographer-calibrate)
    - [Cartographer Threshold Scan](#cartographer-threshold-scan)
    - [Cartographer Touch Calibration](#cartographer-touch-calibration)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

!!! note

    If you are running calibration for a printer that has previously been calibrated, the following SAVE_CONFIG sections **must** be removed from the bottom of the printer.cfg (if they exist) before
    redoing these calibrations:
      
    - `[scanner model default]`
    - `[scanner]`
    - `[axis_twist_compensation]`
    - `[bed_mesh]`

### Enable Touch Mode

To be able to set up the printer for cartographer with touch mode for printing you need to make sure the
mode is set to touch.

1. Run `PROBE_SWITCH MODE=touch`
<br />Upon completion *`SAVE_CONFIG`*

Source: <https://docs.cartographer3d.com/original-plugin/installation/calibration#initial-calibration>

### Manual Cartographer Calibrate

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Run `CARTOGRAPHER_CALIBRATE METHOD=manual`
Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

!!! warning

    Do not use a metal feeler gauge for this step, it could damage your cartographer!!!

**Source:** <https://docs.cartographer3d.com/original-plugin/settings-and-commands#cartographer_calibrate>

After the save config you have to do the cartographer threshold scan (see next)

### Cartographer Threshold Scan

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home All (`G28`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Run `CARTOGRAPHER_THRESHOLD_SCAN SPEED=2 MIN=1000 MAX=5000`
<br />Upon completion *`SAVE_CONFIG`*

After the save config you have to do the touch calibration.

**Source:** <https://docs.cartographer3d.com/original-plugin/settings-and-commands#cartographer_threshold_scan>

### Cartographer Touch Calibration

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home All (`G28`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Run `CARTOGRAPHER_CALIBRATE`
<br />Upon completion *`SAVE_CONFIG`*

!!! tip

    If this fails after 3 tries, you should check to make sure there is not filament stuck to the bottom of your nozzle!

**Source:** <https://docs.cartographer3d.com/original-plugin/installation/calibration#setting-up-touch>

--8<-- "snippets/probe/manual_bed_tramming.md"

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

### Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation calibration **if you are using a rear mount** before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

--steps--

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE` The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! warning

    Do not use a metal feeler gauge for this step, it could damage your cartographer!!!

**Source:** <https://www.klipper3d.org/Axis_Twist_Compensation.html>

### First Print

You should optimise your `scanner_touch_z_offset` using baby stepping, as documented here: <https://docs.cartographer3d.com/original-plugin/installation/first-print>

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

--8<-- "snippets/probe/other_calibrations.md"

--8<-- "snippets/probe/where_can_i_get_help.md"
