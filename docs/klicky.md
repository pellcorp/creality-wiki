# Where can I get help?

Come on over to the pellcorp discord server, here is the invite https://discord.gg/2uGDzyJ3WX

The `#simple-af-support` channel has been setup for anyone wanting support for klicky.

# Firmware requirements

This guide assumes you have a K1, K1C or K1 Max and you are running stock creality firmware 1.3.3.5 or higher, or alternately you are using  [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

# Slicer Settings

There is an assumption that you are using a slicer like OrcaSlicer and Machine G-code like:

![image](https://github.com/user-attachments/assets/94a54935-6a30-411c-8b8c-3b54b4e9d3bc)

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

## Custom Bed Mesh Profile

If you want to select a specific predefined bed mesh profile, you can pass in an additional `START_PRINT` parameter:

You can either hard code it to a particular model, like `BED_MESH_PROFILE=myprofile` or you can specify a profile based on orca slicer variables, such as `BED_MESH_PROFILE="[curr_bed_type] - [filament_type]"`, but you have to make sure you have all the possible profiles
defined for each of the bed type and filament type combinations.

![image](https://github.com/user-attachments/assets/6bc0f01e-6bd4-4e0b-9031-a2b41c1d6a02)


# Probe Installation

# Installation

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow this guide
https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access

## Factory Reset 

You **must** do a factory reset before running the installer.sh.   Follow these steps to do a factory reset, which retains root access and skips the startup calibration checks:

```
wget --no-check-certificate  https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S58factoryreset
chmod +x S58factoryreset
./S58factoryreset reset
```
**IMPORTANT:** It is really important you do not close the ssh session until you get the message `Info: Factory reset was executed successfully, the printer will restart...`:

![image](https://github.com/user-attachments/assets/1f21f1d4-ee5b-4263-a7e5-586a4dc5cf4c)

## Clone the Repo

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
sync
```

<details>
<summary>RPC Timeouts, try SSH Git Clone</summary>
<pre>
mkdir -p /root/.ssh
wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/git-ssh.sh" -O /root/git-ssh.sh
chmod 777 /root/git-ssh.sh
wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/pellcorp-identity" -O /root/.ssh/pellcorp-identity
export GIT_SSH_IDENTITY=pellcorp
export GIT_SSH=/root/git-ssh.sh
git clone git@github.com:pellcorp/creality.git /usr/data/pellcorp
cd /usr/data/pellcorp && git remote set-url origin https://github.com/pellcorp/creality.git && cd
</pre>
</details>

## Config Overrides

If you have pellcorp-overrides in github but not stored locally, [you need to recreate the /usr/data/pellcorp-overrides directory](Configuration-Overrides#create-local-repo) before running the installer.sh!

## Run the installer

To run the script, you must specify the probe you want to use.

```
/usr/data/pellcorp/k1/installer.sh --branch jp_klicky
/usr/data/pellcorp/k1/installer.sh --install klicky
```

<details>
<summary>RPC failed; curl 18 transfer closed</summary>
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
</details>

# Post Installation

## MCU Firmware updates are pending

At the end of the installer process if you get this message:

```
WARNING: MCU Firmware updates are pending you need to power cycle your printer!
```

It means that new MCU firmware updates need to be applied and this can only be done by power cycling the printer.  After your printer is power cycled you can verify firmware was updated with the `CHECK_FIRMWARE` macro from Fluidd or Mainsail, if you see this message:

```
INFO: Your MCU Firmware is up to date!
```

Your printer MCU firmware was updated successfully.   If you still see the `MCU Firmware updates are pending you need to power cycle your printer!` message after a power cycle, check the `/tmp/mcu_update.log`, you may be asked to provide this file on Discord if you need additional assistance, sometimes an additional power cycle can solve the problem, there is a very short window of time (15 seconds) in which the MCU firmware can be updated, so  there is a chance it will work after an additional power cycle.

## Verify USB Key

It is important to make sure you have a way to [emergency factory reset](#emergency-factory-reset) the printer, if the worst happens.   There is a macro in Simple AF called `CHECK_USB_KEY` that will wait for you to plug a USB key in and tell you if it was able to be successfully mounted.   You should verify your USB key often just to make sure you have something if you need to unbrick your printer, simply type `CHECK_USB_KEY` or hit the button in Fluidd / Mainsail

![image](https://github.com/user-attachments/assets/cdd90e6d-2d61-48fb-8624-818190604ac4)

If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB is perfect to use for a factory reset.   If you get no message at all before the script ends (after 60 seconds), your USB is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

## Calibration

TODO

## First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your probe z offset using baby stepping.

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](https://github.com/user-attachments/assets/2af8d5cb-091e-40df-a38c-25d43b2e6647)

## Timer too close and microsteps

For microprobe, etc you cannot use more than `microsteps: 64`.

## Tuning

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

### Quick Start

You can use the QUICK_START Macro to automatically complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

### Pid Tuning

https://www.klipper3d.org/Config_checks.html?h=pid#calibrate-pid-settings

For example you might run these:

```
PID_CALIBRATE_BED BED_TEMP=65
PID_CALIBRATE_HOTEND HOTEND_TEMP=230
```

**Note:** The `PID_CALIBRATE_BED` and `PID_CALIBRATE_HOTEND` macros are located in the `useful_macros.cfg` file and they have defaults
values for BED_TEMP and HOTEND_TEMP so you can just run them by clicking on them if you want that same temperature.

### Input Shaping

There is no default configuration for input shaping so it is essentially disabled out of the box.

You can use the `SHAPER_CALIBRATE` macro to run input shaping, just be sure to `SAVE CONFIG` at the end, to choose the automatically selected shaper config, be aware though that the shaper chosen might be sub-optimal due to a slight difference in vibrations between two options.  So you should probably review the output and potentially choose an alternative if it gives you higher recommended max acceleration for minimal increase in vibration.

https://www.klipper3d.org/Measuring_Resonances.html#input-shaper-auto-calibration

## Other Calibrations

**Note:** The default value for pressure advance is set to: `0.04`

Refer to https://github.com/SoftFever/OrcaSlicer/wiki/Calibration for more calibrations

This is an excellent resource for all things 3d print tuning:
https://ellis3dp.com/Print-Tuning-Guide/

# Octoeverywhere Companion

See [Octoeverywhere Companion](Simple-AF#octoeverywhere-companion)

# Moonraker Timelapse

See [Moonraker Timelapse](Simple-AF#moonraker-timelapse)

# Configuring Timezone

See [Configuring Timezone](Simple-AF#configuring-timezone)

# Updating

See [Updating](Simple-AF#updating)

# Reinstalling

See [Reinstalling](Simple-AF#reinstalling)

# Emergency Factory Reset

See [Emergency Factory Reset](Simple-AF#emergency-factory-reset)
