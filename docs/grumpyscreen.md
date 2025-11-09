# GrumpyScreen

GrumpyScreen is our fork of the wonderful GuppyScreen from ballaswag that we have continually refined and enhanced
to be tightly integrated with Simple AF, although it's also possible to run this on Helper Script too.

## Configuration

Recently we migrated to a klipper style config file which you can edit directly from the config directory in fluidd or mainsail, look for the file `grumpyscreen.cfg`,
now that its a flat file, config overrides will be fully supported for retaining all your customisations including custom fans, leds, monitored sensors etc.

## Grumpyscreen Factory Reset

It is possible to initiate a factory reset from the settings menu (the cog) of Grumpyscreen.

![image](assets/images/grumpyscreen_factory_reset.png)

## Helper Script?

So I have added experimental support for installing GrumpyScreen onto Helper Script printers, currently only
K1, K1C, K1SE and K1M are supported and the support is experimental, I make no guarantees things won't break, so you **must** have already installed GuppyScreen
via helper script and then you can run the following from your printer ssh console:

```
wget https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/helperscript/install-grumpyscreen.sh -O - > /usr/data/install-grumpyscreen.sh
sh /usr/data/install-grumpyscreen.sh
```

!!! note

     The grumpy-macros.cfg has a couple of macros for _GUPPYSCREEN_EXTRUDE and _GUPPYSCREEN_EXTRUDE that you will likely need to include into your
     printer.cfg, or else just copy the contents into guppy_cmd.cfg.

It will replace guppyscreen binary and configuration file, you can update GrumpyScreen via the screen only, the Helper Script `GUPPY_UPDATE` macro
has been removed as it breaks grumpyscreen.

If you want to revert to normal guppyscreen just uninstall and reinstall from Helper Script, I do not provide a script to do this automatically

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
