### Enable Bootloader

```
CARTO_DEV=$(ls /dev/serial/by-id/usb-* | grep "IDM\|Cartographer" | head -1)
cd $HOME/klipper/scripts
sudo -E $HOME/klippy-env/bin/python -c "import flash_usb as u; u.enter_bootloader('$CARTO_DEV')"
```

!!! note

    If you get a warning `sudo: preserving the entire environment is not supported, '-E' is ignored` you can
    safely ignore it, its likely you are on Ubuntu 26.04!

!!! warning 

    If you get a message like `ls: cannot access '/dev/serial/by-id/usb-*': No such file or directory`, it means you forgot the `*` in the command above, your carto cable is incorrectly pinned or
    you are using a VM or WSL (against advice) and have not passed through the Cartographer USB Device!

You should see a message like:

```
Entering bootloader on /dev/serial/by-id/usb-Cartographer_614e_16000C000F43304253373820-if00
```

!!! note

    If the carto does not enter bootloader mode, it is possible you forgot to use sudo!
    If your carto does show up in /dev/serial but won't enter bootloader mode, you will need to fix this with [DFU mode](#flashing-k1-firmware-via-dfu-mode)
