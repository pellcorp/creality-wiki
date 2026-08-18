!!! klipper-error "Coming Soon"

    Installing Simple AF on a Nebula Pad is not available yet

# Simple AF on a Nebula Pad

We are introducing support for running Simple AF with a retail Nebula Pad for some older Ender printers.

## Supported Printers

- Ender 3 V2 with 4.2.2 mainboard
- Ender 3 V3 SE C13 mainboard

Additional printers that can be connected via the IDC display port will be added over time

## SimpleAF Base Firmware

You must factory reset your Nebula Pad and install the Simple AF base nebula firmware, you must download this firmware
and flash it via the stock UI or from the command line (you will need root access)

Download the [SimpleAF_NEBULA_ota_img_V8.1.1.0.29.img](https://github.com/pellcorp/downloads/raw/refs/heads/main/creality/prerooted/SimpleAF_NEBULA_ota_img_V8.1.1.0.29.img) and save it to a Fat32 formatted USB Key and insert it into your Nebula Pad.

You have a few options for flashing the firmware to your Nebula Pad

### Flash the firmware from the stock UI

The stock UI should prompt you to install the updated firmware when the USB is inserted!

### Via the command line on the printer

You will need root access to the printer, and then run this command:

```
/etc/ota_bin/local_ota_update.sh /tmp/udisk/sda1/SimpleAF_NEBULA_ota_img_V8.1.1.0.29.img
```

### Ingenic Cloner

Coming soon

## How do I login?

You need to setup wifi either via usb or the bootstrap ui and once you have an IP Address, you can ssh into the printer with:

```
ssh root@THE_IP_ADDRESS
```

The password is `Creality2023`

## Printer Firmware

You will need to flash your printer with klipper firmware in the way that each printer needs to be flashed, usually
this will entail copying the bin file to a SD or Micro SD card and placing into the printer and restarting the printer, you should not
have the printer connected to the Nebula Pad at this stage.

| Mainboards                | URL                                                                                     | Notes                                                         |
|---------------------------|-----------------------------------------------------------------------------------------|---------------------------------------------------------------|
| Creality 4.2.2 and 4.2.7  | <https://github.com/pellcorp/klipper/raw/refs/heads/jun2025/fw/NEBULA/creality-42x.bin> | This firmware works for STM32 and GD32 variants of the boards |
| Ender 3 V3 C13            | TODO                                                                                    | C13 board only                                                | 
