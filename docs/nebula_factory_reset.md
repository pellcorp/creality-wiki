# Factory Reset

It is strongly recommended to perform a factory reset via the following method rather than an official Creality method because our 
method retains SSH access and wifi settings/

```
wget --no-check-certificate https://raw.githubusercontent.com/pellcorp/creality/main/k1/services/S58factoryreset -O /tmp/S58factoryreset
chmod +x /tmp/S58factoryreset
/tmp/S58factoryreset reset
```

!!! danger

    It is really important you do not close the ssh session until you get this message:

    ![image](assets/images/factory_reset.png)

    It can take up to 5 minutes for a factory restart to finish, it is **vital** you do not power cycle your nebula pad before the stock screen appears. 

    Failing to follow this advice can lead to your nebula pad getting bricked and requiring you flashing the ingenic image to recover, which is a bit more annoying!

