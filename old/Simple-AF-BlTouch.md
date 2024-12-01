**I AM NOT RESPONSIBLE FOR DAMAGE TO YOUR PRINTER - INSTALLING CUSTOM FIRMWARE IS A RISK**

# Donations

If you are looking for a way to support the project, and its entirely optional, this is my preferred approach. I am conducting a fundraiser to purchase a K1M printer, just so I can push out fixes and new features a bit faster, but also specifically test the K1M as well as the K1.

If you can't donate via go fund me directly, I have also added a kofi account.

- https://gofund.me/2033eedb
- https://ko-fi.com/pellcorp49698

# Where can I get help?

Come on over to the pellcorp discord server, here is the invite https://discord.gg/2uGDzyJ3WX

The `#simple-af-support` channel has been setup for anyone wanting support for bltouch, crtouch or 3dtouch.

# What about CrTouch and 3dTouch

Yep you can use a CrTouch or 3dTouch as an alternative to a BlTouch, however I have not personally used either of these with a K1 and so I can't currently provide detailed guidance on what config is required.   I also think 3dTouch might require slightly different wiring.

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

# Probe Installation

## Bltouch Rear Mounted

The Simple AF installer assumes you are using a rear mounted bltouch, and this mount: https://www.printables.com/model/666186-creality-k1-bltouch-adapter

|File                |Section |Key     |Value|
|--------------------|--------|--------|-----|
|bltouch.cfg      |bltouch |x_offset|0.0|
|                    |        |y_offset|25.25|
|bltouch-k1.cfg |bed_mesh|mesh_min|5,30|
|                    |        |mesh_max|210,209|
|bltouch-k1m.cfg|bed_mesh|mesh_min|5,30|
|                    |        |mesh_max|285,280|

## CR-Touch Side mount

If you have a CR-Touch you can try this side mount:
https://www.printables.com/model/1073375-cr-touch-mount-k1-k1maxk1c-zero-y-offset

|File                |Section |Key     |Value|
|--------------------|--------|--------|-----|
|bltouch.cfg      |bltouch |x_offset|-37.0|
|                    |        |y_offset|0.0|
|bltouch-k1.cfg |bed_mesh|mesh_min|3,5|
|                    |        |mesh_max|192,215|
|bltouch-k1m.cfg|bed_mesh|mesh_min|TBD|
|                    |        |mesh_max|TBD|

## Wiring

The probe and the TOUCH port on the Nozzle MCU board both mate with a 5-pin Molex Picoblade connector. A 5-pin cable is needed to connect the probe to the TOUCH port.

Some sellers may call the connector "Micro JST SH 1.25" but that is [incorrect](https://www.reddit.com/r/AskElectronics/comments/m6mibq/comment/gr6w1m0). Several premade cables are compatible. Most notably the Creality cable for their CR Touch probe:
- https://www.aliexpress.us/item/1005004960067376.html
- https://www.amazon.com/dp/B0BKPFY24M/
- https://www.bastelgarage.ch/0-1m-creality-cr-touch-bl-touch-adapterkabel-sprite-extruder

Alternatively, two pre-crimped cables can be soldered together:
- https://www.amazon.de/dp/B0BNF6J1RJ

Or a cable built from pre-crimped wires and connector housings:
- https://www.amazon.de/dp/B08RMQP6YP

![image-1.png](image/image-1.png)

![image.png](image/image.png)

Connect to TOUCH port on the nozzle MCU. it is accessible from the side left (LIDAR) side of the printhead and only the external cover of the printhead has to be removed.

![image-2.png](image/image-2.png)

![350822478-cf895537-a1a1-449b-8456-1730aab4fe25](https://github.com/user-attachments/assets/6d496572-adb7-4362-b465-4d92c5b7d44c)

**IMPORTANT:** The configuration file assumes a bltouch is mounted on the back of the tool head.   If you have a Crtouch or are mounting your bltouch or 3dtouch using a different model, you must make additional changes to the bltouch-k1.cfg or bltouch-k1m.cfg files before trying to home your printer.

**Source:** Portions of this section are copied from the K1 Bltouch guide for helper script.

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
/usr/data/pellcorp/k1/installer.sh --install bltouch
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

Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
Upon completion *`SAVE_CONFIG`*

For the bltouch/3dtouch/crtouch it is **extremely** important to do the PROBE_CALIBRATE step to configure your z-offset, regardless of what model you have used to mount the probe!

![image](https://github.com/user-attachments/assets/47415841-f915-4767-a971-01811164ee79)

**Note:** The default z-offset for BLTouch, 3dTouch and CrTouch is 0, so your prints won't stick without doing this step.

as in it will try to dig a hole into the bed.

## Timer too close and microsteps

For bltouch, etc you cannot use more than `microsteps: 64`.

## Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation calibration before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE`
The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
Upon completion *`SAVE_CONFIG`*

**Source:** https://www.klipper3d.org/Axis_Twist_Compensation.html

## First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your probe z offset using baby stepping.

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](https://github.com/user-attachments/assets/2af8d5cb-091e-40df-a38c-25d43b2e6647)

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

Octoeverywhere can be installed onto the K1 when running the BlTouch, CrTouch or 3dTouch.  However it is strongly recommend that you do not do this as the stress placed on the system by running octoeverywhere is significant.  The octoeverywhere companion running on another device on the same WIFI network as the K1 works great.

https://blog.octoeverywhere.com/octoeverywhere-companion-remote-access-for-any-klipper-printer/

# Moonraker Timelapse

Moonraker timelapse is installed but not enabled by default.  To enable it there are a few steps, you need to add the following include to printer.cfg:

```
[include timelapse.cfg]
```

And uncomment the `[include timelapse.conf]` in moonraker.conf, you will need to restart moonraker **and** klipper after this, you can that via the fluidd or mainsail services section.

If you see these messages:

```
 15:14:24  // Unknown command:"_SET_TIMELAPSE_SETUP"
15:14:24  // Unknown command:"HYPERLAPSE"
```
It means you have not as yet properly restarted moonraker and/or klipper.    If in doubt just power cycle your machine.

# Configuring Timezone

The /etc/init.d/S58factoryreset has recently been updated not to delete the /etc/localtime, so you can configure it once and it should survive any number of factory resets, following the excellent guide here:
https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/change-date-and-time/

# Updating

To update your installation with the latest fixes you should run:

```
/usr/data/pellcorp/k1/installer.sh --update-repo
/usr/data/pellcorp/k1/installer.sh --update
```

This backs up your customisations, updates the creality repo, applies all changes to your `/usr/data/printer_data/config` directory and then reapplies your customisations over the top.

Refer to [Update or Reinstall - What gets overriden](Simple-AF-Update-or-Reinstall)

# Reinstalling

A reinstall is only needed if you are switching probes or one or more github repos have got into an inconsistent state, so you can force a reinstall with the `--reinstall` argument in place of the `--install` argument.  The difference to a `--install`, is a `--install` will only finish up a partial install that failed due to a network failure or the like.

Refer to [Update or Reinstall - What gets overriden](Simple-AF-Update-or-Reinstall)

# Emergency Factory Reset

If the worst happens and you somehow get locked out (for instance for whatever reason the dropbear ssh session does not start or wifi config gets all screwy, it is possible to trigger a emergency factory reset.

It is very easy, you just need to create a empty file called `emergency_factory_reset` on a USB key and make sure the USB key is plugged in, then power cycle the printer, this will initiate a factory reset.

**IMPORTANT:** This factory reset method will rename the `emergency_factory_reset` to `emergency_factory_reset.old` to avoid a boot loop, so if you need to use this method again you will need to rename the file.

**IMPORTANT:** This factory reset method will **not** remove the special service file `/etc/init.d/S58factoryreset` from the k1, so if you need it you can redo a factory reset even before reinstalling.

**Note:** This method does not reset wifi or root access
