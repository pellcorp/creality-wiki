# MCU Firmware

Its likely if you are migrating from Marlin (for instance for a Ender 3 V3 SE), you will need to flash new klipper
firmware to the mainboard (this is not the same as the RPI), and for the moment at least this guide is lacking
a lot of details for that.

I think the easiest approach here is to install Simple AF and acccept that the MCU likely won't connect and then
login to your RPI and use make menuconfig and make to create the firmware so you can get that flashed in whatever
method is required for your mainboard.

Creality mainboards in general require the use of an SD-Card to get this done, BTT boards can sometimes be flashed
from the cli on the printer (ymmv).   Please consult manufacturer instructions where appropriate.

## Ender 3 V3 SE

The Ender 3 V3 SE is a bit painful to flash, and it depends on which version of the board you have (C13 vs C14), but 
there are a few guides this one looks to be the most detailed:

For building the firmware: <https://athemis.me/projects/klipper_guide/#create-printer-firmware-bin-file>
For getting it onto your printer: <https://athemis.me/projects/klipper_guide/#flash-3d-printer>

