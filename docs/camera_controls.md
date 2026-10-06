# Camera Controls

Most USB cameras let you adjust things like brightness, contrast, white balance and exposure, but the defaults are not always great, especially
in an enclosed printer where the lighting is very different from what the camera expects.  The `CAMERA_CONTROL` macro lets you change these settings
from the Fluidd or Mainsail console without needing to SSH into the printer, it's available on both K1 Series and RPi.

## List Controls

Run the macro with no parameters to list the controls your camera supports, along with their current value, min, max and default:

```
CAMERA_CONTROL
```

Every camera is different, so the list depends on your camera, for example:

```
brightness (int): min=0 max=255 step=1 default=0 value=250
contrast (int): min=0 max=255 step=1 default=255 value=140
white_balance_temperature_auto (bool): default=1 value=0
white_balance_temperature (int): min=2800 max=7500 step=1 default=7500 value=5000
exposure_auto (menu): options=[1: Manual Mode, 3: Aperture Priority Mode] default=0 value=3
exposure_absolute (int): min=5 max=2500 step=1 default=156 value=666 flags=inactive
```

## Set a Control

```
CAMERA_CONTROL CONTROL=brightness VALUE=150
```

For menu controls use the option number shown in the list, and for bool controls use `0` or `1`.  The change is applied straight away, so it's
easiest to have the camera stream open while you adjust things.

Use `VALUE=default` to reset a control back to the camera default.

## Inactive Controls

Controls marked `flags=inactive` are controlled by the camera itself and will be ignored until you turn off the matching auto control, for example:

```
exposure_auto (menu): options=[1: Manual Mode, 3: Aperture Priority Mode] default=0 value=3
exposure_absolute (int): min=5 max=2500 step=1 default=156 value=666 flags=inactive
```

To set the exposure manually you need to switch `exposure_auto` to manual mode first:

```
CAMERA_CONTROL CONTROL=exposure_auto VALUE=1
CAMERA_CONTROL CONTROL=exposure_absolute VALUE=300
```

The same goes for white balance with `white_balance_temperature_auto` and focus with `focus_auto`.

## Saved Settings

On K1 Series any control you set is saved to the `[controls]` section of `webcam.ini` and re-applied every time the webcam service starts, resetting
a control to default removes it.  You can also edit the `[controls]` section directly and restart the webcam service:

```
[controls]
brightness: 150
exposure_auto: 1
exposure_absolute: 300
```

On RPi the controls are not saved, so once you have found settings you like add them to the `v4l2ctl` option in `crowsnest.conf`.
