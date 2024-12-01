If you are about to swap your crappy MIPS k1 board for something that is actually speedy, like a Manta, you can quickly get latest firmware onto your nozzle before trashing the board with the following:

```
git clone https://github.com/pellcorp/klipper.git /usr/data/klipper
cp /etc/init.d/S13mcu_update /usr/data/S13mcu_update.old
wget --no-check-certificate https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S13mcu_update -O /etc/init.d/S13mcu_update
sync
```

This assumes you are not currently running updated k1-klipper firmware or anything.  After you have run the above, just reboot your K1 and the firmware should be updated.   You can check what firmware was updated by checking the `/usr/data/mcu.versions` file:

```
root@K1-0753 /root [#] cat /usr/data/mcu.versions | grep noz
noz_version=noz0_120_G30-noz0_015_000
```

The value should match the noz file from [https://github.com/pellcorp/klipper/tree/master/fw/K1](https://github.com/pellcorp/klipper/tree/master/fw/K1)

![image](https://github.com/user-attachments/assets/1eacb26d-308f-4a47-9c12-b9769ece7407)

## What do I do if I already have k1-klipper and want newer firmware

So you can instead just download the firmware file and copy it to `/usr/data/klipper/fw/K1`, so something like:

```
rm /usr/data/klipper/k1/FW/noz*
wget --no-check-certificate https://github.com/pellcorp/klipper/raw/master/fw/K1/noz0_120_G30-noz0_015_000.bin -O /usr/data/klipper/k1/FW/noz0_120_G30-noz0_014_000.bin
sync
```

Power cycle your printer

You will know it worked when fluidd complains something like this:

![image](https://github.com/user-attachments/assets/e8af3447-36d8-4c45-aa61-ab0b2cc54941)
