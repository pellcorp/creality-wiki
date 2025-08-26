# Wiring

!!! note

    This wiring section applies to K1/K1C/K1SE/K1M printers only

You will need to make a cable from the nozzle touch port to the 3 pin port on the klicky.

The TOUCH port on the Nozzle MCU board mates with a male 5-pin Molex Picoblade connector.
Some sellers may call the connector "Micro JST SH 1.25" but that is [incorrect](https://www.reddit.com/r/AskElectronics/comments/m6mibq/comment/gr6w1m0).

You could repin a CR-Touch cable (used for connecting bltouch / microprobe) with the 3 pin connector provided with the PCB Klicky, or make your own cable.

The Creality cable for their CR Touch probe is a good option although you will need to remove 2 of the wires for a neat connection

- <https://www.aliexpress.us/item/1005004960067376.html>
- <https://www.amazon.com/dp/B0BKPFY24M/>

You want to use the 3 top wires on the nozzle mcu TOUCH port.   Connect to TOUCH port on the nozzle MCU, it is accessible from the side left (LIDAR) side of the printhead and only the external cover of the printhead has to be removed.

![image](assets/images/nozzle_rear.png)

![image](assets/images/touch_port.png)

The wiring looks like this:

![image](assets/images/klicky_wiring.png)
