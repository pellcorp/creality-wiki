# Cartographer Beta

The cartographer team is has just released a new version of the klippy extra to replace scanner.py.  
Setting up the new software requires you to switch to a new probe config called `cartographer`

!!! warn

    Although cartographer3d.com has just released the software (oct 26 2026), we are not going to make it the 
    default for cartographer probes for some weeks until initial release teething problems are resolved.

!!! note

    You do not need a new cartographer probe this is just a Simple AF config change!

The existing probe `cartotouch` config is for the existing software (the `scanner.py`), and at some point during the next 
few months the `cartotouch` support will be deprecated in Simple AF.  The process to make this happen won't start until 
the cartographer3d.com team releases the new software, which is supposed to happen in the next couple of weeks (as of oct 15 2025)

## Setup Simple AF

You need to update Simple AF repository to latest:

```
~/pellcorp/installer.sh --branch main
```

Then you are going to be switching probes from `cartotouch` to `cartographer`:

```
~/pellcorp/installer.sh --update cartographer --mount %CURRENT%
```

!!! info

    If you are wanting to use the cartographer from a fresh installation, you can do a `--install cartographer --mount TheMount`, rather than
    a `--update cartographer`, where `TheMount` is a supported cartographer [mount option](cartographer.md#mount-options)

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --branch main
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch main
        ~/pellcorp/installer.sh --update cartographer --mount %CURRENT%
        ```

!!! warn

    The **--mount %CURRENT%** is required to ensure the mount offsets are applied correctly.

You will need to remove the existing config from the bottom of your printer.cfg:

- `[scanner]`
- `[scanner model default]`

And remove any bed mesh and axis twist calibration stuff

## Calibration

!!! warn

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

**Source:** <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/scan-calibration>

!!! warn

    Do not use a metal feeler gauge for this step, it could damage your cartographer!!!

After the save config you have to do the touch calibration.

### Touch Calibration

It is strongly recommended to disable the camera for these calibration steps, just use the `STOP_CAMERA`
macro to do this.

!!! danger

    For this next step, it is really important to be near your printer for this step, because if there is any issue with the printer configuration or your carto probe, its possible the nozzle will dig itself into the bed, so be hovering over that e-stop button!

1. Run the `STOP_CAMERA` macro to stop the camera
2. Home All (`G28`)
3. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
4. Make sure nozzle is centred on bed
5. Run `CARTOGRAPHER_TOUCH_CALIBRATE SPEED=2`
   <br />Upon completion *`SAVE_CONFIG`*

!!! warn

    Observe your nozzle to make sure it touches on the bed.
    If it never touches the bed, refer to <https://cartographer-3d.gitbook.io/cartographer-beta-software/touch-calibration#nozzle-never-touches-the-bed>

**Source:** <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/software-configuration/touch-calibration>

### Bed Mesh Boundary

Might be a useful tool to calculate mesh min and max:
<https://cartographer-3d.gitbook.io/cartographer-beta-software/features/touch#bed-mesh-calibrate>

### Axis Twist Compensation

!!! note 

    This is a fancy new feature of the Cartographer Beta firmware it does not require any paper!

Next it is highly recommended to perform axis twist compensation calibration **if you are using a rear mount** before doing anything else, this will affect the quality of
your bed mesh, so best to do it before.

1. Home All (`G28`)
2. Heat Nozzle to 150c (`M109 S150`) so that any filament can be removed from nozzle
3. Run `CARTOGRAPHER_AXIS_TWIST_COMPENSATION` 
   <br />Upon completion *`SAVE_CONFIG`*

**Source:** <https://cartographer-3d.gitbook.io/cartographer-beta-software/touch#axis-twist-compensation>

### First Print

You should optimise your `cartographer touch_model default` `z_offset` using baby stepping, as documented here: <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/installation/first-print>

In fluidd the save button after you finish or cancel your print can be a bit hard to find, look for

![image](assets/images/fluidd_save_zoffset.png)

## Troubleshooting

### Unable to find 5 samples within tolerance after 20 touches

If you are getting a failed print, check the nozzle for stubborn filament, but also consider rerunning the `CARTOGRAPHER_TOUCH_CALIBRATE` with a larger START= value, because
my experience so far is that I had this issue until I changed the threshold and then the issue went away.
