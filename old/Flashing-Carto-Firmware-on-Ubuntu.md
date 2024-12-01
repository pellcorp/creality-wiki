**THIS IS A RISKY OPERATION YOU COULD EASILY BRICK YOUR CARTO**

**IMPORTANT:** Do not follow these instructions unless you have a USB V3 Carto!!!!!!

You must make sure that the cable you are using is pinned correctly.  For both flat pack and right angle carto's the default cable that comes with your carto might not be pinned correctly.

![image](https://github.com/user-attachments/assets/724d42ed-1776-4db5-897e-330c5585c39d)

**IMPORTANT:** The right angle and flat pack pin out is different to using a low profile carto, so the image above **does not apply** to low profile cartographers!

**IMPORTANT:** You **cannot** use the firmware.cartographer3d.com, it will not flash the proper version of `5.0.0 K1` firmware for the K1.

# Flashing the Cartographer

You will need some kind of linux environment, this can be a Raspberry Pi, desktop Linux or even a Linux Server if you can plug something in via USB.   If you do not have anything like that, you will need to create a Live USB key running Ubuntu 24.04 Desktop edition.

## Creating a Live USB Key

You should create a live USB with Ubuntu 24.04 Desktop, make sure the USB is at least 8GB in size!

https://ubuntu.com/tutorials/try-ubuntu-before-you-install#1-getting-started

# Installation dependencies

On your raspberry pi, linux desktop, linux server or live Ubuntu USB environment you need to run the following commands to install essential packages.

```
sudo apt-get update
sudo apt-get install virtualenv python3-dev python3-pip libffi-dev build-essential git dfu-util
```

# Clone Klipper and Cartographer-Klipper

```
git clone "https://github.com/Klipper3d/klipper" $HOME/klipper
git clone "https://github.com/Cartographer3D/cartographer-klipper.git" $HOME/cartographer-klipper
```

# Setup Klipper Virtual Env

```
virtualenv --system-site-packages $HOME/klippy-env
$HOME/klippy-env/bin/pip3 install -r $HOME/klipper/scripts/klippy-requirements.txt
```

# Flashing K1 Carto Touch V5.0.0 Firmware

This firmware is provided by Richard from Cartographer3d.com specifically for the K1, K1M and K1C.   It is critical that you flash your carto with this version of the Survey firmware over the official Survey Firmware on K1, K1M and K1C to avoid Timer Too Close errors for bed meshes.

## Enable Bootloader

```
CARTO_DEV=$(ls /dev/serial/by-id/usb-Cartographer*)
cd $HOME/klipper/scripts
sudo $HOME/klippy-env/bin/python -c "import flash_usb as u; u.enter_bootloader('$CARTO_DEV')"
```

You should see a message like:

```
Entering bootloader on /dev/serial/by-id/usb-Cartographer_614e_16000C000F43304253373820-if00
```
**Note:** If the carto does not enter bootloader mode, it is possible you forgot to use sudo!

**Note:** If your carto does show up in /dev/serial but won't enter bootloader mode, you will need to fix this with DFU, see
https://docs.cartographer3d.com/cartographer-probe/firmware/broken-katapult-bootloader

## Flashing

```
CATAPULT_DEV=$(ls /dev/serial/by-id/usb-katapult*)
sudo $HOME/klippy-env/bin/python $HOME/klipper/lib/canboot/flash_can.py -f $HOME/cartographer-klipper/firmware/v2-v3/survey/5.0.0/Survey_Cartographer_K1_USB_8kib_offset.bin -d $CATAPULT_DEV
```

You should see output this this:

```
Attempting to connect to bootloader
CanBoot Connected
Protocol Version: 1.0.0
Block Size: 64 bytes
Application Start: 0x8002000
MCU type: stm32f042x6
Flashing '/home/ubuntu/cartographer-klipper/firmware/v2-v3/survey/5.0.0/Survey_Cartographer_K1_USB_8kib_offset.bin'...

[##################################################]

Write complete: 22 pages
Verifying (block count = 338)...

[##################################################]

Verification Complete: SHA = BB45B9575AC57FFF03CA5FE09186DB479E09BF53
CAN Flash Success
```

**Note:** If the carto does not flash, it is possible you forgot to use sudo!

When you reconnect your carto to your printer it should show a version `CARTOGRAPHER 5.0.0 K1`:

![image](https://github.com/user-attachments/assets/a10c7dde-8af1-42c2-b740-679ca68e76cb)
