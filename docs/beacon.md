## Where can I get help?

Come on over to the pellcorp discord server, here is the invite, the `#simple-af-beacon` channel has been setup for anyone wanting support for beacon.

[![invite](assets/images/invite.png '#simple-af-beacon')](https://discord.gg/2uGDzyJ3WX)

## Thanks

Thanks to <https://raven3dtech.com.au/> and <https://beacon3d.com> for donating Beacon probes to the Simple AF project to add support and continue to support the Beacon.

## Firmware requirements

This guide assumes you have a K1, K1C or K1 Max and you are running stock creality firmware 1.3.3.5 or higher, or alternately you are using  [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

## Slicer Settings

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

    If you are not using a side mount you **must** verify config changes for beacon.cfg and beacon-k1.cfg 
    or beacon-k1m.cfg before homing your printer, using **Screws Tilt Calculate** or doing a **bed mesh**!  

    Ignoring these instructions can lead to significant damage to your build plate and/or probe.

### Mount Options

| Mount           | Beacon           | URL                                                                                          |Notes|
|-----------------|------------------|----------------------------------------------------------------------------------------------|----------|
| **PurcellV4**   | RevH Standard    | <https://www.printables.com/model/1071641-beacon-probe-mounts-for-creality-k1-series>        ||
| **SkeletorMK7** | RevH Low Profile | <https://www.printables.com/model/833769-the-skeletor-collection-a-creality-k1k1-maxk1c-coo> |This is only for the low profile cartographer version of the mount!!!|

### Nozzle Offset

!!! warning
    It is vital that you verify the model to nozzle tip distance is within the valid range of 2.6 to 3mm.  
    Anything out of this range will cause you problems when it comes time to doing the touch calibration, you can use this tool to verify:
    
    <https://www.printables.com/model/1060868-cartographer-probe-nozzle-offset-tool>

    Or for side mounted probes you may want to consider this version:

    <https://www.printables.com/model/1121309-cartographer-probe-nozzle-offset-tool-x-offset>

### K1M vs K1/K1C/K1SE

!!! info

    On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

## Beacon Firmware

!!! warning
    You must have flashed your beacon with the latest beacon firmware (2.1.0 currently) **before** starting the installation

    There is a guide for this [here](beacon_flashing.md)

## Installation

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow [Helper Script Enable Root Access](https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access)

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
/usr/data/pellcorp/k1/installer.sh --install beacon --mount Mount
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

### Timer too close and microsteps

For beacon you cannot use more than `microsteps: 32`, the MCU cannot handle both more microsteps and beacon, it puts too much pressure on the system and it will throw timer too close during bed meshes.

### Troubleshooting 

#### Manual Beacon Serial Device configuration


You can run the following command to fix your serial if you forgot to plug your beacon in during the installation or update:

```
/usr/data/pellcorp/k1/installer.sh --fix-serial
```

#### 'BeaconProbe' object has no attribute '_mcu_freq'

This indicates the beacon was disconnected during homing or some other operation, you need to reboot 

![image](assets/images/beacon_mcu_freq.png)

### Calibration

1. Home X Y (`G28 X Y`
2. Run `BEACON_CALIBRATE` Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
<br />Upon completion *`SAVE_CONFIG`*

**Source:** [Calibrate Beacon](https://docs.beacon3d.com/quickstart/#6-calibrate-beacon)

### First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your `cal_nozzle_z` using baby stepping.

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

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
