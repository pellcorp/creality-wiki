## Where can I get help?

Come on over to the pellcorp discord server, the `#simple-af-btteddy` channel has been setup for anyone wanting support for btt eddy.

<https://discord.gg/2uGDzyJ3WX>

### K1 Series

This guide assumes you have a K1, K1C, K1SE or K1 Max and you are running stock creality firmware 1.3.3.5 or **higher** (The firmware 1.3.3.5 is much older than 1.3.3.46 for example), or alternately you are using [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

### Ender 5 Max

This probe is currently not supported on Ender 5 Max

### Ender 3 V3 KE

This probe is not **yet** supported, but is planned.

### Simple AF for RPi

See [Simple AF for RPi](rpi.md)

## Slicer Settings

!!! danger

    Creality Print won't be able to see your printer after you have installed Simple AF, the only tested slicer we all use is OrcaSlicer, likely if you want to
    use Creality Print you will need to print via usb.

    Cura Slicer won't work out of the box for configuring START_PRINT variables as below, you need to change the start print EXTRUDER_TEMP and BED_TEMP to pass
    in the correct values, but since I don't use Cura Slicer I can't advise on that!

There is an assumption that you are using a slicer like OrcaSlicer and Machine G-code like:

![image](assets/images/slicer.png)

**Machine start G-code**
```
M140 S0
M104 S0
START_PRINT EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single]
```

**Machine end G-code**
```
END_PRINT
```

### Custom Bed Mesh Profile

If you want to select a specific predefined bed mesh profile (which disables adaptive mesh generation), you can pass in an additional `START_PRINT` parameter:

You can either hard code it to a particular model, like `BED_MESH_PROFILE=myprofile` or you can specify a profile based on orca slicer variables, such as `BED_MESH_PROFILE="[curr_bed_type] - [filament_type]"`, but you have to make sure you have all the possible profiles
defined for each of the bed type and filament type combinations.

![image](https://github.com/user-attachments/assets/6bc0f01e-6bd4-4e0b-9031-a2b41c1d6a02)

## Wiring

!!! note

    This wiring section applies to K1/K1C/K1SE/K1M printers only

Confirm the USB wiring based on this diagram(s)
On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

![image](assets/images/eddy_usb_wiring.png) ![image](assets/images/nozzle_lidar_usb_port_wiring.png)

## Probe Installation

!!! danger

    If you are not using a side mount you **must** verify config changes for btteddy.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount         | URL                                                                                                                                               | Notes                                                   |
|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| **Default**   | <https://www.printables.com/model/1012524-btteddy-creality-k1-k1c-k1-max-mount><br/><https://www.printables.com/model/1097856-btt-eddy-duo-mount> |                                                         |
| **Pellcorp**  | <https://www.printables.com/model/965667-wip-k1-btt-eddy-rear-mount-v4>                                                                           |                                                         |
| **Ballaswag** | <https://makerworld.com/en/models/494931>                                                                                                         | Config copied from k1_mod sources, otherwise not tested |
| **Slam**     | <https://www.printables.com/model/1195575-btt-eddy-mount-for-k1c>                                                                                 |      |

### Nozzle Offset

!!! warn

    If you use a different probe mount you must make sure the bottom of the btt eddy is between 2.6mm and 3mm from the tip of the nozzle, so if the nozzle is touching the bed (when both are cold), the bottom of the eddy should be at least 2.5mm above the bed and no more than 3mm.

    You can try this tool <https://www.printables.com/model/1277844-btt-eddy-and-eddy-ng-setup-helpers>

## BTT Eddy Firmware

!!! warning

    It is assumed that you have flashed your eddy with the firmware from <https://github.com/pellcorp/klipper/blob/master/fw/K1/btteddy.uf2> **before** starting the installation!!!
    
    For K1 Series Simple AF [there is a guide](btteddy_flashing.md)
    
    For Simple AF for RPi, you can follow this guide <https://github.com/bigtreetech/Eddy?tab=readme-ov-file#compiling-firmware>.   But make sure
    you are not trying to use any fork of klipper than pellcorp/klipper-rpi!  You can also skip this compilation step and just copy 
    the `~/klipper/fw/k1/btteddy.uf2` file to the Eddy after putting it into boot mode.

## Installation

!!! warn

     The installation section does not apply to Simple AF for RPi, See [Simple AF for RPi](rpi.md#installation)

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow the excellent [Helper Script Enable Root Access](https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access) instructions.

!!! tip

    ZeroDotCmd (aka Zero on discord) has provided an excellent BTT Eddy installation video, you can find it <https://www.youtube.com/watch?v=B17sS1klRxA>

    Please note however that the macros referenced in the video guide have been removed and you should instead follow the Calibration section of this wiki,
    I do not have the time to maintain the old guided macros, but you can still use the QUICK_START macro to do the pid and input shaper tuning.

### Factory Reset 

You must do a factory reset **only** if you have installed Helper Script or Fluidd/Mainsail directly from Creality, otherwise
you can safely proceed directly to installation.    If you have setup your printer with stock firmware only it can be quite
handy to skip a factory reset so that you can use [Switch to Stock](misc.md#switch-to-stock)

```
wget --no-check-certificate https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S58factoryreset -O /tmp/S58factoryreset
chmod +x /tmp/S58factoryreset
/tmp/S58factoryreset reset
```

!!! danger

    It is really important you do not close the ssh session until you get this message:

    ![image](assets/images/factory_reset.png)

    It can take up to 5 minutes for a factory restart to finish, it is **vital** you do not power cycle your printer before the stock screen appears. There may be a 3002 error on the screen, this is completely normal.   If you are planning to install Simple AF you can ignore it, if you are trying to go back to stock, power cycle the printer again to clear the error.  

    Failing to follow this advice can lead to your printer getting bricked and requiring much more involved intervention to recover!
    
    ![image](assets/images/error3002.png)

### Clone the Repo

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
sync
```

### Run the installer

!!! note

    If you have pellcorp-overrides in github but not stored locally, [you need to recreate the ~/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

To run the script, you must specify the probe you want to use.

```
/usr/data/pellcorp/installer.sh --install btteddy --mount Mount
```

!!! warning

    For `Mount` you must specify the mount option for the mount you have used, if you do not do this the printer will be incorrectly configured for your mount, and bed meshes, x and y limits and related config will be wrong.   Please refer to [Mount Options](#mount-options) for supported mounts.   

    If you are using a non-supported mount you should specify a mount option as close to your mount as possible and properly adjust your configuration after installation before trying to perform a bed mesh or Screws Tilt Calculate!

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

### Verify USB Key

It is important to make sure you have a way to [emergency factory reset](misc.md#emergency-factory-reset) the printer, if the worst happens.   There is a macro in Simple AF called `CHECK_USB_KEY` that will wait for you to plug a USB thumb drive (aka USB key) in and tell you if it was able to be successfully mounted.

![image](assets/images/check_usb_key.png)

- If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB thumb drive (aka USB key) is perfect to use for a factory reset.
- If you get no message at all before the script ends (after 60 seconds), your USB thumb drive (aka USB key) is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

!!! tip

    You should verify your USB thumb drive (aka USB key) often just to make sure you have something if you need to unbrick your printer, simply type `CHECK_USB_KEY` or hit the button in Fluidd / Mainsail
    The USB key should be FAT32 formatted and be no larger than 32GB!

!!! note

    If you have plugged your btt eddy into the front usb port, you are going to have to temporarily remove the btt eddy from the front usb slot and replace it with your USB thumb drive, after you have finished verifying the USB thumb drive can be used in an emergency, you can replace the btt eddy into the front usb slot and restart klipper or power cycle your printer.

![image](assets/images/check_usb_key.png)

- If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB thumb drive (aka USB key) is perfect to use for a factory reset.
- If you get no message at all before the script ends (after 60 seconds), your USB thumb drive (aka USB key) is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

### Timer too close and microsteps

For btteddy you cannot use more than `microsteps: 32`, the MCU cannot handle both more microsteps and eddy, it puts too much pressure on the system and it cause stuttering during bed meshes, it is also been known to cause klipper to crash
during repeated bed meshes.

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Drive Current Calibration](#drive-current-calibration)
    - [Mapping Eddy Readings To Nozzle Heights](#mapping-eddy-readings-to-nozzle-heights)
    - [Temperature Compensation Calibration](#temperature-compensation-calibration)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

!!! danger

    It is extremely important that you perform the following calibrations while the btt eddy is cool, if you calibrate the eddy hot, you will experience `Error during homing z: Eddy current sensor error` errors while homing and performing bed mesh if the btt is significantly cooler than it was while doing initial calibration.   

### Drive Current Calibration

1. Home XY (`G28 X Y`)
2. Make sure nozzle is centred on bed
3. Run `_SET_KIN_MAX_Z` and then move the toolhead so that the bottom of the eddy is approximately 20mm from the bed, please try and be as accurate as possible with this distance, it's **better to be slightly closer** to the bed than further away.
4. Run `BTTEDDY_CALIBRATE_DRIVE_CURRENT`
5. Run SAVE_CONFIG

**Source:** <https://github.com/bigtreetech/Eddy?tab=readme-ov-file#2-drive-current-calibration>

!!! note

    The auxiliary fan may turn on until the btt eddy temp is less than 40c before starting the actual calibration.  If you are in a hot climate you may need to adjust the `btteddy_macro.cfg` `variable_calibration_max_temp` value to something higher than 40c if you can't get the btt eddy under 40c with the aux fan easily.

### Mapping Eddy Readings To Nozzle Heights

6. Home X and Y (`G28 X Y`)
7. Make sure nozzle is centred on bed
8. Run `BTTEDDY_CURRENT_CALIBRATE` Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
9. After clicking **Accept**, the printer is going to move the bed up and down quite a few times as part of the calibration, do **not** interrupt it
10. Upon completion *`SAVE_CONFIG`*

**Source:** <https://github.com/bigtreetech/Eddy?tab=readme-ov-file#3-mapping-eddy-readings-to-nozzle-heights>

!!! warn

    Do not use a metal feeler gauge for this step, it could damage your eddy!!!

!!! note

    The auxiliary fan may turn on until the btt eddy temp is less than 40c before starting the actual calibration.  If you are in a hot climate you may need to adjust the `btteddy_macro.cfg` `variable_calibration_max_temp` value to something higher than 40c if you can't get the btt eddy under 40c with the aux fan easily.

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

### Temperature Compensation Calibration

10. Home All (`G28`)
11. Make sure nozzle is centred on bed
12. Run `BTTEDDY_TEMPERATURE_PROBE_CALIBRATE`
<br />Upon completion *`SAVE_CONFIG`*

**Source:** <https://github.com/bigtreetech/Eddy?tab=readme-ov-file#5-temperature-compensation-calibration-eddy-usb-only>

!!! warn

    Do not use a metal feeler gauge for this step, it could damage your eddy!!!

!!! tip

    If you are struggling to get over about 80c, you can end the calibration early with the `TEMPERATURE_PROBE_COMPLETE` macro, just know that if you end the calibration early and then you try to print really hot and the eddy gets hotter than the hottest temp you calibrated the eddy is going to read the bed wrong and cause issues for homing but especially bed meshes.

### Pid Tuning and Input Shaping

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

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

### Axis Twist Compensation

If you are using **a rear mount** it is highly recommended to perform axis twist compensation, this will affect the quality of your bed mesh, so best to do it before.

!!! tip

    There is no need to run axis twist compensation if you have mounted the eddy with a side mount that has a 0 y offset!

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE` The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
   <br />Upon completion *`SAVE_CONFIG`*

**Source:** <https://www.klipper3d.org/Axis_Twist_Compensation.html>

!!! warn

    Do not use a metal feeler gauge for this step, it could damage your eddy!!!

### First Print

The save baby stepping button in fluidd / mainsail does nothing for btteddy, the z-offset is automatically saved to the variables.cfg,
we copied the feature from Helper Script: <https://guilouz.github.io/Creality-Helper-Script-Wiki/helper-script/save-z-offset-macros/>

### Bed Mesh

Now you can now run your first bed mesh:
`BED_MESH_CALIBRATE`

**Source:** <https://ballaswag.github.io/blog/creality-k1-btt-eddy-guide/>

**Source:** <https://github.com/bigtreetech/Eddy>

### Other Calibrations

!!! info

    The default value for pressure advance is set to `0.04`

Refer to [Orcaslicer Calibration](https://github.com/SoftFever/OrcaSlicer/wiki/Calibration) for more calibrations

Refer to the [Ellis Print Tuning Guide](https://ellis3dp.com/Print-Tuning-Guide/) for more great tuning ideas.
