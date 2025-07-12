# Cartographer Beta

The cartographer team is currently beta testing a new version of the klippy extras to
replace scanner.py, I have setup a branch of Simple AF to make it easy to give it a try.

## Setup Simple AF

You need to switch branches from ssh on printer with:

```
/usr/data/pellcorp/k1/installer.sh --branch jp_carto_plugin_alpha
/usr/data/pellcorp/k1/installer.sh --update
```

You will need to remove the existing config from the bottom of your printer.cfg:

- `[scanner]`
- `[scanner model default]`

And remove any bed mesh and axis twist calibration stuff

## Calibration

!!! warning

    The following calibration steps are required to setup a new printer:

    - [Scan calibration](#scan-calibration)
    - [Touch Calibration](#touch-calibration)

### Scan calibration

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Make sure nozzle is centred on bed
5. Run `CARTOGRAPHER_SCAN_CALIBRATE`
   Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

!!! note

    Is normal to show the Z position at almost at the max height of the printer even if the nozzle is somewhere in the middle or even close to the bed, this is not a bug, its intentional.   Until
    this calibration step is completed, the Z axes cannot be homed, so we make the printer pretend the bed is down the bottom of the printer so that you can freely move the bed
    up to meet the nozzle during the paper test without running into out of range issues.  You however won't be able to move the bed further away from the nozzle more than a few mm.
    
    ![image](assets/images/probe_manual.png)

**Source:** <https://cartographer-3d.gitbook.io/cartographer-beta-software/getting-started/scan-calibration#scan-calibration>

!!! warn

    Do not use a metal feeler gauge for this step, it could interfere with calibration!!!

After the save config you have to do the touch calibration.

### Touch Calibration

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home X Y (`G28 X Y`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Make sure nozzle is centred on bed
5. Run `CARTOGRAPHER_TOUCH_CALIBRATE`
   Follow the [Paper Test Method](https://www.klipper3d.org/Bed_Level.html#the-paper-test)
   <br />Upon completion *`SAVE_CONFIG`*

!!! warning

    Observe your nozzle to make sure it touches on the bed.
    If it never touches the bed, refer to <https://cartographer-3d.gitbook.io/cartographer-beta-software/touch-calibration#nozzle-never-touches-the-bed>

**Source:** <https://cartographer-3d.gitbook.io/cartographer-beta-software/touch-calibration>
