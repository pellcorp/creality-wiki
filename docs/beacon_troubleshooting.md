# Troubleshooting

## Manual Beacon Serial Device configuration


You can run the following command to fix your serial if you forgot to plug your beacon in during the installation or update:

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

## 'BeaconProbe' object has no attribute '_mcu_freq'

This **often** indicates the beacon was disconnected during homing or some other operation, you need to reboot

![image](assets/images/beacon_mcu_freq.png)

On rare occasions this also occurs when the printer gets overloaded, if the error does not clear after a power cycle,
try leaving your printer completely powered off for 15 minutes, see if the error clears afterwards.  If the error does not
clear after doing this, I would be looking for a hardware issue, such as a dodgy cable.
