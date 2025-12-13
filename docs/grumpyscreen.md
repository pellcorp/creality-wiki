# GrumpyScreen

GrumpyScreen is our fork of the wonderful GuppyScreen from ballaswag that we have continually refined and enhanced
to be tightly integrated with Simple AF, although it's also possible to run this on Helper Script too.

The source for GrumpyScreen can be found at <https://github.com/pellcorp/grumpyscreen>

## Configuration

Recently we migrated to a klipper style config file which you can edit directly from the config directory in fluidd or mainsail, look for the file `grumpyscreen.ini`,
now that its a flat file, config overrides will be fully supported for retaining all your customisations including custom fans, leds, monitored sensors etc.

!!! note

    Unfortunately both Fluidd and Mainsail will present the `Save & Restart` button to you when editing grumpyscreen.ini file, but klicking this button
    is pointless because it will not restart GrumpyScreen, you need to click the Save button only and then manually restart GrumpyScreen from the services menu
    or Restart Grumpy from the tools menu in GrumpyScreen itself.

## Grumpyscreen Factory Reset

It is possible to initiate a factory reset from the tools menu of Grumpyscreen.

![image](assets/images/grumpyscreen_factory_reset.png)

## GrumpyScreen for Helper Script

I have added **experimental** support for installing GrumpyScreen onto Helper Script printers, currently only K1, K1C, K1SE and K1M are supported.

First of all clone the Simple AF repo:

```
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
```

Then run the helperscript grumpyscreen installer:

```
/usr/data/pellcorp/helperscript/install-grumpyscreen.sh
```

!!! note

    GrumpyScreen requires two macros _GUPPYSCREEN_EXTRUDE and _GUPPYSCREEN_EXTRUDE.  As part of the installation, a `grumpy-macros.cfg` with these macros
    is copied into `/usr/data/printer_data/config/GuppyScreen/`, so the macros should have been imported by the existing `[include GuppyScreen/*.cfg]` 
    include added by Helper Script.

The installer will replace the existing guppyscreen binary and configuration file, you can update GrumpyScreen via the screen only, the Helper Script `GUPPY_UPDATE` 
macro has been removed as it breaks grumpyscreen.

Like for Simple AF, the installer will copy the `guppyscreen.cfg` to the config directory so you can customise it and restart GrumpyScreen for changes to be applied. 

If you want to revert to normal guppyscreen just uninstall and reinstall from Helper Script, I do not provide a script to do this automatically!

Please note that GrumpyScreen is a vastly simplified version of Guppyscreen:

- No Gcode execution
- No Belts & Shake
- No Input Shaper
- No Bed Mesh
- No TMC Metrics
- No Tuning (other than during a print)
- No Limits
- No Power Devices (wtf that is)

We focus on polishing a subset of features and we added some additional ones:

- Factory Reset
- E-Stop on more screens
- Setting chamber temp targets

The Belt Shaper calibration macros from GuppyScreen remain and can be executed from fluidd or mainsail
