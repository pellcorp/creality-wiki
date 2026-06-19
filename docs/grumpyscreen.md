# GrumpyScreen

GrumpyScreen is our fork of the wonderful GuppyScreen from ballaswag that we have continually refined and enhanced
to be tightly integrated with Simple AF.

The source for GrumpyScreen can be found at <https://github.com/pellcorp/grumpyscreen>

!!! note

    If for some reason your screen is blank after the installation finishes, GrumpyScreen should work after the power cycle
    you are requested to do at the end of the installation!

## Configuration

Recently we migrated to a klipper style config file which you can edit directly from the config directory in fluidd or mainsail, look for the file `grumpyscreen.ini`,
now that its a flat file, config overrides will be fully supported for retaining all your customisations including custom fans, leds, monitored sensors etc.

## Grumpyscreen Factory Reset

See [Factory Reset](emergency_factory_reset.md#via-grumpyscreen)

## Troubleshooting

### Waiting for Klipper to start

If this message does not disappear, you should check for more information via Fluidd / Mainsail or check the klippy.log

### Waiting for printer to initialise 

This message appears for older versions of GrumpyScreen, since we have replaced with a more accurate `Waiting for Klipper to start ...`,
but it means the same thing, GrumpyScreen is waiting for a signal that Klipper has started.

If this message does not disappear, you should check for more information via Fluidd / Mainsail or check the klippy.log
