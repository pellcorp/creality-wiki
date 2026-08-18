!!! klipper-error "Coming Soon"

    Installing Simple AF on a Nebula Pad is not available yet

# Simple AF on a Nebula Pad

We are introducing support for running Simple AF with a retail Nebula Pad for some older Ender printers.

## Supported Printers

- Ender 3 V2 with 4.2.2 mainboard
- Ender 3 V3 SE C13 mainboard

Additional printers will be added over time

## SimpleAF Base Firmware

You must factory reset your Nebula Pad and install the Simple AF base nebula firmware, you must download this firmware
and flash it via the stock UI or from the command line (you will need root access)

Download the SimpleAF_NEBULA_ota_img_V1.1.0.29.img, save it to a Fat32 formatted USB Key and insert it into your Nebula Pad

<https://github.com/pellcorp/downloads/blob/main/creality/prerooted/SimpleAF_NEBULA_ota_img_V1.1.0.29.img>

You can flash the firmware from the stock UI or via the command line on the printer with the command:

```
/etc/ota_bin/local_ota_update.sh /tmp/udisk/sda1/SimpleAF_NEBULA_ota_img_V1.1.0.29.img
```

## Printer Firmware

You will need to flash your printer with klipper firmware in the way that each printer needs to be flashed, usually
this will entail copying the bin file to a SD or Micro SD card and placing into the printer and restarting the printer, you should not
have the printer connected to the Nebula Pad at this stage.

!!! note 

    Prebuilt firmware for the printers we support will be available from:
    <https://github.com/pellcorp/klipper/tree/jun2025/fw/NEBULA>

## How do I login?

You need to setup wifi either via usb or the bootstrap ui and once you have an IP Address, you can ssh into the printer with:

```
ssh root@THE_IP_ADDRESS
```

The password is `Creality2023`

