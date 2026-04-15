# Troubleshooting

## Error during homing z: Eddy current sensor error

You might need to adjust your `reg_drive_current`, for more details:
<https://github.com/bigtreetech/Eddy?tab=readme-ov-file#sometimes-i-get-error-during-homing-probe-eddy-current-sensor-error>

## Eddy is not connected, aborting homing Z

If you see this error when trying to home your printer, it is a clear indication that the eddy was either not connected
when klipper started, or was disconnected sometime later.

You should look for a `mcu 'eddy' disconnected` error in your klippy.log or gcode console, if the eddy was momentarily
disconnected (so if you run `lsusb` on the printer the eddy shows up), you can simply restart klipper from the services
menu in Fluidd or Mainsail, if the eddy completely disappeared you will need to power cycle the printer!

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/btt_eddy_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the eddy is wired incorrectly, or if was working, it just means that an attempt to restart the eddy failed because the K1 refused to recognise it, there is no recourse except to restart the host via Fluidd / Mainsail (or power cycle the printer)

If you can see the eddy in lsusb, then you should try to update the serial (see next)

## Manual BTT Eddy Serial Device configuration

You can run the following command to fix your serial if you forgot to plug your btt eddy in during the installation or update:

```
~/pellcorp/k1/installer.sh --fix-serial
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
