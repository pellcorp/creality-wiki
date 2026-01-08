# Switch to Stock

This feature allows you to quickly switch back to Stock Creality Klipper (aka Crapper) after installing Simple AF, and being able to
quickly restore Simple AF without having to do a factory reset.  All that will be required after each switch is to power cycle
at least once to get the MCUs updated with the correct firmware.   The use case for this feature is mostly about supporting
Simple AF users who have a single printer and perhaps they need to switch back to stock to be able to print a mount or something.

Existing users of Simple AF will have to factory reset at least once to get the correct Creality Stock configuration files correctly
backed up, but for new users the feature will be available straight away.   If you have a `~/backups/creality-backup.tar.gz` file,
you can use the feature.

Its really important before you install Simple AF for the first time that you properly calibrate the printer in stock so that
switching back allows you to immediately use the printer, the switch to stock process does not restore the printer to a completely
stock configuration, as only klipper and the stock display are restored!

## Via GrumpyScreen

GrumpyScreen has an option for this from the Tools menu

![image](assets/images/grumpyscreen_switch_to_stock.png)

## Via SSH 

Switching to stock is as simple as running from ssh on the printer:

```
/usr/data/pellcorp/k1/switch-to-stock.sh
```

And then power cycling the printer after the script finishes execution

## Updating Stock Configuration

So if you installed Simple AF without calibrating your printer, the first time you switch to stock you will need to execute the
first run calibration, do that and then run `/usr/data/pellcorp/k1/switch-to-stock.sh --update` to update the stock config files backup
so that calibration can be reused on subsequent switch to stock usages, otherwise if you do not run the --update you will be forced to
run the first run calibration **every** time you switch to stock!

## Switching back to Simple AF

You can easily switch back with:

```
/usr/data/pellcorp/k1/switch-to-stock.sh --revert
```

And power cycling the printer once again

!!! danger

    Do not leave a probe mounted on the printer when you switch back to stock, this is especially important if you have 
    a rear mounted probe as it is very likely to be damaged when the printer does its nozzle wipe at the back of the printer
    
    Switching to stock does **not** allow using the printer with Helper Script, this is an emergency temporary mode!

    Switching to stock will leave moonraker, fluidd and mainsail accessible.   The stock screen is restored, but you must **not**
    try to perform a firmware upgrade in stock mode as this will most likely remove SimpleAF!
