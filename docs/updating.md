## Updating

### Fluidd and Mainsail Updates

The following components can be updated via Fluidd / Mainsail Software Updates:

- beacon
- cartographer
- fluidd
- fluidd-config (aka client-macros)
- moonraker
- klipper
- mainsail
- timelapse (aka Moonraker Timelapse)

You can update these components via Fluidd or Mainsail, in fluidd make sure you click the CHECK FOR UPDATES button, and in Mainsail click the Refresh button

!!! note

    It is normal for moonraker and klipper to warn about `Unofficial remote url`, this is because Simple AF has forked these repositories.

![image](assets/images/update_software.png)

### Simple AF

Simple AF which includes all the cfg and conf files cannot be updated via Fluidd or Mainsail, it must be updated by using ssh to connect to the printer

```
~/pellcorp/installer.sh --branch main
~/pellcorp/installer.sh --update
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --branch main
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch main
        /usr/data/pellcorp/k1/installer.sh --update
        ```
    
    If you get a `ERRROR: Mount option must be specified`, you must provide a `--mount TheMount` where `TheMount` is a reference to the mount you are currently
    using, and that will depend on what probe you are using, you can consult the #mount-options section of your specific probe wiki page.

This backs up your customisations, updates the creality repo, applies all changes to your `~/printer_data/config` directory and then reapplies your customisations over the top.

## Reinstalling

A reinstall is only needed if one or more github repos have got into an inconsistent state, so you can force a reinstall with the `--reinstall` argument in place of the `--install` argument.  The difference to a `--install`, is a `--install` will only finish up a partial install that failed due to a network failure or the like.

!!! info

    If you switch probes using --update you will have to manually clean up any save configuration for that probe before klipper will start.

