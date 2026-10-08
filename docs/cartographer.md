# Cartographer 

!!! klipper-error "Build Plate Damage Alert"

    Your build plate must be spring steel with a magnetic sheet attached to your underlying printer bed.  Do not try and use this probe with embedded magnets or 
    some crappy magnetic flex plate that is not spring steel, your nozzle will dig a big hole in it.

This page covers installing SimpleAF using a Cartographer probe. New here? See [Getting Started](getting-started.md).

RPi / SBC users: install SimpleAF via [SimpleAF for RPi](rpi.md). The rest of this page &mdash; probe firmware, mount options, and calibration &mdash; applies to your setup too.

!!! info

    Already running Cartotouch from a previous SimpleAF install? See [Cartotouch](cartotouch.md). Cartotouch is legacy &mdash; new installs should use Cartographer.

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

Please note that you will need to change the screen orientation to horizontal, here is a model for that:
<https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### Nebula Pad

This probe currently is supported for Ender 3 V3 SE, but additional Ender 3 models can be supported if there is interest.

### CR10SE

This probe is currently not supported on CR10SE, but support can be added if there is interest.

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

    If you are not using a side mount you **must** verify config changes for cartographer.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount                    | Printer              | Carto                                                  | URL                                                                                                                                                                                      | Notes                                                                                                                     |
|--------------------------|----------------------|--------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| **Default**              | K1, K1C, K1M, K1SE   | V3&nbsp;Right&nbsp;Angle                               | <https://www.printables.com/model/1037606-cartographer-3d-right-angle-k1-series-mount>                                                                                                   |                                                                                                                           |
| **Default**              | K1, K1C, K1M, K1SE   | V4&nbsp;Standard                                       | <https://www.printables.com/model/1629782-creality-k1-cartographer-v4-mount>                                                                                                             |                                                                                                                           |
| **D3vilStock**           | K1, K1C, K1M, K1SE   | V3&nbsp;Flat&nbsp;Pack                                 | <https://www.printables.com/model/684338-k1-k1max-eddy-current-mount-cartographer>                                                                                                       |                                                                                                                           |
| **Pellcorp**             | K1, K1C, K1M, K1SE   |  V4 Right angle variant                                | <https://www.printables.com/model/1680350-cartographer-v4-rear-mounted-k1>                                                                                                               | May require shimming for correct nozzle offset                                                                            |
| **BootyGantry**          | K1, K1C, K1M, K1SE   | V3&nbsp;Right&nbsp;Angle                               | <https://github.com/tlace17/K1-Linear-Rail-Gantry/blob/main/STLs/Probe%20Mounts/Rail%20Carriage%20Carto%20Mount.stl>                                                                     | May require shimming for correct nozzle offset                                                                            |
| **SkeletorMK7**          | K1, K1C, K1M, K1SE   | V3&nbsp;Low&nbsp;Profile<br />V4&nbsp;Low&nbsp;Profile | <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo><br /><br /><b>Get it printed:</b> <https://mk7.tbkm.xyz/>                                   |                                                                                                                           |
| **SkeletorRightAngle**   | K1, K1C, K1M, K1SE   | All V3 and V4 variants                                 | <https://www.printables.com/model/1362668-skeletor-mk7-side-mounted-cartographer-integration>                                                                                            |                                                                                                                           |
| **PurcellV5**            | K1, K1C, K1M, K1SE   | V3&nbsp;Right&nbsp;Angle                               | <https://www.printables.com/model/1071493-cartographer-probe-side-mount-options-for-creality><br /><https://www.printables.com/model/1239076-creality-k1-cartographer-right-angle-mount> | This also works with V3 and V4, probably also V8                                                                          |
| **SimplyHexed**          | Ender 5 Max          | V3&nbsp;Right&nbsp;Angle                               | <https://www.printables.com/model/1209230-ender-5-max-simply-hexed>                                                                                                                      | Requires custom shroud, also a risk it will hit the frame                                                                 |
| **Default**              | Ender 3 V3 KE        | V3&nbsp;Right&nbsp;Angle                               | <https://github.com/pellcorp/Creality-Ender-3-V3-SE-KE/blob/main/KE%20Beacon-Cartographer%20Mount/STL%20Files/Ender3V3KE%20BeaconCartographer%20mount.stl>                               | Might require shimming depending on the hotend / nozzle you use<br />Original author removed from printables.com!                                                           |
| **Pellcorp**             | Ender 3 V3 SE        | All V3 and V4 variants                                 | <https://www.printables.com/model/1621139-ender-3-v3-se-cartographer-and-beacon-mounts>                                                                                                  | Only works with K1 hotend, might require scaling in Z                                                                     |


!!! note

    Multiple mounts use the `Default` designation, if a mount has the same x and y offsets as Default but is for a different cartographer variant, it will be listed separately.

### Nozzle Offset

!!! warning

    It is vital that you verify that the coil to nozzle tip distance is within the Cartographer's required range of 2.6 to 3mm.  You can use this simple tool to measure the range:
    <https://www.printables.com/model/1325363-cartographer-and-beacon-z-offset-goldilocks-tool>

    Be sure to use digital calipers to confirm its dimensions before relying on it.  If you have trouble with
    your Z not being accurate, consider printing the model on its side.

    Also, note that K1 series hotends and nozzles may vary in length.  If the probe's distance from the nozzle is <2.6mm, you may need to try a different mount, or adjust
    the dimensions of an existing mount in CAD.

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

To run the script, you must use the following command:

```
/usr/data/pellcorp/installer.sh --install cartographer --mount Mount
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

If you are switching from cartotouch remove these:

- `[scanner model default]`
- `[scanner]`

Make sure you remove these:

- `[cartographer scan_model default]`
- `[cartographer touch_model default]`

Plus because axis twist and bed mesh were generated with a previous model you **must** remove these as well:

- `[axis_twist_compensation]`
- `[bed_mesh]`

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Scan calibration](#scan-calibration)
    - [Touch Calibration](#touch-calibration)

### Scan calibration

--steps--

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 148c (`M109 S148`) so that any filament can be removed from nozzle
4. Run `CARTOGRAPHER_SCAN_CALIBRATE`
   Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

**Source:** <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/scan-calibration>

!!! warning

    Do not use a metal feeler gauge for this step, it could damage your cartographer!!!

After the save config you have to do the touch calibration.

### Touch Calibration

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

--steps--

1. Home All (`G28`)
2. Run the `STOP_CAMERA` macro to stop the camera
3. Heat Nozzle to 148c (`M109 S148`) so that any filament can be removed from nozzle
4. Run `CARTOGRAPHER_TOUCH_CALIBRATE`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! note

    Some people have reported more reliable touch calibration with the nozzle heater off, so you could try running `TURN_OFF_HEATERS` after 
    step 3, or else skip step 3 entirely, just make sure your nozzle is clean af! 


!!! warning

    Observe your nozzle to make sure it touches on the bed.
    If it never touches the bed, refer to <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/touch-calibration#nozzle-never-touches-the-bed   >

**Source:** <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/touch-calibration>

--8<-- "snippets/probe/manual_bed_tramming.md"

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

### Axis Twist Compensation

!!! note

    This is a fancy new feature of the new Cartographer software it does not require any paper!

Next it is highly recommended to perform axis twist compensation calibration **if you are using a rear mount** before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

--steps--

1. Home All (`G28`)
2. Heat Nozzle to 148c (`M109 S148`) so that any filament can be removed from nozzle
3. Run `CARTOGRAPHER_AXIS_TWIST_COMPENSATION`
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

**Source:** <https://docs.cartographer3d.com/cartographer-probe/features/axis-twist-compensation>

### First Print

You should optimise your `cartographer touch_model default` `z_offset` using baby stepping, as documented here: <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/z-offset#babystep-adjusting-z-offset>

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

--8<-- "snippets/probe/other_calibrations.md"

## Where can I get help?

For support, join the [SimpleAF Discord](https://discord.gg/M5rmBQqRSG).

Please refer to [How can I make sure my bed is level / trammed?](faq.md#how-can-i-make-sure-my-bed-is-level-trammed)

--8<-- "snippets/cartographer/thanks.md"
