# Nebula Camera

The nebula camera is a plug and play camera for Simple AF on K1 series, but it does have a few issues, not least of which is the IR Sensor being way too sensitive
and pushing the camera to black and white even in good ambient light conditions.   It is possible to disable the IR Light but you need to flash the camera with
the V18 firmware which is not available directly from Creality.

## Firmware Upgrade

I got the firmware from <https://www.patreon.com/3DRUNDOWN/posts/creality-nebula-97259067>, but in case it disappears I am also hosting it myself at <https://github.com/pellcorp/downloads/blob/main/creality/firmware/Nebula/V018%20Nebula%20Firmware.zip>

I used the official Creality guide <https://wiki.creality.com/en/3d-printer-accessories/nebula-camera-installation-firmware-upgrade>

It might also be possible to flash the camera on the printer, as the `/usr/bin/cam_util` does seem to have a firmware flashing capability, but I have not explored that.

### Gnome Boxes

It is possible to flash the camera via a Windows 10 VM in Gnome Boxes, but when you first click the upgrade button, its going to disconnect the camera, and you have to go and reconnect it and click the upgrade button again

## Image is flipped vertically

At least in my experience the Nebula Camera image is vertically flipped, so there are a couple of changes you need to make:

- In the `webcam.conf` file change the `flip_vertical: False` to be `flip_vertical: True`
- In the `webcam.ini` file change the `flip_vertical=false` to be `flip_vertical=true`

Restart Moonraker and the Webcam service.

## Image is always black and white

Every time the camera is restarted it seems that the flag has to be reset, so we have added the capability to the webcam.ini so set the `disable_nebula_irlight=false` to `disable_nebula_irlight=true` and restart the Webcam service.

