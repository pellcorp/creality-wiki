## Where can I get help?

Come on over to the pellcorp discord server, the `#simple-af-carto` channel has been setup for anyone wanting support for cartographer.

[![invite](assets/images/invite.png '#simple-af-carto')](https://discord.gg/2uGDzyJ3WX)

## Thanks

Thanks to Richard from <https://cartographer3d.com> and Zarboz from <https://wattskraken.xyz/> for donating Cartographers to the Simple AF project to add support and continue to support the cartographer.

## Firmware requirements

!!! warning

    This guide assumes you have a K1, K1C or K1 Max and you are running stock creality firmware 1.3.3.5 or higher, or alternately you are using  [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

## Slicer Settings

!!! warning

    If you have used a cartographer with k1-klipper, please note that the `PRINT_START` macro specified in their docs **is not supported** by this project.   You **must** change your Slicer Start Print Machine G-Code (see next)

There is an assumption that you are using a slicer like OrcaSlicer and Machine G-code like:

![image](assets/images/slicer.png)

**Machine start G-code**

```
M104 S0 ; Stops OrcaSlicer from sending temp waits separately
M140 S0
START_PRINT EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single]
```

**Machine end G-code**

```
END_PRINT
```

## Probe Installation

!!! danger

    If you are not using a side mount you **must** verify config changes for cartotouch.cfg and cartographer-k1.cfg 
    or cartographer-k1m.cfg before **homing your printer**, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount           |Carto| URL                                                                                                                  |Notes|
|-----------------|-----------|----------------------------------------------------------------------------------------------------------------------|----------|
| **Default**     |Right Angle| <https://www.printables.com/model/1037606-cartographer-3d-right-angle-k1-series-mount>                               ||
| **D3vilStock**  |Flat Pack  | <https://www.printables.com/model/684338-k1-k1max-eddy-current-mount-cartographer>                                   ||
| **BootyGantry** |Right Angle| <https://github.com/tlace17/K1-Linear-Rail-Gantry/blob/main/STLs/Probe%20Mounts/Rail%20Carriage%20Carto%20Mount.stl> |May require shimming for correct nozzle offset|
| **SkeletorMK7** |Low Profile| <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo>                         |This is only for the low profile cartographer version of the mount!!!|
| **PurcellV5**   |Right Angle| <https://www.printables.com/model/1071493-cartographer-probe-side-mount-options-for-creality>                        ||

### Nozzle Offset

!!! warn

    It is vital that you verify the model to nozzle tip distance is within the valid range of 2.6 to 3mm.  Anything out of this range will cause you problems when it comes time to doing the touch calibration, you can use this tool to verify:

    <https://www.printables.com/model/1060868-cartographer-probe-nozzle-offset-tool>

    Or for side mounted probes you may want to consider this version:

    <https://www.printables.com/model/1121309-cartographer-probe-nozzle-offset-tool-x-offset>

### K1M vs K1/K1C/K1SE

!!! info

    On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

## Cartographer Firmware

!!! warning

    You must have flashed your cartographer with `CARTOGRAPHER K1 5.1.0` survey firmware **before** starting the installation:

    ![image](assets/images/cartographer_k1_510.png)

    There is a guide for this [here](cartographer_flashing.md)

## Installation

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow the excellent [Helper Script Enable Root Access](https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access) instructions.

!!! tip

    ZeroDotCmd (aka Zero on discord) has provided an excellent Cartographer installation video, you can find it <https://www.youtube.com/watch?v=GuxMITM9o4I>

### Factory Reset 

You **must** do a factory reset before running the installer.sh.   Follow these steps to do a factory reset, which retains root access and skips the startup calibration checks:

```
wget --no-check-certificate  https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S58factoryreset
chmod +x S58factoryreset
./S58factoryreset reset
```

!!! warn

    It is really important you do not close the ssh session until you get this message:

    ![image](assets/images/factory_reset.png)

### Clone the Repo

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
sync
```

??? note "RPC Timeouts, try SSH Git Clone"
    ```
    mkdir -p /root/.ssh
    wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/git-ssh.sh" -O /root/git-ssh.sh
    chmod 777 /root/git-ssh.sh
    wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/pellcorp-identity" -O /root/.ssh/pellcorp-identity
    export GIT_SSH_IDENTITY=pellcorp
    export GIT_SSH=/root/git-ssh.sh
    git clone git@github.com:pellcorp/creality.git /usr/data/pellcorp
    cd /usr/data/pellcorp && git remote set-url origin https://github.com/pellcorp/creality.git && cd
    ```

### Config Overrides

If you have pellcorp-overrides in github but not stored locally, [you need to recreate the /usr/data/pellcorp-overrides directory](config_overrides.md#create-local-repo) before running the installer.sh!

### Run the installer

To run the script, you must use the following command:

```
/usr/data/pellcorp/k1/installer.sh --install cartotouch --mount Mount
```

!!! tip

    For `Mount` you need to specify the mount option your have used, please refer to [Mount Options](#mount-options).   

    If you are using a non-supported mount you should skip the `--mount` option and adjust your configuration after installation before trying to perform a bed mesh or Screws Tilt Calculate!

??? note "RPC failed; curl 18 transfer closed"

    You might get this error:

    ```
    error: RPC failed; curl 18 transfer closed with outstanding read data remaining
    fatal: the remote end hung up unexpectedly
    fatal: early EOF
    fatal: index-pack failed
    ```
    
    Just rerun the installer.sh script (with the same probe argument), it will start from the stage that failed (most of the time this
    will be the Installing Klipper stage!)
    
    You can also prefix the installer command with `AF_GIT_CLONE=ssh` to force git to clone via ssh, this will take a **lot** longer, but it will never time out, so its good in a pinch if you are getting repeated klipper repo clone failures.

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

!!! tip

    You should verify your USB key often just to make sure you have something if you need to unbrick your printer, simply type `CHECK_USB_KEY` or hit the button in Fluidd / Mainsail

It is important to make sure you have a way to [emergency factory reset](misc.md#emergency-factory-reset) the printer, if the worst happens.   There is a macro in Simple AF called `CHECK_USB_KEY` that will wait for you to plug a USB key in and tell you if it was able to be successfully mounted.

![image](assets/images/check_usb_key.png)

- If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB is perfect to use for a factory reset.
- If you get no message at all before the script ends (after 60 seconds), your USB is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

### Calibration

Please make sure to remove any scanner related config from the save config section at the bottom of printer.cfg and save and restart before re-calibrating.

#### Recalibrating

If you are recalibrating, the follow SAVE_CONFIG sections should be removed:

- [scanner model default]
- [scanner]

!!! warn

    Please do not remove the `[scanner]` section defined at the end of printer.cfg above the save config section.

#### Manual Cartographer Calibrate

It is a good idea to heat the nozzle to 150c for this step first!

1. Home X Y (`G28 X Y`)
2. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
3. Make sure nozzle is centred on bed
4. Run `CARTOGRAPHER_CALIBRATE METHOD=manual`
Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

!!! warn

    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

After the save config you have to do the cartographer threshold scan (see next)

#### Cartographer Threshold Scan

**WARNING:** For this next step, it is really important to be near your printer for this step, because if there
is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

6. Home All (`G28`)
7. Make sure nozzle is centred on bed
8. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
9. Execute `CARTOGRAPHER_THRESHOLD_SCAN SPEED=2 MIN=1500 MAX=5000`
<br />Upon completion *`SAVE_CONFIG`*

After the save config you have to do the touch calibration.   

#### Cartographer Touch Calibration

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

10. Home All (`G28`)
11. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
12. Execute `CARTOGRAPHER_CALIBRATE`
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

You can use the QUICK_START Macro to automatically complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

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

### Other Calibrations

!!! info

    The default value for pressure advance is set to `0.04`

Refer to [Orcaslicer Calibration](https://github.com/SoftFever/OrcaSlicer/wiki/Calibration) for more calibrations

Refer to the [Ellis Print Tuning Guide](https://ellis3dp.com/Print-Tuning-Guide/) for more great tuning ideas.

## Troubleshooting

<https://docs.cartographer3d.com/cartographer-probe/survey-touch/survey-troubleshooting>

### Repo has diverged from remote

![image](assets/images/cartographer_repo_diverged.png)

You need to click RECOVER and then run from ssh:

```
/usr/data/cartographer-klipper/install.sh
```

### Error during probe mcu identification, check connection

If you get the following error, it means that the cartographer is not connected to the printer.   This is either because its physically not connected, the wiring is wrong, the usb subsystem has disconnected the carto during a restart or the serial id is wrong

![image](assets/images/carto_check_connection.png)

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/carto_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the carto is wired incorrectly, or if was working, it just means that an attempt to restart the carto failed because the K1 refused to recognise it, there is no recourse except to Reboot the printer via Fluidd / Mainsail in this case.

If you can, then verify that the serial id matches:

![image](assets/images/carto_serial.png)

Make sure it matches the `serial` in `cartotouch.cfg`:

![image](assets/images/carto_scanner_serial.png)

### Manual Cartographer Serial Device configuration

You can run the following command to fix your serial if you forgot to plug your cartographer in during the installation or update:

```
/usr/data/pellcorp/k1/installer.sh --fix-serial
```

### Timer too close and microsteps

For cartographer you cannot use more than `microsteps: 32`, the MCU cannot handle high microsteps and cartographer, it puts too much pressure on the system and it will cause stuttering during bed meshes.
