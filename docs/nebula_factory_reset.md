# Nebula Factory Reset

A factory reset is **required** before you install Simple AF onto a retail Nebula Pad to run with an older Ender 3!

The following method retains SSH access and Wi-Fi settings as long as you perform it **after** flashing the Simple AF base firmware!

```
/etc/init.d/S58factoryreset reset
```

!!! danger

    It is really important you do not close the ssh session until you get this message:

    ![image](assets/images/factory_reset.png)

    It can take up to 5 minutes for a factory restart to finish, it is **vital** you do not power cycle your nebula pad before the stock screen appears. 

    Failing to follow this advice can lead to your nebula pad getting bricked and requiring you flashing the ingenic image to recover, which is a bit more annoying!

