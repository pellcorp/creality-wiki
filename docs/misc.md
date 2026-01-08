## OctoEverywhere Companion

OctoEverywhere is a 3D printing community project that enables free remote access, AI print failure detection, notifications, and more. OctoEverywhere cannot be installed onto the K1 when running the Cartographer, beacon or btt eddy, the stress placed on the system by running OctoEverywhere is too great, however the OctoEverywhere Companion running on another device on the same WIFI network as the K1 works great.

Learn More:
[https://octoeverywhere.com/companion](https://octoeverywhere.com/companion?source=simpleaf_docs)

## Mobileraker companion

It is also possible to install mobileraker companion on a separate device

<https://github.com/Clon1998/mobileraker_companion?tab=readme-ov-file#standalone-installation>

## Switch to Stock

See [Switch to Stock](switch_to_stock.md)

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

See [Emergency factory Reset](emergency_factory_reset.md)

## Configure Wifi via USB Stick

See [Configure Wifi via USB](configure_wifi.md)

## Support ZIP

See [Support](support.md)
