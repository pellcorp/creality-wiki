# Troubleshooting

<https://docs.cartographer3d.com/cartographer-probe/troubleshooting>

## Probe triggered prior to movement

This seems to be reasonably common problem for K1 series users, and a few things have been suggested to try and counteract it, first
is to downgrade the firmware on the cartographer to `5.0.0 K1`, and you might have noticed that this is the version we recommend for 
V3 Cartographer users now!  Unfortunately for V4 Cartographer users there is no such option, and we are starting to see this probe 
triggered prior to movement issue for them too.

If you are still having the problem on 5.0.0 K1 series or have a V4 cartographer, you could try adding an additional configuration option to `cartographer.cfg` file, specifically `retract_distance: 10.0`:

```
[cartographer touch]
max_samples: 20
retract_distance: 10.0
```

If all else fails, there is always [Cartotouch](cartotouch.md)

!!! warning

    If you get an error saying that `retract_distance` is not a valid config option, make sure that you have updated the Cartographer
    plugin to latest via Fluidd or Mainsail software section.

## You must flash the cartographer with K1 specific firmware!

![image](assets/images/cartographer_must_flash_k1_firmware.png)

This means when you received your cartographer you failed to flash it with the K1 (known as Lite for V4 cartographer) specific firmware required for Simple AF and Cartographer to
function without causing lots of performance and stability issues.   Validations were recently added to various macros in Simple AF for the new
Cartographer software to abort if the non K1 / Lite specific firmware is not flashed.

[cartographer firmware](cartographer.md#cartographer-firmware)

## mcu 'cartographer': Unknown command: debug_read

If you get the following error, it means that the cartographer is not connected to the printer.   This is either because its physically not connected, the wiring is wrong, the usb subsystem has disconnected the carto during a restart or the serial id is wrong

![image](assets/images/cartographer_protocol_error.png)

!!! danger

     If you are on V4 Cartographer Probe `cartographer:PA3` is not the right pin, you must use `cartographer:PA0`!  PA3 on V4 is used for something else, and will cause a potential boot loop of the probe causing the 'Unknown command: debug_read' error

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/carto_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the carto is wired incorrectly, or if was working, it just means that an attempt to restart the carto failed because the K1 refused to recognise it, there is no recourse except to restart the host via Fluidd / Mainsail (or power cycle the printer)

If you can see the carto in lsusb, then you should try to update the serial refer to [Manual Cartographer Serial Device configuration](#manual-cartographer-serial-device-configuration)

## Error during probe mcu identification, check connection

If you get the following error, it means that the cartographer is not connected to the printer.   This is either because its physically not connected, the wiring is wrong, the usb subsystem has disconnected the carto during a restart or the serial id is wrong

![image](assets/images/carto_check_connection.png)

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/carto_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the carto is wired incorrectly, or if was working, it just means that an attempt to restart the carto failed because the K1 refused to recognise it, there is no recourse except to restart the host via Fluidd / Mainsail (or power cycle the printer)

If you can see the carto in lsusb, then you should try to update the serial refer to [Manual Cartographer Serial Device configuration](#manual-cartographer-serial-device-configuration)

### Manual Cartographer Serial Device configuration

You can run the following command to fix your serial if you forgot to plug your cartographer in during the installation or update:

```
~/pellcorp/installer.sh --fix-serial
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --fix-serial
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --fix-serial
        ```


## Cartographer is not connected, aborting homing Z

If you see this error when trying to home your printer, it is a clear indication that the cartographer was disconnected and
you should look for a `mcu 'cartographer' disconnected` error in your klippy.log or gcode console, if the cartographer was momentarily
disconnected (so if you run `lsusb` on the printer the cartographer shows up), you can simply restart klipper from the services
menu in Fluidd or Mainsail, if the cartographer completely disappeared you will need to power cycle the printer!
