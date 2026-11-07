---
seo_title: "Cartographer Flashing on Creality K1 - Guide"
toc_section_depths:
  running-the-cartographer-fw-update-script: 3
---
# Cartographer Flashing

We have introduced support for flashing the Cartographer V3 and V4 via the official cartographer3d.com tool.

!!! danger

    There is always the risk of soft bricking your cartographer with the following method, it can be recovered with [DFU mode](legacy_cartographer_flashing.md#flashing-via-dfu-mode) via live usb!

!!! note

    The [upstream doc](https://docs.cartographer3d.com/cartographer-probe/firmware/updating-firmware) mentions the need for a PI and to have cloned cartographer_firmware and katapult, this is **not** required
    for Simple AF as the installer clones those repos for you and we will be flashing directly on the printer.

Flashing the cartographer to have the K1 / Lite firmware **requires that you have installed Simple AF first**, you **must not**
flash the cartographer on the printer before Simple AF is installed!!!

!!! danger

    Any attempt to circumvent this and clone cartographer_firmware yourself onto the printer before installing Simple AF is very
    likely to soft brick your cartographer [requiring DFU mode](legacy_cartographer_flashing.md#flashing-via-dfu-mode)

Mount your cartographer onto the printer and connect it to USB and then get Simple AF installed first then come back to update the cartographer to have Lite firmware
before trying to use it.

## Updating the Firmware

If you already have Simple AF installed, and you want to update the firmware you should first of all make sure you are running the latest
version of Simple AF by running an update:

```
/usr/data/pellcorp/installer.sh --branch main
/usr/data/pellcorp/installer.sh --update
```

![image](assets/images/simpleaf_fully_updated.png)

You want to see: `ERROR: Installation is already up to date - NO CHANGES WERE MADE!`, do NOT proceed with trying to update Cartographer
if you do not see that, failing to heed this warning will likely soft brick your cartographer [requiring DFU mode](legacy_cartographer_flashing.md#flashing-via-dfu-mode)

## Running the Cartographer FW Update script

After you have updated Simple AF you can run the firmware update script:

```
/usr/data/cartographer_firmware/fw_update.sh
```

The process will go through a few screens.

### Welcome Screen

![image](assets/images/cartographer/fw_update.png)

Press Enter here!

### Detecting your probe

![image](assets/images/cartographer/detecting_your_probe.png)

If all looks correct, press Enter again.

!!! warning "Could not determine probe type automatically"

    If you instead get an error saying `Could not determine probe type automatically`,

    ![image](assets/images/cartographer/cartographer_not_found.png)

    It means you did not have your cartographer connected while installing or updating Simple AF, please use `CTRL-C` to exit the fw_update script and instead run:
    
    ```
    ~/pellcorp/installer.sh --fix-serial
    ```
    
    Then you can start the fw update script

### Firmware recommendation screen

![image](assets/images/cartographer/firmware_recommendation.png)

!!! note

    We recommend the following firmware versions, as ones we have tested extensively:

    - For V3 probes choose `5.0.0`
    - For V4 probes choose `6.0.0`

    Its quite likely newer firmware will work fine but we have never tested it!

Press Enter again!

### Confirmation screen

![image](assets/images/cartographer/firmware_recommendation_confirmed.png)

If all looks correct, press Enter again!

### Your selection screen

![image](assets/images/cartographer/your_selection.png)

If all looks correct ...

Enter `y` at the `Run Klipper flash_can.py now with the selected firmware? [Y/n]` prompt and press Enter again!

Enter `y` at the `Did you read the above information? [Y/n]` prompt and press Enter again!

!!! warning

    The flashing tool says DFU mode can be performed on this host, for the moment that is not the case and you will 
    need a live usb method for [DFU mode](legacy_cartographer_flashing.md#flashing-via-dfu-mode)!

### Flash your cartographer

![image](assets/images/cartographer/flashing.png)

### Send Report 

Please choose `1` and press Enter, it helps the cartographer team to know how many people are using cartographers with K1 / Lite firmware.

![image](assets/images/cartographer/send_report.png)

### Fix Serial Cartographer

Sometimes flashing new firmware can change the serial, so it's always a good idea to run --fix-serial after the flashing is finished. 

```
/usr/data/pellcorp/installer.sh --fix-serial
```

![image](assets/images/cartographer/fix_serial.png)

#### Restarting Kalico

!!! note

    Kalico will not see the updated firmware on the Cartographer unless its been restarted after flashing, the cartographer3d script does not do this for you, if `~/pellcorp/installer.sh --fix-serial` did not change anything it will **not** restart kalico, so you have to do it yourself.

If you see `INFO: Restarting Kalico` you can go back to Fluidd or Mainsail and wait for Kalico to restart,
if however it says: `Serial value is unchanged` you will need to force Kalico to restart yourself with:

```
/etc/init.d/S55klipper_service restart
```

!!! note

    Running the restart command will produce no output, but if you check Fluidd / Mainsail it should show
    Kalico is restarting.   Also please note even though it says `S55klipper_service` it is restarting Kalico!
