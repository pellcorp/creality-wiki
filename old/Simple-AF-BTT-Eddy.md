**I AM NOT RESPONSIBLE FOR DAMAGE TO YOUR PRINTER - INSTALLING CUSTOM FIRMWARE IS A RISK**

# Donations

If you are looking for a way to support the project, and its entirely optional, this is my preferred approach. I am conducting a fundraiser to purchase a K1M printer, just so I can push out fixes and new features a bit faster, but also specifically test the K1M as well as the K1.

If you can't donate via go fund me directly, I have also added a kofi account.

- https://gofund.me/2033eedb
- https://ko-fi.com/pellcorp49698

# Where can I get help?

Come on over to the pellcorp discord server, here is the invite https://discord.gg/2uGDzyJ3WX

The `#simple-af-btteddy` channel has been setup for anyone wanting support for btt eddy.

# Post Installation Changes for rear mounted btt eddy

**Please note if you are not using ZeroDotCmd side mount you must make post install config changes to btteddy.cfg and btteddy-k1.cfg or btteddy-k1m.cfg before homing your printer or doing a bed mesh!  See [probe installation](#probe-installation) for more details.** 

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

## K1M vs K1/K1C/K1SE

On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

TODO - provide more details

## Side Mount

The configuration assumes you are using this mount from ZeroDotCmd: https://www.printables.com/model/1012524-btteddy-creality-k1-k1c-k1-max-mount which mounts where the lidar normally goes, and you can skip axis twist calibration as its not required.

## Rear Mount

Previously the recommended mount is my rear mount, I do not recommend this anymore, as it requires axis twist, but the mount is:
https://www.printables.com/model/965667-wip-k1-btt-eddy-rear-mount-v4

You will need to enable the alternative config in `btteddy.cfg` and btteddy-k1.cfg or btteddy-k1m.cfg after installation.

If you want a cable bracket for stock then grab ZIMZ excellent cable bracket from here https://www.printables.com/model/783379-zimz-clippy-cartographer-cable-holder

Alternatively you could try this: https://www.printables.com/model/893452-cartographer-cable-guide-for-k1k1-max

# BTT Eddy Firmware

It is assumed that you have flashed your eddy with the firmware from https://github.com/pellcorp/klipper/blob/master/fw/K1/btteddy.uf2
**before** starting the installation!!!

I have put together a guide for flashing the btt eddy [here](https://github.com/pellcorp/creality/wiki/Flashing-BTT-Eddy-on-Ubuntu)

# Installation

The installation can only be performed on a printer which has been rooted and ssh granted

You need root access, if you are not already root, then follow this guide
https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access

ZeroDotCmd (aka Zero on discord) has provided an excellent BTT Eddy installation video, you can find it https://www.youtube.com/watch?v=B17sS1klRxA

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
/usr/data/pellcorp/k1/installer.sh --install btteddy
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

## Troubleshooting

<details>
<summary>Manual BTT Eddy Serial Device configuration</summary>
You may have to update the `[mcu eddy]` section in the btteddy.cfg with the correct btt eddy serial device address.   If the installer was not able to determine the correct serial device, you will see a warning in the installer in that case: `WARNING: There does not seem to be a btt eddy attached - skipping auto configuration`

Open the `btteddy.cfg` in fluidd or mainsail and edit it there if needed.

Find the serial device for the btt eddy, from the command line:
```
ls /dev/serial/by-id/usb-Klipper_rp2040*
```

Then replace the `[mcu eddy]` line from `btteddy.cfg`:

```
serial: /dev/serial/by-id/XXX  # change this based on your device
```

So it should then look something like:

```
serial: /dev/serial/by-id/usb-Klipper_rp2040_45503571288CBAF8-if00
```

Restart klipper if you had to change the `serial` entry.
</details>

## Calibration

**IMPORTANT:** It is extremely important that you perform the following calibrations while the btt eddy is cool, if you calibrate the eddy hot, you will experience `Error during homing z: Eddy current sensor error` errors while homing and performing bed mesh if the btt is significantly cooler than it was while doing initial calibration.   

**Note:** The `BTTEDDY_CALIBRATE_DRIVE_CURRENT`, `BTTEDDY_CURRENT_CALIBRATE` and `BTTEDDY_TEMPERATURE_PROBE_CALIBRATE` macros will turn on the auxiliary fan until the btt eddy temp is less than 30c before starting the actual calibration.  If you are in a hot climate you may need to adjust the `btteddy_macro.cfg` `variable_calibration_max_temp` value to something higher than 30c if you can't get the btt eddy under 30c with the aux fan easily.

### Drive Current Calibration
1. Home XY (`G28 X Y`)
2. Make sure nozzle is centred on bed
3. Enable Force Move (via the button in the UI) to move your printer so that that eddy is about **20mm** above the bed
4. Run `BTTEDDY_CALIBRATE_DRIVE_CURRENT`
5. Run SAVE_CONFIG

**Source:** https://github.com/bigtreetech/Eddy?tab=readme-ov-file#2-drive-current-calibration

### Mapping Eddy Readings To Nozzle Heights

6. Home X and Y (`G28 X Y`)
7. Make sure nozzle is centred on bed
8. Enable Force Move (via the button in the UI) to move your printer so that that the **nozzle** is about **2mm** above the bed.   
9. Run `BTTEDDY_CURRENT_CALIBRATE` (Triggers manual z offset calibration - paper test)
Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
Upon completion *`SAVE_CONFIG`*

**Note:** The reason for the tip of nozzle being about 2mm above the bed is that as part of this calibration we will be temporarily saying that the position the nozzle is at right now is 0Z, so if you try to start your paper test when the nozzle is more than about 2mm above the bed, you might end up triggering a nozzle out of bounds error, if we have to jog the nozzle down more than 5mm for example.

**WARNING:** Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

**Source:** https://github.com/bigtreetech/Eddy?tab=readme-ov-file#3-mapping-eddy-readings-to-nozzle-heights

###  Temperature Compensation Calibration

10. Home X and Y (`G28 X Y`)
11. Make sure nozzle is centred on bed
12. Enable Force Move (via the button in the UI) to move your printer so that that the nozzle is about **2mm** above the bed
13. Run `BTTEDDY_TEMPERATURE_PROBE_CALIBRATE`
Upon completion *`SAVE_CONFIG`*

**WARNING:** Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

**Source:** https://github.com/bigtreetech/Eddy?tab=readme-ov-file#5-temperature-compensation-calibration-eddy-usb-only

## Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation **if you are using a rear mount**  before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE`
The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
Upon completion *`SAVE_CONFIG`*

**WARNING:** Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

**Source:** https://www.klipper3d.org/Axis_Twist_Compensation.html

## First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your `z_offset`.  Note you would think that the `z_offset` in `[probe_eddy_current btt_eddy]` would allow you to adjust the z offset for a nice first layer, but it seems like the z_offset does not work that way for btt eddy, so we are using the save-zoffset hack originally from Helper Script for btt eddy until such time as the z_offset does actually work correctly.

## Bed Mesh

Now you can now run your first bed mesh:
`BED_MESH_CALIBRATE`

**Source:** https://ballaswag.github.io/blog/creality-k1-btt-eddy-guide/
**Source:** https://github.com/bigtreetech/Eddy

### Error during homing z: Eddy current sensor error

You might need to adjust your `reg_drive_current`, for more details:
https://github.com/bigtreetech/Eddy?tab=readme-ov-file#sometimes-i-get-error-during-homing-probe-eddy-current-sensor-error

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

Octoeverywhere cannot be installed onto the K1 when running the BTT Eddy, the stress placed on the system by running octoeverywhere is too great, however the octoeverywhere companion running on another device on the same WIFI network as the K1 works great.

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
