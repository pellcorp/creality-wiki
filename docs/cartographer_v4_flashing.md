!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR CARTO

    Do not follow these instructions unless you have a **USB V4 Cartographer** !!!!!!

!!! warning

    You might corrupt the katapult boot loader trying to use a Linux VM or WSL to flash the carto, I strongly recommend a live USB over a VM or WSL!

## Verify your Cable

You must make sure that the cable you are using is pinned correctly.

![image](assets/images/carto_connector.png)

!!! warning
    
    The right angle and flat pack pin out is different to using a low profile carto, so the image above **does not apply** to low profile cartographers!

    You **must** not use the firmware.cartographer3d.com, it will not flash the proper version of `CARTOGRAPHER V4 6.0.0 Lite` firmware for the K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max!

    The reason this cannot be done on the printer, seems to be some incompatibility with pyserial and MIPS, and issue for this has been opened 
    <https://github.com/Arksine/katapult/issues/137> 

## Flashing the Cartographer

You will need some kind of linux environment, this can be a Raspberry Pi, desktop Linux or even a Linux Server if you can plug something in via USB.   If you do not have anything like that, you will need to create a Live USB key running Ubuntu 24.04 Desktop edition.

### Creating a Live USB Key

You should create a live USB with Ubuntu 24.04 (25.04 also works) Desktop, make sure the USB is at least 8GB in size!

<https://ubuntu.com/tutorials/try-ubuntu-before-you-install#1-getting-started>

## Installation dependencies

On your raspberry pi, linux desktop, linux server or live Ubuntu USB environment you need to run the following commands to install essential packages.

```
sudo apt-get update
sudo apt-get install virtualenv python3-dev python3-pip python3-setuptools libffi-dev build-essential git dfu-util
```

## Clone Klipper and Cartographer-Firmware

```
git clone "https://github.com/Klipper3d/klipper" $HOME/klipper
git clone "https://github.com/Cartographer3D/cartographer_firmware" $HOME/cartographer_firmware
```

!!! note 

    If you already have `cartographer_firmware` cloned locally, make sure you are on latest `main` like so:
    
    ```
    cd $HOME/cartographer_firmware
    git fetch
    git switch main
    git reset --hard origin/main
    ```

## Setup Klipper Virtual Env

```
virtualenv --system-site-packages $HOME/klippy-env
$HOME/klippy-env/bin/pip3 install -r $HOME/klipper/scripts/klippy-requirements.txt
```

## Flashing K1 Cartographer Firmware

This firmware is provided by Richard from Cartographer3d.com specifically for the potato printers like the K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max.   It is critical that you flash your cartographer with this version of the Survey firmware over the official Survey Firmware on K1, K1SE, K1C, K1M, Ender 3 V3 KE and Ender 5 Max to avoid stuttering and instability, especially during bed meshes!

### Connect Cartographer via USB

Plug the cartographer into your computer and make sure it shows up if you type `lsusb` you should find an entry something like this:

```
Bus 001 Device 067: ID 1d50:614e OpenMoko, Inc.
```

### Enable Bootloader

```
CARTO_DEV=$(ls /dev/serial/by-id/usb-* | grep "IDM\|Cartographer" | head -1)
cd $HOME/klipper/scripts
sudo -E $HOME/klippy-env/bin/python -c "import flash_usb as u; u.enter_bootloader('$CARTO_DEV')"
```

!!! warning 

    If you get a message like `ls: cannot access '/dev/serial/by-id/usb-*': No such file or directory`, it means you forgot the `*` in the command above, your carto cable is incorrectly pinned or
    you are using a VM or WSL (against advice) and have not passed through the Cartographer USB Device!

You should see a message like:

```
Entering bootloader on /dev/serial/by-id/usb-Cartographer_614e_16000C000F43304253373820-if00
```

!!! note

    If the carto does not enter bootloader mode, it is possible you forgot to use sudo!
    If your carto does show up in /dev/serial but won't enter bootloader mode, you will need to fix this with [DFU mode](#flashing-k1-firmware-via-dfu-mode)

### Flashing

```
CATAPULT_DEV=$(ls /dev/serial/by-id/usb-katapult*)
sudo -E $HOME/klippy-env/bin/python $HOME/klipper/lib/canboot/flash_can.py -f $HOME/cartographer_firmware/firmware/v4/firmware/6.0.0/CartographerV4_6.0.0_USB_lite_8kib_offset.bin -d $CATAPULT_DEV
```

You should see output like this:

```
/home/jason/klipper/lib/canboot/flash_can.py:589: DeprecationWarning: There is no current event loop
  loop = asyncio.get_event_loop()
Attempting to connect to bootloader
CanBoot Connected
Protocol Version: 1.1.0
Block Size: 64 bytes
Application Start: 0x8002000
MCU type: stm32g431xxv0.0.1-104-gfcb2f84-dirty
Flashing '/home/jason/cartographer_firmware/firmware/v4/firmware/6.0.0/CartographerV4_6.0.0_USB_lite_8kib_offset.bin'...

[##################################################]

Write complete: 14 pages
Verifying (block count = 435)...

[##################################################]

Verification Complete: SHA = FCA6E37F4D9F344E7AF18C7609AEBBCFD6E597E0
CAN Flash Success
```

!!! note

    If the carto does not flash, it is possible you forgot to use sudo!

!!! warning

    If you get a message like `ls: cannot access '/dev/serial/by-id/usb-katapult*': No such file or directory`, it means you forgot the `*` in the command above,  
    you are using a VM or WSL (against advice) and have not passed through the `katapult stm32f042x6` USB Device!

    If the Cartographer is no longer flashing blue its also possible the katapult bootloader has become corrupted which is actually frighteningly easy to do
    which is why I generally discourage the use of WSL or VMs!

When you reconnect your carto to your printer it should show a version `CARTOGRAPHER V4 6.0.0 Lite`:

**Source:** <https://docs.cartographer3d.com/cartographer-probe/firmware/manual-methods/cartographer-with-input-shaper/update-via-katapult-recommended#updating-a-usb-probe-via-katapult>

![image](assets/images/cartographer_v4_600.png)

## Flashing K1 Firmware via DFU Mode

!!! note

    This process is applicable for K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max!

You need to bridge the boot pins before you plug your carto in via USB to your Linux session, make sure `lsusb` reports it being in DFU mode, it should show

![image](assets/images/carto_lsusb_dfu.png)

Then cd to the combined firmware directory 

```
cd $HOME/cartographer_firmware/firmware/v4/combined-firmware/6.0.0
```

And run dfu-util to write the firmware:

```
sudo dfu-util -R -a 0 -s 0x08000000:leave -D Katapult_plus_CartographerV4_6.0.0__USB_lite.bin
```

**Source:** <https://docs.cartographer3d.com/cartographer-probe/firmware/manual-methods/cartographer-with-input-shaper/update-via-dfu-mode>
