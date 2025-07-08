# Troubleshooting

<https://docs.cartographer3d.com/cartographer-probe/troubleshooting>

## Repo has diverged from remote

![image](assets/images/cartographer_repo_diverged.png)

You need to click RECOVER and then run from ssh:

```
~/cartographer-klipper/install.sh
```

## Error during probe mcu identification, check connection

If you get the following error, it means that the cartographer is not connected to the printer.   This is either because its physically not connected, the wiring is wrong, the usb subsystem has disconnected the carto during a restart or the serial id is wrong

![image](assets/images/carto_check_connection.png)

So from ssh run a `lsusb` and make sure you can see:

![image](assets/images/carto_lsusb.png)

If you cannot see it in `lsusb`, then it very likely means either the carto is wired incorrectly, or if was working, it just means that an attempt to restart the carto failed because the K1 refused to recognise it, there is no recourse except to restart the host via Fluidd / Mainsail (or power cycle the printer)

If you can see the carto in lsusb, then you should try to update the serial (see next)

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
