# Beacon

!!! klipper-error "Build Plate Damage Alert"

    Your build plate must be spring steel with a magnetic sheet attached to your underlying printer bed.  Do not try and use this probe with embedded magnets or 
    some crappy magnetic flex plate that is not spring steel, your nozzle will dig a big hole in it.

This page covers installing SimpleAF using a Beacon probe. New here? See [Getting Started](getting-started.md).

RPi / SBC users: install SimpleAF via [SimpleAF for RPi](rpi.md). The rest of this page &mdash; probe firmware, mount options, and calibration &mdash; applies to your setup too.

## Known Issues

The SCREW_TILT_ADJUST tool is not working at all for Beacon on Simple AF K1 Series, homing timeout occurs and crashes klipper,
a user reported it, and I reproduced on my K1 Max with a Beacon.   Further digging indicates this is a overload issue and honestly
I am not sure if it ever worked.   If I get a chance I might try and see if I can get this working in another way, but for now unfortunately
its not possible, if we had a Lite version of Beacon firmware we could make it work, but the firmware is closed source so its just not possible.

## Firmware requirements

--8<-- "snippets/probe/limits_on_x_and_y_microsteps_32.md"

### K1 Series

This guide assumes you have a K1, K1C, K1SE or K1 Max and you are running stock creality firmware 1.3.3.5 or **higher** (The firmware 1.3.3.5 is much older than 1.3.3.46 for example), **or alternately** you can use [my prerooted firmware](prerooted_firmware.md).

### Ender 5 Max

This guide assumes you are running stock Creality firmware 1.2.0.10 or **higher** on your Ender 5 Max.

The stock firmware comes pre-rooted, with the default root password being `Creality@2024_Wh_464`

Please note that you will need to change the screen orientation to horizontal, here is a model for that <https://www.printables.com/model/1246910-ender-5-max-screen-bracket>

### Ender 3 V3 KE

This guide assumes you have a stock Ender 3 V3 KE with Nebula Pad with Root enabled, when you get to installation below, you should specify the `--mount Default` to install
Simple AF on the KE for Beacon.

Please note that you will need to change the screen orientation to horizontal, here is a model for that <https://www.printables.com/model/727362-ender-3-v3-ke-screen-holder-landscape-for-guppyscr>,
but please do **not** follow the installation instructions on that page, just print the model and remount your screen only!

An alternative model which honestly seems a bit cleaner: <https://www.printables.com/model/706657-creality-ender-3-v3-e3v3-se-ke-and-cr-10-se-portra>

### CR10SE

This probe is currently not supported on CR10SE

### Nebula Pad

This probe is currently not supported on Nebula Pad

### RPi or SBC

See [Simple AF for RPi](rpi.md)

## Beacon Firmware

!!! warning

    You must have flashed your beacon with the latest beacon firmware (2.1.0 currently) **before** starting the installation

    For K1 Series Simple AF [there is a guide](beacon_flashing.md).
   
    For Simple AF for RPi, you can use the standard beacon guide <https://docs.beacon3d.com/contact/#51-firmware-update>

## Probe Installation

It is **strongly** recommended to connect your probe to the front USB port initially and use it for a while that way to make sure its stable, before
directly wiring it to either the mainboard or making a cable for the lidar port (K1M users only).   If possible avoid destroying the original cable when
you are making your lidar or direct mainboard connection as you might need it in the future!

!!! danger

    If you are not using a side mount you **must** verify config changes for beacon.cfg before homing your printer, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount                 | Printer            | Beacon                      | URL                                                                                                                                                        | Notes                                                           |
|-----------------------|--------------------|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| **Default**           | K1, K1C, K1M, K1SE | RevH&nbsp;Standard          | <https://www.printables.com/model/1071641-beacon-probe-mounts-for-creality-k1-series>                                                                      |                                                                 |
| **BootyGantry**       | K1, K1C, K1M, K1SE | RevH&nbsp;Standard          | <https://github.com/tlace17/K1-Linear-Rail-Gantry/blob/main/STLs/Probe%20Mounts/Rail%20Carriage%20Carto%20Mount.stl>                                       |                                                                 |
| **SkeletorMK7**       | K1, K1C, K1M, K1SE | RevH&nbsp;Low&nbsp;Profile  | <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo>                                                               |                                                                 |
| **SkeletorSideMount** | K1, K1C, K1M, K1SE | All RevH variants           | <https://www.printables.com/model/1362668-skeletor-mk7-side-mounted-cartographer-integration>                                                              |                                                                 |
| **SimplyHexed**       | Ender 5 Max        | RevH&nbsp;Standard          | <https://www.printables.com/model/1209230-ender-5-max-simply-hexed>                                                                                        | Requires custom shroud, also a risk it will hit the frame       |
| **Default**           | Ender 3 V3 KE      | RevH&nbsp;Standard          | <https://github.com/pellcorp/Creality-Ender-3-V3-SE-KE/blob/main/KE%20Beacon-Cartographer%20Mount/STL%20Files/Ender3V3KE%20BeaconCartographer%20mount.stl> | Might require shimming depending on the hotend / nozzle you used<br />Original author removed from printables.com! |
| **Pellcorp**          | Ender 3 V3 SE      | RevH&nbsp;Standard          | <https://www.printables.com/model/1621139-ender-3-v3-se-cartographer-and-beacon-mounts>                                                                    | Only works with K1 hotend, might require scaling in Z           |

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

You need root access, if you are not already root, then follow [Enable Root Access](enable-root-access.md)

--8<-- "snippets/probe/factory_reset.md"

--8<-- "snippets/probe/clone_the_repo.md"

### Run the installer

!!! note

    If you have pellcorp-overrides in github but not stored locally, [you need to recreate the ~/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

To run the script, you must use the following command:

```
/usr/data/pellcorp/installer.sh --install beacon --mount Mount
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

    - [Beacon Calibrate](#beacon-calibrate)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

### Beacon Calibrate

!!! note

    The beacon team recommends heat soaking the printer a bit before doing calibration

--steps--

1. Run `_SET_KIN_MAX_Z` and move toolhead so that the **nozzle  of the beacon is only a few mm above the bed surface**
2. Run `_CALIBRATE_HEAT_SOAK`, which will heat the bed to 60c, nozzle to 150c and **wait 8.5 minutes**!
3. Run the `STOP_CAMERA` macro to stop the camera
4. Run the `TURN_OFF_HEATERS` macro to stop heaters before starting calibration
5. Run `BEACON_CALIBRATE` Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

--!steps--

!!! warning

    Do not use a metal feeler gauge for this step, it could damage your beacon!!!

**Source:** <https://docs.beacon3d.com/quickstart/#6-calibrate-beacon>

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

--8<-- "snippets/probe/manual_bed_tramming.md"

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

!!! note

    You can use the QUICK_START Macro to complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

--8<-- "snippets/probe/pid_tuning.md"

--8<-- "snippets/probe/input_shaping.md"

--8<-- "snippets/probe/axis_twist_compensation.md"

### First Print

You should optimise your model offset using baby stepping.

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

--8<-- "snippets/probe/other_calibrations.md"

--8<-- "snippets/probe/where_can_i_get_help.md"
