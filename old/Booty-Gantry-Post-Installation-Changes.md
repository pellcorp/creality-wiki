So you have a booty gantry, well good for you! 

Whatever probe you install, you are going to have to make some changes post installation as Simple AF does not do that for you.

The main items to change are going to be in the printer.cfg

Follow the directions from this guide:
https://docs.google.com/document/d/1Ukik8NQP-NaaIlxUGDL1LRnvDen-fuH08jcouCDt8B0/edit?tab=t.0

And you will also need to tune sensorless homing

You can find the details here:
https://www.klipper3d.org/TMC_Drivers.html#sensorless-homing

But the main things to change are going to be the `driver_SGTHRS` in `[tmc2209 stepper_x]` and `[tmc2209 stepper_y]`

