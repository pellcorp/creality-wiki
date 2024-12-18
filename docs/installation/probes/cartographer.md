---
title: Cartographer Probe
---

# Cartographer

??? danger

    **I am not responsible for damage to ytour printer. - Installing custom firmware is a risk!**

### Donations
If you are looking for a way to support the project, and its entirely optional, this is my preferred approach. I am conducting a fundraiser to purchase a K1M printer, just so I can push out fixes and new features a bit faster, but also specifically test the K1M as well as the K1.

If you can't donate via go fund me directly, I have also added a kofi account.

[Go fund](https://gofund.me/2033eedb)

[Ko-fi](https://ko-fi.com/pellcorp49698)

## Where can I get help?
Come on over to the pellcorp discord server, here is the [invite](https://discord.gg/2uGDzyJ3WX)

The `#simple-af-carto` channel has been setup for anyone wanting support for cartographer.

!!! note

    ### Thanks
    Thanks to Richard from https://cartographer3d.com and Zarboz from https://wattskraken.xyz/ for donating Cartographers to the Simple AF project to add support and continue to support the cartographer.

## Post Installation Changes for rear mounted cartographer
Please note if you are not using `ZeroDotCmd` side mount you must make post installation config changes to cartotouch.cfg and cartographer-k1.cfg or cartographer-k1m.cfg before homing your printer or performing a bed mesh!  See [probe installation](#probe-installation) for more details.

## Firmware requirements
This guide assumes you have a K1, K1C or K1 Max and you are running stock creality firmware 1.3.3.5 or higher, or alternately you are using  [my prerooted firmware](https://github.com/pellcorp/creality/wiki/Prerooted-K1-Firmware).   Any other pre-rooted firmware is explicitly not supported and the installer.sh will validate this and refuse to proceed if you try to use it on different firmware.

## Slicer Settings
!!! warning

     If you have used a cartographer with k1-klipper, please note that the `PRINT_START` macro specified in their docs **is not supported** by this project.   You **must** change your Slicer Start Print Machine G-Code (see next)

There is an assumption that you are using a slicer like OrcaSlicer and Machine G-code like:

![image](https://github.com/user-attachments/assets/94a54935-6a30-411c-8b8c-3b54b4e9d3bc)

#### Machine start G-code
```
M104 S0 ; Stops OrcaSlicer from sending temp waits separately
M140 S0
START_PRINT EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single]
```

#### Machine end G-code
```
END_PRINT
```

## Cartographer Model
If you want to select a particular [cartographer model](https://docs.cartographer3d.com/cartographer-probe/fine-tuning/cartographer-models) other than the default you can pass in an additional `START_PRINT` parameter:

![image](https://github.com/user-attachments/assets/7bb0072f-17ef-4ef3-8463-238e7fbdf7d9)

You can either hard code it to a particular model, like `CARTOGRAPHER_MODEL=mymodel` or you can specify a model based on orca slicer variables, such as `CARTOGRAPHER_MODEL="[curr_bed_type] - [filament_type]"`, but you have to make sure you have all the possible models
defined for each of the bed type and filament type combinations.

## Probe Installation

### K1M vs K1/K1C/K1SE
On a K1M you can use the lidar cable either directly by repinning it, or via the pass through lidar port on the toolhead.  However you cannot use the lidar port on the toolhead for K1, K1C or K1SE.   The reason this does not work is because for Lidar on the K1M creality actually routes a completely separate USB cable from the mainboard.

TODO - provide more details

### Default Side Mount
The configuration assumes you are using this mount from ZeroDotCmd: https://www.printables.com/model/1037606-cartographer-3d-right-angle-k1-series-mount which mounts where the lidar normally goes, and you can skip axis twist calibration as its not required.   **This mount requires the right angle cartographer, not the flat pack!**

!!! tip
     Make sure to use a flathead/flush screw heads so they don't protrude towards the bed. It is recommended to snip the soldered pins sticking through the coil plate so they are closer to the coil plate.

<details markdown>
<summary>Configuration Changes Required</summary>

!!! warning
    The following configuration changes are used for this mount, but they are also the defaults so if you have this mount you should not need to change anything.   Please note that I do not have a K1M printer, so especially for screw tilt adjust these are guesses.


|File                |Section |Key     |Value|
|--------------------|--------|--------|-----|
|printer.cfg         |stepper_y|position_max|226 (K1) or 306 (K1M)|
|cartotouch.cfg      |scanner |x_offset|-16.0|
|                    |        |y_offset|0.0|
|cartographer-k1.cfg |bed_mesh|mesh_min|10,10|
|                    |        |mesh_max|210,215|
|                    |screws_tilt_adjust|screw1|42,20|
|                    |                  |screw2|211,20|
|                    |                  |screw3|211,190|
|                    |                  |screw4|42,190|
|cartographer-k1m.cfg|bed_mesh|mesh_min|10,10|
|cartographer-k1m.cfg|        |mesh_max|290,280|
|                    |screws_tilt_adjust|screw1|35,23|
|                    |                  |screw2|294,23|
|                    |                  |screw3|264,272|
|                    |                  |screw4|64,272|
</details>

## D3vil Design Mount 

If you have a flat pack cartographer, then you need to use the D3vil Design:
https://www.printables.com/model/684338-k1-k1max-eddy-current-mount-cartographer

For the default mount which uses a flat pack, you will need to follow the [Assembly Manual](https://docs.google.com/document/d/1iOOGeqHqNmlJenYUOr2cGRdccpGq-NLx-ezH2wCMzag/edit?usp=sharing), this is not required for the right angle carto if using the Zero mount (see below)

<details markdown>
<summary>Configuration Changes Required</summary>

!!! warning
    The following configuration changes are used for this mount.  Please note that I do not have a K1M printer, so especially for screw tilt adjust these are guesses.

|File                |Section |Key     |Value|
|--------------------|--------|--------|-----|
|printer.cfg         |stepper_y|position_max|210 (K1) or 290 (K1M)|
|cartotouch.cfg      |scanner |x_offset|0.0|
|                    |        |y_offset|16.86|
|cartographer-k1.cfg |bed_mesh|mesh_min|30,25|
|                    |        |mesh_max|210,210|
|                    |screws_tilt_adjust|screw1|25,3|
|                    |                  |screw2|195,3|
|                    |                  |screw3|195,173|
|                    |                  |screw4|25,173|
|cartographer-k1m.cfg|bed_mesh|mesh_min|10,22|
|                    |        |mesh_max|290,280|
|                    |screws_tilt_adjust|screw1|19,6|
|                    |                  |screw2|278,6|
|                    |                  |screw3|248,255|
|                    |                  |screw4|48,255|
</details>

### Cable Bracket

If you want a cable bracket for stock then grab it from here https://www.printables.com/model/783379-zimz-clippy-cartographer-cable-holder

Alternatively you could try this: https://www.printables.com/model/893452-cartographer-cable-guide-for-k1k1-max

## Booty Gantry Mount 

You can get the booty gantry mount from here:
https://github.com/tlace17/K1-Linear-Rail-Gantry/tree/main/STLs/Probe%20Mounts

If you are using the booty gantry mount, please make sure you verify that the nozzle to coil offset is between 2.5mm and 3.0mm, you may need
to shim it to get it within range!   At least a 0.5mm spacer might be required to move the Carto closer to the bed.

To verify the nozzle offset of the carto you can use this model recommended by the cartographer team:
https://www.printables.com/model/1060868-cartographer-probe-nozzle-offset-tool

<details markdown>
<summary>Configuration Changes Required</summary>

!!! warning
    The following configuration changes are used for this mount.  Please note that I do not have a Booty Gantry or a K1M, so especially for screw tilt adjust these are guesses.

|File                |Section |Key     |Value|
|--------------------|--------|--------|-----|
|printer.cfg         |stepper_y|position_max|210 (K1) or 290 (K1M)|
|cartotouch.cfg      |scanner |x_offset|0.0|
|                    |        |y_offset|20.0|
|cartographer-k1.cfg |bed_mesh|mesh_min|20,20|
|                    |        |mesh_max|200,200|
|                    |screws_tilt_adjust|screw1|25,0|
|                    |                  |screw2|195,0|
|                    |                  |screw3|195,170|
|                    |                  |screw4|25,170|
|cartographer-k1m.cfg|bed_mesh|mesh_min|20,20|
|                    |        |mesh_max|280,280|
|                    |screws_tilt_adjust|screw1|19,3|
|                    |                  |screw2|278,3|
|                    |                  |screw3|248,252|
|                    |                  |screw4|48,252|
</details>

## Cartographer Firmware
You must have flashed your cartographer with `5.0.0 K1` survey firmware **before** starting the installation:
![image](https://github.com/user-attachments/assets/0967087c-c874-4e74-94b6-8b8b77dc622c)

There is a guide for this [here](https://github.com/pellcorp/creality/wiki/Flashing-Carto-Firmware-on-Ubuntu)

## Installation
The installation can only be performed on a printer which has been rooted and ssh granted

!!! info
    You need root access, if you are not already root, then follow this [guide](https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/install-and-update-rooted-firmware-k1/#enable-root-access)

### Factory Reset 

You **must** do a factory reset before running the installer.sh.   Follow these steps to do a factory reset, which retains root access and skips the startup calibration checks:

``` { .yaml py title="namefile.py" hl_lines="1-2"}
wget --no-check-certificate  https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S58factoryreset
chmod +x S58factoryreset
./S58factoryreset reset
```

!!! abstract
    It is really important you do not close the ssh session until you get the message:
    `Info: Factory reset was executed successfully, the printer will restart...`

![image](https://github.com/user-attachments/assets/1f21f1d4-ee5b-4263-a7e5-586a4dc5cf4c)

### Clone the Repo

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
sync
```

<details markdown>
<summary>RPC Timeouts, try SSH Git Clone</summary>
```mkdir -p /root/.ssh
wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/git-ssh.sh" -O /root/git-ssh.sh
chmod 777 /root/git-ssh.sh
wget --no-check-certificate "https://raw.githubusercontent.com/pellcorp/creality/main/k1/ssh/pellcorp-identity" -O /root/.ssh/pellcorp-identity
export GIT_SSH_IDENTITY=pellcorp
export GIT_SSH=/root/git-ssh.sh
git clone git@github.com:pellcorp/creality.git /usr/data/pellcorp
cd /usr/data/pellcorp && git remote set-url origin https://github.com/pellcorp/creality.git && cd```
</details>

### Config Overrides

If you have pellcorp-overrides in github but not stored locally, You need to recreate the [/usr/data/pellcorp-overrides directory](Configuration-Overrides#create-local-repo) before running the installer.sh!

### Run the installer

To run the script, you must use the following command:

```
/usr/data/pellcorp/k1/installer.sh --install cartotouch
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

It is important to make sure you have a way to [emergency factory reset](#emergency-factory-reset) the printer, if the worst happens.   There is a macro in Simple AF called `CHECK_USB_KEY` that will wait for you to plug a USB key in and tell you if it was able to be successfully mounted.   You should verify your USB key often just to make sure you have something if you need to unbrick your printer, simply type `CHECK_USB_KEY` or hit the button in Fluidd / Mainsail

![image](https://github.com/user-attachments/assets/cdd90e6d-2d61-48fb-8624-818190604ac4)

If you get the message: `INFO - USB Key was recognised and mounted correctly (/tmp/udisk/sda1)`, your USB is perfect to use for a factory reset.   If you get no message at all before the script ends (after 60 seconds), your USB is defective.   You can check the `messages` file in the logs section of your UI to get more details about why the usb key could not be mounted!

## Troubleshooting

https://docs.cartographer3d.com/cartographer-probe/survey-touch/survey-troubleshooting

<details>
<summary>Manual Cartographer Serial Device configuration</summary>
You may have to update the [scanner] section in the cartotouch.cfg with the correct cartographer serial device address.   If the installer was not able to determine the correct serial device, you will see a warning in the installer in that case: `WARNING: There does not seem to be a cartographer attached - skipping auto configuration`

Open the `cartotouch.cfg` in fluidd or mainsail and edit it there if needed.

Find the serial device for the cartographer, from the command line:
```
ls /dev/serial/by-id/usb-Cartographer*
```

Then replace the `[scanner]` line from `cartotouch.cfg`:

```
serial:/dev/serial/by-id/XXX   # change this line to have your cartographer id.
```

So it should then look something like:

```
serial: /dev/serial/by-id/usb-Cartographer_614e_160020001343303856303820-if00
```

Restart klipper if you had to change the `serial` entry.
</details>

### Timer too close and microsteps

For cartographer you cannot use more than `microsteps: 32`, the MCU cannot handle both more microsteps and cartographer, it puts too much pressure on the system and it will throw timer too close during bed meshes.

If even after this change, you continue to experience timer too close during normal printing, you can switch to my older klipper repo with the following command:

```
/usr/data/pellcorp/k1/installer.sh --update-repo
/usr/data/pellcorp/k1/installer.sh --klipper-repo k1-carto-klipper
```

This change will persist for updates, but not for a reinstall

## Calibration

It is a good idea to heat the nozzle to 150c for this step first!

1. Home X Y (G28 X Y)
2. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
3. Make sure nozzle is centred on bed
4. Enable Force Move (via the button in the UI) and move your bed plate 2-3 mm away from the nozzle 
5. Run `CARTOGRAPHER_TOUCH METHOD=manual`
Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
Upon completion *`SAVE_CONFIG`*

!!! warning
    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

After the save config you have to do the cartographer threshold scan (see next)

!!! warning
    For this next step, it is really important to be near your printer for this step, because if there
    is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

6. Home All (`G28`)
7. Make sure nozzle is centred on bed
8. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
9. Execute `CARTOGRAPHER_THRESHOLD_SCAN MIN=1500 MAX=5000 STEP=100 VERIFY_SAMPLES=50 TARGET=0.08`
Upon completion *`SAVE_CONFIG`*

After the save config you have to do the touch calibration.   

!!! warning
    For this next step, it is really important to be near your printer for this step, because if there
    is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

10. Home All (`G28`)
11. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
12. Execute `CARTOGRAPHER_TOUCH CALIBRATE=1`
Upon completion *`SAVE_CONFIG`*

!!! note
    If this fails after 3 tries, you should check to make sure there is not filament stuck to the bottom of your nozzle!

!!! note
    For the other calibrations, you were prompted to SAVE_CONFIG, for this particular calibration for whatever reason (maybe an oversight), the SAVE_CONFIG text is not output in the console after running the step, however the Save Config and Restart button at the top of Fluidd or the equivalent in Mainsail should have become active even so.

**Source:** https://docs.cartographer3d.com/cartographer-probe/survey-touch

### Axis Twist Compensation

Next it is highly recommended to perform axis twist compensation calibration **if you are using a rear mount** before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

1. Home All (`G28`)
2. Run `AXIS_TWIST_COMPENSATION_CALIBRATE`
The calibration wizard will prompt you to measure the probe Z offset at a few points along the bed
Upon completion *`SAVE_CONFIG`*

**WARNING:** Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

**Source:** https://www.klipper3d.org/Axis_Twist_Compensation.html

### First Print

For this first print you can go and do the tuning first (PID Tuning, etc) or you can go ahead and optimise your scanner_touch_z_offset using baby stepping, as documented [here](https://docs.cartographer3d.com/cartographer-probe/survey-touch#first-print):

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](https://github.com/user-attachments/assets/2af8d5cb-091e-40df-a38c-25d43b2e6647)

## Tuning

At least PID tuning (bed and extruder) and input shaping is required for acceptable printing.  If you try and print after running the installer.sh and a power cycle but before any calibration you will most likely have horrendous quality, the worst you have ever seen on the k1.   After PID tuning and input shaping you should see the same kind of quality as you get with stock k1 + input shaper fix.

### Quick Start

You can use the `QUICK_START` Macro to automatically complete Bed and Nozzle PID Tuning and Input Shaping Automatically.

### Pid Tuning

https://www.klipper3d.org/Config_checks.html?h=pid#calibrate-pid-settings

For example you might run these:

```
PID_CALIBRATE_BED BED_TEMP=65
PID_CALIBRATE_HOTEND HOTEND_TEMP=230
```

!!! note
    The `PID_CALIBRATE_BED` and `PID_CALIBRATE_HOTEND` macros are located in the `useful_macros.cfg` file and they have defaults
    values for BED_TEMP and HOTEND_TEMP so you can just run them by clicking on them if you want that same temperature.

### Input Shaping

There is no default configuration for input shaping so it is essentially disabled out of the box.

You can use the `INPUT_SHAPER` button run input shaping, just be sure to `SAVE CONFIG` at the end, to choose the automatically selected shaper config, be aware though that the shaper chosen might be sub-optimal due to a slight difference in vibrations between two options.  So you should probably review the output and potentially choose an alternative if it gives you higher recommended max acceleration for minimal increase in vibration.

https://www.klipper3d.org/Measuring_Resonances.html#input-shaper-auto-calibration

!!! tip
    You should adjust your acceleration in your printer.cfg down to that recommended by the input shaper results. I normally reduce `max_accel` to the highest of the two axis (usually this will be y), and then more finely adjust the max acceleration per axis in my slicer profile.

## Other Calibrations

!!! note
    The default value for pressure advance is set to: `0.04`

Refer to https://github.com/SoftFever/OrcaSlicer/wiki/Calibration for more calibrations

This is an excellent resource for all things 3d print tuning:
https://ellis3dp.com/Print-Tuning-Guide/

### Scan Calibration Method

Some cartographer users choose to use scan only instead of touch and that is easy enough to do once you have finished setting it up, just change the cartotouch.cfg `calibration_method` to be `scan`.   You can then use the CARTOGRAPHER_MODEL parameter to start print from your slicer to select different filament profiles, this is required if you print with different filaments and/or use different bed aurfaces.

## Octoeverywhere Companion

Octoeverywhere cannot be installed onto the K1 when running the Cartographer, the stress placed on the system by running octoeverywhere is too great, however the octoeverywhere companion running on another device on the same WIFI network as the K1 works great.

https://blog.octoeverywhere.com/octoeverywhere-companion-remote-access-for-any-klipper-printer/

## Moonraker Timelapse

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

## Configuring Timezone

The /etc/init.d/S58factoryreset has recently been updated not to delete the /etc/localtime, so you can configure it once and it should survive any number of factory resets, following the excellent guide here:
https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/change-date-and-time/

## Updating

To update your installation with the latest fixes you should run:

```
/usr/data/pellcorp/k1/installer.sh --update-repo
/usr/data/pellcorp/k1/installer.sh --update
```

This backs up your customisations, updates the creality repo, applies all changes to your `/usr/data/printer_data/config` directory and then reapplies your customisations over the top.

Refer to [Update or Reinstall - What gets overriden](Simple-AF-Update-or-Reinstall)

## Reinstalling

A reinstall is only needed if you are switching probes or one or more github repos have got into an inconsistent state, so you can force a reinstall with the `--reinstall` argument in place of the `--install` argument.  The difference to a `--install`, is a `--install` will only finish up a partial install that failed due to a network failure or the like.

Refer to [Update or Reinstall - What gets overriden](Simple-AF-Update-or-Reinstall)

## Emergency Factory Reset

If the worst happens and you somehow get locked out (for instance for whatever reason the dropbear ssh session does not start or wifi config gets all screwy, it is possible to trigger a emergency factory reset.

It is very easy, you just need to create a empty file called `emergency_factory_reset` on a USB key and make sure the USB key is plugged in, then power cycle the printer, this will initiate a factory reset.

!!! warning
    This factory reset method will rename the `emergency_factory_reset` to `emergency_factory_reset.old` to avoid a boot loop, so if you need to use this method again you will need to rename the file.

!!! warning
    This factory reset method will **not** remove the special service file `/etc/init.d/S58factoryreset` from the k1, so if you need it you can redo a factory reset even before reinstalling.

!!! note
    This method does not reset wifi or root access

!!! success
    Happy printing!