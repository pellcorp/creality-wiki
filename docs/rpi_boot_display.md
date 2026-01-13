# Boot Display

The boot display step is currently optional and requires some manual steps, so you install the boot display via:

```
~/pellcorp/rpi/install-boot-display.sh
```

## Raspberry Pi OS

To get the splash screen working on raspberry pi OS you have to jump through a few additional hoops including installing:

```
sudo apt-get install -y plymouth rpd-plym-splash plymouth-themes
```

And then enable the splashscreen in raspi-config!

!!! note

    Installing rpd-plym-splash actually displays the raspberry pi desktop theme so if you enable the splashscreen after running the installer
    for the boot-display, you will most likely need to rerun:

```
sudo plymouth-set-default-theme -R simpleaf
```
