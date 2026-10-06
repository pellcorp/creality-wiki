# BL Touch, CR-Touch and 3D Touch

This page covers installing SimpleAF using a BLTouch / CR-Touch / 3D Touch probe. New here? See [Getting Started](getting-started.md).

RPi / SBC users: install SimpleAF via [SimpleAF for RPi](rpi.md). The rest of this page &mdash; mount options and calibration &mdash; applies to your setup too.

!!! info "What about CrTouch?"

    Yep you can use a CrTouch as an alternative to a BlTouch, however I have not personally used either of these with a K1 and so I can't currently provide detailed guidance on what config is required.

!!! info "What about 3d Touch?"

    Its possible a 3d touch will work too, but depending on the capabilities of the 3d touch clone, you might need to make some post installation changes.   I also think 3dTouch might require slightly different wiring.

    Please refer to more details, specifically note the fact that the `QUERY_PROBE` may not be supported, and the `probe_with_touch_mode` feature is not supported!

    <https://www.klipper3d.org/BLTouch.html#bl-touch-clones>

## Firmware requirements

--8<-- "snippets/probe/limits_on_x_and_y_microsteps_64.md"

### K1 Series

This guide assumes you have a K1, K1C, K1SE or K1 Max and you are running stock creality firmware 1.3.3.5 or **higher** (The firmware 1.3.3.5 is much older than 1.3.3.46 for example), **or alternately** you can use [my prerooted firmware](prerooted_firmware.md).

### Ender 3 V3 KE

This guide assumes you have a stock Ender 3 V3 KE with Nebula Pad with Root enabled, when you get to installation below, you should specify the `--mount Default` to install
Simple AF on the KE for Cr-Touch.

Please note that you will need to change the screen orientation to horizontal, here is a model for that:
   <https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### CR10SE

This guide assumes you have a stock CR10SE with Nebula Pad with Root enabled, when you get to installation below, you should specify the `--mount Default` to install
Simple AF on the CR10SE for Cr-Touch.

Please note that you will need to change the screen orientation to horizontal, here is a model for that:
<https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### Ender 5 Max

This probe is currently not supported on Ender 5 Max

### Nebula Pad

You can install Simple AF on a Nebula pad and use with a limited range of Ender 3 printers, refer to [Nebula Pad](nebula_pad.md) for details
of getting the required base firmware onto the nebula pad, as well as getting the right printer firmware flashed to your Ender 3.

Please note that you will need to change the screen orientation to horizontal, here is a model for the Ender 3 V3 SE:
   <https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### RPi or SBC

See [Simple AF for RPi](rpi.md)

## Probe Installation

!!! danger

    If you are not using a side mount you **must** verify config changes for bltouch.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount         | Printer                   | URL                                                                                 | Notes                        |
|---------------|---------------------------|-------------------------------------------------------------------------------------|------------------------------|
| **Default**   | K1, K1C, K1M, K1SE        | <https://www.printables.com/model/666186-creality-k1-bltouch-adapter>               |                              |
| **CrTouch**   | K1, K1C, K1M, K1SE        | <https://www.printables.com/model/1073375-cr-touch-mount-k1-k1maxk1c-zero-y-offset> | Untested on K1M              |
| **Default**   | Ender 3 V3 SE             | N/A                                                                                 | Default CR Touch Mount       |
| **Default**   | Ender 3 V3 KE             | N/A                                                                                 | Default CR Touch Mount       |
| **Default**   | CR10SE                    | N/A                                                                                 | Default CR Touch Mount       |
| **Default**   | Ender 3 V1, V1 Pro and V2 | N/A                                                                                 | Default CR/BL Touch Mount    |
| **SpritePro** | Ender 3 V1, V1 Pro and V2 | N/A                                                                                 | Sprite Pro CR/BL Touch Mount |

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
/usr/data/pellcorp/installer.sh --install bltouch --mount Mount
```

!!! tip "Install Kalico"

    If you want to use [Kalico](kalico.md) instead of Klipper, add the `--kalico` installation argument! 

!!! note "Nebula Pad"

    For a Nebula Pad installation you must also specify the correct `--printer` argument!   See [Supported Printers](nebula_pad.md#supported-printers) for more information.

!!! warning

    Replace `Mount` with the specific mount option for the mount you have used, if you do not do this the printer will be incorrectly configured for your mount, and bed meshes, x and y limits and related config will be wrong.   Please refer to [Mount Options](#mount-options) for supported mounts.   

    If you are using a non-supported mount you should specify a mount option as close to your mount as possible and properly adjust your configuration after installation before trying to perform a bed mesh or Screws Tilt Calculate!

## Post Installation

--8<-- "snippets/probe/mcu_firmware_updates_are_pending.md"

--8<-- "snippets/probe/slicer_settings.md"

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Probe Calibrate](#probe-calibrate)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

### Probe Calibrate

For the bltouch/3dtouch/crtouch it is **extremely** important to do the PROBE_CALIBRATE step to configure your z-offset, regardless of what model you have used to mount the probe!

![image](assets/images/probe_calibrate.png)

--steps--

1. Home All (`G28`)
2. Run `PROBE_CALIBRATE`
3. Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! note

    The default z-offset for BLTouch, 3dTouch and CrTouch is 0, so your prints won't stick without doing this step.

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

### Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation calibration before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

--steps--

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE`  The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

**Source:** <https://www.klipper3d.org/Axis_Twist_Compensation.html>

--8<-- "snippets/probe/first_print.md"

### Probing speed

On a K1/Max a faster lift_speed may counter the backlash on the Z-axis belts. Going too fast is likely making the bed bounce back in the opposite direction. Find the best speeds for probing by varying the probe_speed and lift_speed parameters.  Start with probe_speed=1 and vary the lift_speed values to find the optimal lift_speed first.

```
PROBE_ACCURACY probe_speed=1 lift_speed=15
```

In this case, lift_speed of 15mm/s seems optimal.

![image](assets/images/probe_accuracy_15mm.jpg)

After determining the optimal lift_speed, different probe_speed values can be tested until the sweet spot is found. Here 1.0mm/s works most reliably, however, the slow speed will make the meshing process take longer.

![image](assets/images/probe_accuracy_1mm.jpg)

Credit to Ales Omahen (@Havoc on discord) for this section

--8<-- "snippets/probe/other_calibrations.md"

--8<-- "snippets/probe/where_can_i_get_help.md"
