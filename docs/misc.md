## Octoeverywhere Companion

Octoeverywhere cannot be installed onto the K1 when running the Cartographer, beacon or btt eddy, the stress placed on the system by running octoeverywhere is too great, however the octoeverywhere companion running on another device on the same WIFI network as the K1 works great.

<https://blog.octoeverywhere.com/octoeverywhere-companion-remote-access-for-any-klipper-printer/>

## Mobileraker companion

It is also possible to install mobileraker companion on a separate device

<https://github.com/Clon1998/mobileraker_companion?tab=readme-ov-file#standalone-installation>

## Switch to Stock

A recent feature allows you to quickly switch back to Stock Creality Klipper after installing Simple AF, and being able to
quickly restore Simple AF without having to do a factory reset.  All that will be required after each switch is to power cycle
at least once to get the MCUs updated with the correct firmware.   The use case for this feature is mostly about supporting
Simple AF users who have a single printer and perhaps they need to switch back to stock to be able to print a mount or something.

Existing users of Simple AF will have to factory reset at least once to get the correct Creality Stock configuration files correctly
backed up, but for new users the feature will be available straight away.   If you have a `/usr/data/backups/creality-backup.tar.gz` file,
you can use the feature.

Its really important before you install Simple AF for the first time that you properly calibrate the printer in stock so that
switching back allows you to immediately use the printer, the switch to stock process does not restore the printer to a completely
stock configuration, as only klipper and the stock display are restored!

Switching to stock is as simple as running from ssh on the printer:

```
/usr/data/pellcorp/k1/switch-to-stock.sh
```

And then power cycling the printer after the script finishes execution

### Switching back to Simple AF

You can easily switch back with:

```
/usr/data/pellcorp/k1/switch-to-stock.sh --revert
```

And power cycling the printer once again

!!! danger

    Do not leave a probe mounted on the printer when you switch back to stock, this is especially important if you have 
    a rear mounted probe as it is very likely to be damaged when the printer does its nozzle wipe at the back of the printer
    
    Switching to stock does **not** allow using the printer with Helper Script, this is an emergency temporary mode!

    Switching to stock will leave moonraker, fluidd and mainsail accessible.   The stock screen is restored, but you must **not**
    try to perform a firmware upgrade in stock mode as this will most likely remove SimpleAF!

## Moonraker Timelapse

Moonraker timelapse is installed but not enabled by default.  To enable it there are a few steps, you need to add the following include to printer.cfg:

```
[include timelapse.cfg]
```

And uncomment the `[include timelapse.conf]` in moonraker.conf, you will need to restart moonraker **and** klipper after this, you can do that via the fluidd or mainsail services section.

If you see these messages:

```
 15:14:24  // Unknown command:"_SET_TIMELAPSE_SETUP"
15:14:24  // Unknown command:"HYPERLAPSE"
```
It means you have not as yet properly restarted moonraker and/or klipper.    If in doubt just power cycle your machine.

### Custom Parking Position

You might run into issues with the default `back_right` parking position.  A user has reported that the toolhead collides with the rear motor, a 
remedy for this is to modify the `[timelapse]` section in `timelapse.conf` to enable custom parking and set the X and Y coordinates to match what is in the `start_end.cfg` for 
`variable_custom_park_x` and `variable_custom_park_y`.

Change the `parkpos: back_right` to be `parkpos: custom`, so the `timelapse.conf` changes might look like: 

```
parkpos: custom
park_custom_pos_x: 296
park_custom_pos_y: 296
```

### Timelapse Camera config

!!! info

    Because the single webcam is controlled via moonraker with the webcam.conf file, the Timelapse camera dropdown menu won't let you choose a camera, this is expected.

![image](assets/images/webcam.png)

### Slicer Changes

<https://github.com/mainsail-crew/moonraker-timelapse/blob/main/docs/configuration.md#prusa-slicer--super-slicer>

## Spoolman

Spoolman moonraker integration  is not enabled by default.  To enable it there are a few steps, you need to add the following include to printer.cfg:

```
[include spoolman.cfg]
```

And uncomment the `[include spoolman.conf]` in moonraker.conf, you will need to change the `server` url to your spoolman server location. 

You will need to restart moonraker **and** klipper after this, you can do that via the fluidd or mainsail services section.

## Configuring Timezone

The `/etc/init.d/S58factoryreset` has recently been updated not to delete the `/etc/localtime`, so you can configure it once and it should survive any number of factory resets, following the excellent guide here:

<https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/change-date-and-time/>

## Emergency Factory Reset

If the worst happens and you somehow get locked out (for instance for whatever reason the dropbear ssh session does not start or wifi config gets all screwy, it is possible to trigger a emergency factory reset.

It is very easy, you just need to create a empty file called `emergency_factory_reset` on a USB key and make sure the USB key is plugged in, then power cycle the printer, this will initiate a factory reset.

!!! tip

    If you are having trouble creating a file like this in windows, the easiest way is to download the [emergency_factory_reset.zip](assets/other/emergency_factory_reset.zip) and extract it onto your usb thumb drive.


!!! info

    This factory reset method will rename the `emergency_factory_reset` to `emergency_factory_reset.old` to avoid a boot loop, so if you need to use this method again you will need to rename the file.

    This factory reset method will **not** remove the special service file `/etc/init.d/S58factoryreset` from the k1, so if you need it you can redo a factory reset even before reinstalling.

    This method does not reset wifi or root access

!!! danger

    It can take up to 5 minutes for a factory restart to finish, it is **vital** you do not power cycle your printer before the stock screen appears. There may be a 3002 error on the screen, this is completely normal.   If you are planning to install Simple AF you can ignore it, if you are trying to go back to stock, power cycle the printer again to clear the error.  

    Failing to follow this advice can lead to your printer getting bricked and requiring much more involved intervention to recover!
    
    ![image](assets/images/error3002.png)

### Grumpyscreen Factory Reset

It is also possible to initiate a factory reset from the settings menu (the cog) of Grumpyscreen.

![image](assets/images/grumpyscreen_factory_reset.png)

