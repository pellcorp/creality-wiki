## Where can I get help?

Come on over to the pellcorp discord server, the `#simple-af-carto` channel has been setup for anyone wanting support for cartographer.

<https://discord.gg/2uGDzyJ3WX>

## Thanks

Thanks to Richard from <https://cartographer3d.com> and Zarboz from <https://wattskraken.xyz/> for donating Cartographers to the Simple AF project to add support and continue to support the cartographer.

## Firmware requirements

### K1 Series

This guide assumes you have a K1, K1C, K1SE, K1 Max or Ender 5 Max and you are running stock creality firmware 1.3.3.5 or higher, or alternately you are using  [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

### Ender 5 Max

You must be using pre-rooted firmware, which is not available from Creality at the moment, you can get it from <https://github.com/zevaryx/ender-5-max-firmware>

### Simple AF for RPi

See [Simple AF for RPi](rpi.md)

## Slicer Settings

!!! warning

    If you have used a cartographer with k1-klipper, please note that the `PRINT_START` macro specified in their docs **is not supported** by this project.   You **must** change your Slicer Start Print Machine G-Code (see next)

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

    Applies to K1/K1C/K1SE/K1M printers only

On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

![image](assets/images/carto_connector.png)![image](assets/images/nozzle_lidar_usb_port_wiring.png)

## Probe Installation

!!! danger

    If you are not using a side mount you **must** verify config changes for cartotouch.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount                  | Printer            | Carto        | URL                                                                                                                                                                                              | Notes                                                                 |
|------------------------|--------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| **Default**            | K1, K1C, K1M, K1SE | Right Angle  | <https://www.printables.com/model/1037606-cartographer-3d-right-angle-k1-series-mount>                                                                                                           ||
| **D3vilStock**         | K1, K1C, K1M, K1SE | Flat Pack    | <https://www.printables.com/model/684338-k1-k1max-eddy-current-mount-cartographer>                                                                                                               ||
| **BootyGantry**        | K1, K1C, K1M, K1SE | Right Angle  | <https://github.com/tlace17/K1-Linear-Rail-Gantry/blob/main/STLs/Probe%20Mounts/Rail%20Carriage%20Carto%20Mount.stl>                                                                             |May require shimming for correct nozzle offset                        |
| **SkeletorMK7**        | K1, K1C, K1M, K1SE | Low Profile  | <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo>                                                                                                     |This is only for the low profile cartographer version of the mount!!! |
| **SkeletorRightAngle** | K1, K1C, K1M, K1SE | Right Angle  | <https://www.printables.com/model/1106768-skeletor-right-angle-cartographer-mount-k1-max-onl><br /><https://www.printables.com/model/1163069-k1max-right-angle-and-standard-format-cartographer> ||
| **PurcellV5**          | K1, K1C, K1M, K1SE | Right Angle  | <https://www.printables.com/model/1071493-cartographer-probe-side-mount-options-for-creality>                                                                                                    |This also works with V3 and V4, probably also V8                      |
| **SimplyHexed**        | Ender 5 Max        | Right Angle  | <https://www.printables.com/model/1209230-ender-5-max-simply-hexed>                                                                                                                              |Requires custom shroud                                                |
| **Default**            | Ender 3 V3 SE      | Right Angle  | <https://www.printables.com/model/732262-ender-3-v3-ke-beaconcartographer-mount>                                                                                                                 ||

### Nozzle Offset

!!! warn

    It is vital that you verify the model to nozzle tip distance is within the valid range of 2.6 to 3mm, you can use this simple tool to verify the range:
        <https://www.printables.com/model/1247533-carto-height-gauge>
    
    Just be sure to use digital calipers to verify the print printed with the correct size before relying on it, if you have trouble with 
    your z not being always entirely accurate consider printing the model on its size.

    Alternatively you can try the tool from cartographer3d.com:
        <https://www.printables.com/model/1060868-cartographer-probe-nozzle-offset-tool>

    Or for side mounted probes you may want to consider this version:

    <https://www.printables.com/model/1121309-cartographer-probe-nozzle-offset-tool-x-offset>


## Cartographer Firmware

!!! warning

    For K1 Series Simple AF you must flash your cartographer with `CARTOGRAPHER K1 5.1.0` survey firmware **before** starting the installation:

    ![image](assets/images/cartographer_k1_510.png)

    For K1 Series Simple AF [there is a guide](cartographer_flashing.md).
    
    For Simple AF for RPi, you can use the standard cartographer guide <https://docs.cartographer3d.com/cartographer-probe/firmware/firmware-updating/via-katapult/usb-flash#usb-katapult-updating>

## Installation

!!! warn

    This does not apply to Simple AF for RPi, See [Simple AF for RPi](rpi.md#installation)

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow the excellent [Helper Script Enable Root Access](https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access) instructions.

!!! tip

    ZeroDotCmd (aka Zero on discord) has provided an excellent Cartographer installation video, you can find it <https://www.youtube.com/watch?v=GuxMITM9o4I>

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

### Config Overrides

If you have pellcorp-overrides in github but not stored locally, [you need to recreate the /usr/data/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

### Run the installer

To run the script, you must use the following command:

```
/usr/data/pellcorp/installer.sh --install cartotouch --mount Mount
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

    If you have plugged your cartographer into the front usb port, you are going to have to temporarily remove the cartographer from the front usb slot and replace it with your USB thumb drive (aka USB key), after you have finished verifying the USB thumb drive (aka USB key) can be used in an emergency, you can replace the cartographer into the front usb slot and restart klipper or power cycle your printer.

### Calibration

!!! warning

    There are four different calibration steps required to setup a new printer, you must complete them all:

    - [Enable Touch Mode](#enable-touch-mode)
    - [Manual Cartographer Calibrate](#manual-cartographer-calibrate)
    - [Cartographer Threshold Scan](#cartographer-threshold-scan)
    - [Cartographer Touch Calibration](#cartographer-touch-calibration)

If you are running calibration for a printer that has previously been calibrated, the following SAVE_CONFIG sections **must** be removed before
redoing these calibrations:

- `[scanner model default]`
- `[scanner]`
- `[axis_twist_compensation]`
- `[bed_mesh]`

!!! warn

    Please do not remove the `[scanner]` section defined at the end of printer.cfg above the save config section.

#### Enable Touch Mode

To be able to set up the printer for cartographer with touch mode for printing you need to make sure the
mode is set to touch.

1. Run `PROBE_SWITCH MODE=touch`
<br />Upon completion *`SAVE_CONFIG`*

Source: <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/installation/calibration#initial-calibration>

#### Manual Cartographer Calibrate

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Make sure nozzle is centred on bed
5. Run `CARTOGRAPHER_CALIBRATE METHOD=manual`
Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

!!! warn

    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

After the save config you have to do the cartographer threshold scan (see next)

#### Cartographer Threshold Scan

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home All (`G28`)
3. Make sure nozzle is centred on bed
4. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
5. Execute `CARTOGRAPHER_THRESHOLD_SCAN SPEED=2 MIN=1500 MAX=5000`
<br />Upon completion *`SAVE_CONFIG`*

After the save config you have to do the touch calibration.   

#### Cartographer Touch Calibration

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home All (`G28`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Execute `CARTOGRAPHER_CALIBRATE`
<br />Upon completion *`SAVE_CONFIG`*

!!! tip

    If this fails after 3 tries, you should check to make sure there is not filament stuck to the bottom of your nozzle!

**Source:** <https://docs.cartographer3d.com/cartographer-probe/survey-touch>

### Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation calibration **if you are using a rear mount** before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE` The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
<br />Upon completion *`SAVE_CONFIG`*

!!! warn

    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

**Source:** <https://www.klipper3d.org/Axis_Twist_Compensation.html>

### Tuning

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

#### Quick Start

You can use the QUICK_START Macro to do Bed and Nozzle PID Tuning and Input Shaping.

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

### First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your scanner_touch_z_offset using baby stepping, as documented here: <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/installation/first-print>

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

### Other Calibrations

!!! info

    The default value for pressure advance is set to `0.04`

Refer to [Orcaslicer Calibration](https://github.com/SoftFever/OrcaSlicer/wiki/Calibration) for more calibrations

Refer to the [Ellis Print Tuning Guide](https://ellis3dp.com/Print-Tuning-Guide/) for more great tuning ideas.

## Scan Calibration Method

Some cartographer users choose to use scan only instead of touch and that is easy enough to do, you can setup for scan immediately
after installation, no need to do the 3 step calibration as for touch!

You can run the following:

1. Run `PROBE_SWITCH MODE=scan`
   <br />Upon completion *`SAVE_CONFIG`*

It is strongly recommended to disable the camera for this calibration step, just use the `STOP_CAMERA`
macro to do this.

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Make sure nozzle is centred on bed
5. Run `CARTOGRAPHER_CALIBRATE METHOD=manual`
   Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

!!! warn

    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

You can then use the CARTOGRAPHER_MODEL parameter to start print from your slicer to select different filament profiles, this is required if you print with different filaments and/or use different bed aurfaces.

### Cartographer Model

If you want to select a particular [cartographer model](<https://docs.cartographer3d.com/cartographer-probe/fine-tuning/cartographer-models>) other than the default you can pass in an additional `START_PRINT` parameter:

![image](assets/images/carto_model_slicer.png)

You can either hard code it to a particular model, like `CARTOGRAPHER_MODEL=mymodel` or you can specify a model based on orca slicer variables, such as `CARTOGRAPHER_MODEL="[curr_bed_type] - [filament_type]"`, but you have to make sure you have all the possible models
defined for each of the bed type and filament type combinations.

## Troubleshooting

<https://docs.cartographer3d.com/cartographer-probe/troubleshooting>

### Repo has diverged from remote

![image](assets/images/cartographer_repo_diverged.png)

You need to click RECOVER and then run from ssh:

```
~/cartographer-klipper/install.sh
```

### Error during probe mcu identification, check connection

If you get the following error, it means that the cartographer is not connected to the printer.   This is either because its physically not connected, the wiring is wrong, the usb subsystem has disconnected the carto during a restart or the serial id is wrong

![image](assets/images/carto_check_connection.png)

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/carto_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the carto is wired incorrectly, or if was working, it just means that an attempt to restart the carto failed because the K1 refused to recognise it, there is no recourse except to restart the host via Fluidd / Mainsail (or power cycle the printer)

If you can see the carto in lsusb, then you should try to update the serial (see next)

### Manual Cartographer Serial Device configuration

You can run the following command to fix your serial if you forgot to plug your cartographer in during the installation or update:

```
~/pellcorp/installer.sh --fix-serial
```

### Timer too close and microsteps

For cartographer you cannot use more than `microsteps: 32`, the MCU cannot handle high microsteps and cartographer, it puts too much pressure on the system and it will cause stuttering during bed meshes.
