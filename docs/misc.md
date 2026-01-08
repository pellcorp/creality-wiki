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

See [Moonraker Timelapse](moonraker_timelapse.md)

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
