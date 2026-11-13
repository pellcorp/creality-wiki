# MCU Firmware

You will need to flash new kalico firmware to the mainboard (this is not the same as the RPI), and for the moment at 
least this guide is lacking a lot of details for that.

We think the easiest approach here is to install Simple AF and acccept that the MCU likely won't connect and then
login to your RPI and use make menuconfig and make to create the firmware so you can get that flashed in whatever
method is required for your mainboard.

Creality mainboards in general require the use of an SD-Card to get this done, BTT boards can sometimes be flashed
from the cli on the printer (ymmv).   Please consult manufacturer instructions where appropriate.

## Ender 3 V3 SE

We have prebuilt Ender 3 V3 SE firmware for both variants to make things easier.

| Mainboards                | URL                                                                         |
|---------------------------|-----------------------------------------------------------------------------|
| Ender 3 V3 SE (C14 Board) | <https://github.com/pellcorp/kalico-rpi/blob/aug2026/fw/rpi/e3v3se.bin>     | 
| Ender 3 V3 SE (C14 Board) | <https://github.com/pellcorp/kalico-rpi/blob/aug2026/fw/rpi/e3v3se-c14.bin> |

### C13 Board

!!! danger

    Flashing the C14 firmware to a C13 board is very likely to brick it because the C13 has a 28KB bootloader offset amongst other differences.

Copy the firmware bin file to the root of your SD-Card and rename to a unique filename in 8.3 format, something you have not flashed before, such as fw-1113.bin.

### C14 Board

!!! danger

    Flashing the C13 firmware to a C14 board is very likely to brick it because the C14 has a 64KB bootloader offset amongst other differences.

Copy the firmware bin file to a folder `STM32F4_UPDATE` on your SD-Card and rename to a unique filename in 8.3 format something you have not flashed before, such as fq-1115.bin.

## SKR Mini E3 V2

It is important to ensure the !PA14 GPIO setting is configured, but even more important for RP3 is to ensure that the config.txt
setting `dtoverlay=dwc2` is enabled in the `[all]` section, otherwise klipper is going to crash the entire pi every time
it tries to start up and you will racing to stop it after ssh into the pi to deal with this after the installation.
