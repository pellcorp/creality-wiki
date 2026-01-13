# GrumpyScreen

To install GrumpyScreen on Simple AF for RPi, there is currently an assumption that you are using a BTT DSI or BTT HDMI screen,
other screens might work, but ymmv.

From the printer via ssh, run:

```
~/pellcorp/rpi/install-grumpyscreen.sh 
```

## BTT DSI Screen

Support for grumpyscreen will be provided for BTT DSI screens but you need to setup the screen to be correctly configured.

<https://github.com/bigtreetech/TFT43-DIP>

By default when grumpyscreen starts its probably going to look like:

![image](assets/images/grumpyscreen_rpi_error.png)

The following changes are required to fix that:

Needs this in `/boot/firmware/config.txt` (for bookworm) or `/boot/config.txt` (for bulleye)

```
[all]
gpu_mem=160

```

And please make sure you disable this line:

```
# dtoverlay=vc4-kms-v3d
```

!!! note

    The gpu_mem=160 is really important otherwise Grumpyscreen won't display correctly.

## BTT HDMI 5 Screen

The config required for this screen is a bit different, need to force raspberry pi to 800x480 otherwise it squashes
the display down to 640x480, so this config:

```
[all]
gpu_mem=160

hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=87
hdmi_cvt=800 480 60 6 0 0 0
```

And please make sure you disable this line:

```
# dtoverlay=vc4-kms-v3d
```

!!! note

    The gpu_mem=160 is really important otherwise Grumpyscreen won't display correctly.

You will need to modify the `/etc/systemd/system/grumpyscreen.service` to configure the correct `LVGL_EVDEV_DEV`
which by default is set for DSI 4.3 TFT screen, be aware that the `/dev/input/event0` will likely be wrong if a webcam is plugged in.

**Source:** <https://global.bttwiki.com/HDMI5.html#hdmi-display-output>
