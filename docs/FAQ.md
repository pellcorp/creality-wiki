---
hide:
  - footer
---

## What is Bed Warp Stabilization and why is it good?
Bed Warp Stabilisation  Macro (bed heat soaking) is performed before every print by default with the initial installation of the Simple AF firmware. The macro will wait 8 seconds for every degree of target bed temp. 
This process allows the heated bed to settle into its final state of expansion before performing the bed mesh. At the end of a print, the  bed will remain heated until the printer times out in an hour.  
See: Start_End.cfg for additional parameters

## Can Bed Warp Stabilisation be disabled?
Yes. A toggle switch is located in the Fans and Outputs section of your Fluidd UI. Triggering this toggle temporarily disables the macro. 
You can disable it permanently by changing the `start_end.cfg` `[output_pin Bed_Warp_Stabilisation]` `value` to `0`. The start_end.cfg can be found in the Configurations folder ('{...}' tab)

## Can I Use Bed Warp Stabilization but have it turned off?
There isn't a feature to support using bed warp stabilization but turning it off in Klipper. You can work around this limitation by adding the g-code `TURN_OFF_HEATERS` after `END_PRINT` in your slicer's machine end print g-code section.

## Are there Parameters I can change?
Start_End.cfg ParametersYou can also modify the following configuration in `_START_END_PARAMS`:

- variable_bed_warp_wait_multiplier

So this value is how many seconds per degree of final bed target temp.

- variable_bed_warp_fraction_wait

If the bed temp is at least 75% of target we will do partial heat soak, if it's less than 75% will heat soak then entire target amount.

- variable_bed_warp_wait_interval

This is how long the macro will sleep between notifications 

Also note that at the end of a print the heater of the bed will remain heated until the printer times out in a hour.