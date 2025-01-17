!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR EDDY

!!! tip "Flashing Btt DUO"

    Make sure to switch it to USB Mode first of all!!!

    It is possible this method will not work for the BTT Duo, especially if it is currently flashed for Can from the factory, 
    and you may need to resort to the old fashioned approach documented [here](btteddy_duo_flashing.md)

## Flashing on Windows or Linux Desktop

### Connecting in BOOTSEL mode

You need to connect your btt eddy to your computer in BOOTSEL mode, you do this by disconnecting the eddy usb **or eddy duo**, and then push and hold boot button on Eddy (It's next to where the cable plugs in) and at the same time, plug in the cable to your computer.

On windows or a Linux Desktop if you successfully connected the eddy in bootsel mode, it will be mounted as a new drive on your computer.

### Flashing btteddy.uf2 file

Copy the btteddy.uf2 file across to the btt eddy drive, it should automatically flash the eddy and disconnect for you.

Once this is done go ahead and reconnect your eddy to your K1.

## On K1

You can also flash the eddy on your K1, but you need to be able to disconnect and reconnect it for this to work, there is currently no way to get the eddy into boot mode any other way!

So by default when connecting the btt eddy to the K1, `lsusb` will report:

```
Bus 001 Device 099: ID 1d50:614e OpenMoko, Inc. USB2.0 Hub
```

This means it is not in boot mode and you cannot flash any firmware to it.  You need to hold down the boot button and re-connect your btt eddy to your K1, you will know this worked if you type `lsusb` and see:

```
Bus 001 Device 101: ID 2e8a:0003  USB2.0 Hub
```

Verify that the btt eddy has been mounted as a disk drive on the K1 by running `mount`, you should see a `/tmp/udisk/sda1` entry:

![image](assets/images/btteddy_mount.png)

Once this has happened you will be able to copy the btteddy.uf2 file to the eddy via this command:

```
wget --no-check-certificate https://raw.githubusercontent.com/pellcorp/klipper/master/fw/K1/btteddy.uf2 -O /tmp/btteddy.uf2
cp /tmp/btteddy.uf2 /tmp/udisk/sda1/
```

If you check `lsusb` again, it should have switched back to:

```
Bus 001 Device 102: ID 1d50:614e OpenMoko, Inc. USB2.0 Hub
```

## How do I know it flashed correctly?

Unfortunately I know of no way to test this except by plugging it back into the K1, restarting klipper and verifying the via the System tab, a correctly flashed eddy will have 

![image](assets/images/mcu_eddy.png)

## Migrating from K1 Mod 

The K1 mod has an older version of the btteddy firmware, if you still see this in the System tab, then your flashing failed

![image](assets/images/old_mcu_eddy.png)
