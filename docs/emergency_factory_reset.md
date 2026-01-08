If the worst happens, and you somehow get locked out, for instance for whatever reason the dropbear ssh session does not start or wifi config gets all screwy, it is still possible to trigger an emergency factory reset via
USB or GrumpyScreen.

## USB Factory Reset

It is very easy, you just need to create a empty file called `emergency_factory_reset` on a USB key and make sure the USB key is plugged in, then power cycle the printer, this will initiate a factory reset.

!!! tip

    If you are having trouble creating a file like this in windows, the easiest way is to download the [emergency_factory_reset.zip](assets/other/emergency_factory_reset.zip) and extract it onto your usb thumb drive.


!!! info

    This factory reset method will rename the `emergency_factory_reset` to `emergency_factory_reset.old` to avoid a boot loop, so if you need to use this method again you will need to rename the file.

    This factory reset method will **not** remove the special service file `/etc/init.d/S58factoryreset` from the k1, so if you need it you can redo a factory reset even before reinstalling.

    This method does not reset wifi or root access

!!! danger

    It can take up to 5 minutes for a factory restart to finish, it is **vital** you do not power cycle your printer before the stock screen appears. There may be a 3002 error on the screen, this is completely normal.   If you are planning to install Simple AF you can ignore it, if you are trying to go back to stock, power cycle the printer again to clear the error.  

    Failing to follow this advice can lead to your printer getting bricked and requiring much more involved intervention to recover!
    
    ![image](assets/images/error3002.png)

## Grumpyscreen Factory Reset

It is also possible to initiate a factory reset from the tools menu of Grumpyscreen.

![image](assets/images/grumpyscreen_factory_reset.png)
