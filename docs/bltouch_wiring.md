# BlTouch Wiring

!!! note

    This wiring section applies to K1/K1C/K1SE/K1M printers only

The probe and the TOUCH port on the Nozzle MCU board both mate with a 5-pin Molex Picoblade connector. A 5-pin cable is needed to connect the probe to the TOUCH port.

Some sellers may call the connector "Micro JST SH 1.25" but that is [incorrect](https://www.reddit.com/r/AskElectronics/comments/m6mibq/comment/gr6w1m0). Several premade cables are compatible. Most notably the Creality cable for their CR Touch probe:

- <https://www.aliexpress.us/item/1005004960067376.html>
- <https://www.amazon.com/dp/B0BKPFY24M/>

![image](assets/images/bltouch_wiring.png)

![image](assets/images/touch_wiring.jpg)

Connect to TOUCH port on the nozzle MCU. it is accessible from the side left (LIDAR) side of the printhead and only the external cover of the printhead has to be removed.

![image](assets/images/nozzle_rear.png)

![image](assets/images/touch_port.png)

!!! important

    The configuration file assumes a bltouch is mounted on the back of the tool head.   If you have a Crtouch or are mounting your bltouch or 3dtouch using a different model, you must make additional changes to the bltouch.cfg file before trying to home your printer.

!!! note 

    Portions of this section are copied from the K1 Bltouch guide for helper script.
