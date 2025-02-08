## Octoeverywhere Companion

Octoeverywhere cannot be installed onto the K1 when running the Cartographer, beacon or btt eddy, the stress placed on the system by running octoeverywhere is too great, however the octoeverywhere companion running on another device on the same WIFI network as the K1 works great.

<https://blog.octoeverywhere.com/octoeverywhere-companion-remote-access-for-any-klipper-printer/>

## Mobileraker companion

It is also possible to install mobileraker companion on a separate device

<https://github.com/Clon1998/mobileraker_companion?tab=readme-ov-file#standalone-installation>

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

### Timelapse Camera config

Because the single web cam is controlled via moonraker with the webcam.conf file, the Timelapse camera dropdown menu won't let you choose a camera, this is expected.

![image](assets/images/webcam.png)

### Slicer Changes

<https://github.com/mainsail-crew/moonraker-timelapse/blob/main/docs/configuration.md#prusa-slicer--super-slicer>

## Configuring Timezone

The `/etc/init.d/S58factoryreset` has recently been updated not to delete the `/etc/localtime`, so you can configure it once and it should survive any number of factory resets, following the excellent guide here:

<https://guilouz.github.io/Creality-Helper-Script-Wiki/firmwares/change-date-and-time/>

## Updating

[Updating](updating.md#updating)

## Reinstalling

[Reinstalling](updating.md#reinstalling)

## Git Backups for Configuration Overrides

[Git Backups for Configuration Overrides](config_overrides.md#git-backups-for-configuration-overrides)

## Guppyscreen Factory Reset

It is possible to initiate a factory reset from the settings menu (the cog) of Guppyscreen, its the same as 
initiating via USB or by directory running the S58factoryreset service.

![image](assets/images/guppyscreen_factory_reset.png)

## Emergency Factory Reset

If the worst happens and you somehow get locked out (for instance for whatever reason the dropbear ssh session does not start or wifi config gets all screwy, it is possible to trigger a emergency factory reset.

It is very easy, you just need to create a empty file called `emergency_factory_reset` on a USB key and make sure the USB key is plugged in, then power cycle the printer, this will initiate a factory reset.

!!! info

    This factory reset method will rename the `emergency_factory_reset` to `emergency_factory_reset.old` to avoid a boot loop, so if you need to use this method again you will need to rename the file.

    This factory reset method will **not** remove the special service file `/etc/init.d/S58factoryreset` from the k1, so if you need it you can redo a factory reset even before reinstalling.

    This method does not reset wifi or root access

!!! danger

    It can take up to 5 minutes for an emergency factory restart to finish, it is **vital** you do not power cycle your printer before the stock screen appears. There may be a 3002 error on the screen, this is completely normal.   If you are planning to install Simple AF you can ignore it, if you are trying to go back to stock, power cycle the printer again to clear the error.  

    Failing to follow this advice can lead to your printer getting bricked and requiring much more involved intervention to recover!
    
    ![image](assets/images/error3002.png)
