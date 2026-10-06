## On Printer

You can also flash the eddy on your printer (K1, K1C, K1SE, K1M, Ender 3 V3 KE, etc) but you need to be able to disconnect and reconnect it for this to work, there is currently no way to get the eddy into boot mode any other way!

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
