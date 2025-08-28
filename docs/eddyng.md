!!! warning

    This feature is under active development from vvuk over at <https://github.com/vvuk/eddy-ng/>, so there are likely to be gotchas and issues, please bare that in mind.

## Where can I get help?

Come on over to the pellcorp discord server, the `#simple-af-btteddy` channel has been setup for anyone wanting support for btt eddy.

<https://discord.gg/2uGDzyJ3WX>

### eddy-ng discord 

You can also get help from the eddy-ng discord channels on the sovol discord, with the <https://discord.gg/djhnkDR2JN> link

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

## Probe Installation

!!! danger

    If you are not using a side mount you **must** verify config changes for eddyng.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount        | Printer             | URL                                                                                                                                                                     | Notes                                                         |
|--------------|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| **Default**  | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/1012524-btteddy-creality-k1-k1c-k1-max-mount><br/><https://www.printables.com/model/1212731-btt-eddy_ng-mount-for-creality-k1-series> ||
| **Pellcorp** | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/965667-wip-k1-btt-eddy-rear-mount-v4>                                                                                                 ||
| **Slam**     | K1, K1C, K1M, K1SE  | <https://www.printables.com/model/1195575-btt-eddy-mount-for-k1c>                                                                                                       ||
| **Default**  | Ender 3 V3 SE       | <https://www.printables.com/model/1202031-ender-3-v3-se-k1-hotend-btt-eddy-mount>                                                                                       ||
| **Default**   | Ender 3 KE         | <https://www.printables.com/model/1002777-cr-touch-to-btt-eddy-adapter-bracket>                                                                                         |**This probe and mount has not been tested on a KE running Simple AF, experimental**|

### Nozzle Offset

!!! warn

    Regardless of the mount, you should verify the btt eddy **coil** is at least 3mm away from the nozzle tip, its better to be further away than closer.
    This is not the difference of the bottom of the case to the nozzle, the case is about 1.2mm thick, so this means you want the bottom of the case to be at least 2mm offset, 
    its probably a good idea to look into mounts which do not use a case or a modified case with no bottom.
    
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
/usr/data/pellcorp/installer.sh --install eddyng --mount Mount
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

You can find the CHECK_USB_KEY macro in Fluidd or Mainsail, because Fluidd and Mainsail are already installed, you can access Fluidd by opening your browser and connecting
using http://X.X.X.X, where X.X.X.X is your ip address that you used to login via ssh to your printer, you can also access Fluidd via http://X.X.X.X:4408 and Mainsail via http://X.X.X.X:4409!

![image](assets/images/check_usb_key_macro.png)

After running the macro you should see output like the following:

![image](assets/images/check_usb_key.png)

- If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB thumb drive (aka USB key) is perfect to use for a factory reset.
- If you get no message at all before the script ends (after 60 seconds), your USB thumb drive (aka USB key) is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

!!! tip

    You should verify your USB thumb drive (aka USB key) often just to make sure you have something if you need to unbrick your printer, simply type `CHECK_USB_KEY` or hit the button in Fluidd / Mainsail
    The USB key should be FAT32 formatted and be no larger than 32GB!

!!! note

    If you have plugged your btt eddy into the front usb port, you are going to have to temporarily remove the btt eddy from the front usb slot and replace it with your USB thumb drive, after you have finished verifying the USB thumb drive can be used in an emergency, you can replace the btt eddy into the front usb slot and restart klipper or power cycle your printer.

### Timer too close and microsteps

For eddyng you cannot use more than `microsteps: 32`, the MCU cannot handle both more microsteps and eddy, it puts too much pressure on the system and it cause stuttering during bed meshes, it is also been known to cause klipper to crash
during repeated bed meshes.

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Probe Eddy NG Setup](#probe-eddy-ng-setup)
    - [PID Tuning and Input Shaping](#pid-tuning-and-input-shaping)

### Probe Eddy NG Setup

Calibrating the eddy should be as easy as running the `PROBE_EDDY_NG_SETUP`, first step is to home X and Y:

1. Home XY (`G28 X Y`)
2. Make sure nozzle is centred on bed
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Run `PROBE_EDDY_NG_SETUP`, Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

!!! warn

    Do not use a metal feeler gauge for this step, it could damage your eddy!!!

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

Source: <https://github.com/vvuk/eddy-ng/wiki#calibration>

!!! warn

    If you get errors when it comes to tapping as part of printing you may need to [increase the tap drive current](eddyng_troubleshooting.md#tap-failed-with-z-error-during-homing-probe)

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

### First Print

You should optimise your probe z offset using baby stepping.

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

### Other Calibrations

!!! info

    The default value for pressure advance is set to `0.04`

Refer to [Orcaslicer Calibration](https://github.com/SoftFever/OrcaSlicer/wiki/Calibration) for more calibrations

Refer to the [Ellis Print Tuning Guide](https://ellis3dp.com/Print-Tuning-Guide/) for more great tuning ideas.
