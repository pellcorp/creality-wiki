# Frequently Asked Questions

## How do I use my cartographer for input shaping?

!!! note

    These instructions do not apply to Simple AF for RPi, although it is certainly possible to use the Cartographer as ADXL on non creality printers.

This just needs a few changes in `printer.cfg`

You need to modify the `[adxl345]` section

First of all change the `cs_pin` from `nozzle_mcu:PA4` to `scanner:PA3`

Then disable the following settings:

- `spi_speed: 5000000`
- `spi_software_sclk_pin: nozzle_mcu:PA5`
- `spi_software_mosi_pin: nozzle_mcu:PA7`
- `spi_software_miso_pin: nozzle_mcu:PA6`

And add the following settings:

- `spi_bus: spi1`
- `axes_map: x, y, z`

So your [adxl345] should look like:

 ```
 [adxl345]
 #cs_pin: nozzle_mcu:PA4
 cs_pin: scanner:PA3
 spi_bus: spi1
 #spi_speed: 5000000
 axes_map: x, y, z
 #spi_software_sclk_pin: nozzle_mcu:PA5
 #spi_software_mosi_pin: nozzle_mcu:PA7
 #spi_software_miso_pin: nozzle_mcu:PA6
 ```

I do not know if this is a good idea, I just know it's possible!

**Source:** <https://docs.cartographer3d.com/cartographer-probe/installation-and-setup/installation/klipper-configuation>
