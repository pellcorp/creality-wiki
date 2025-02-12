!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR EDDY

## Creating a Live USB Key

If you do not have a Raspberry PI or an Linux Desktop or Server machine, you can create a live USB and boot into that, the following instructions work fine on a Usb Key, just make sure the USB is at least 8GB in size to allow for installing the packages we need and cloning klipper.

<https://ubuntu.com/tutorials/try-ubuntu-before-you-install#1-getting-started>

## Install some deps on Ubuntu 

```
sudo apt-get install build-essential git libusb-1.0.0-dev pkg-config
```

## Flashing

### Connecting in BOOTSEL mode

You need to connect your btt eddy to your computer in BOOTSEL mode, you do this by disconnecting the eddy usb, and then push and hold boot button on Eddy (It's next to where the cable plugs in) and at the same time, plug in the cable to your computer.

You know its correct if you run an `lsusb` and see:
![image](assets/images/btteddy_lsusb_rpi_boot.png)

### Flashing btteddy.uf2 file

First of all you need klipper:

```
git clone https://github.com/pellcorp/klipper.git
```

Then we need to build the rp2040_flash flasher:
```
cd klipper/lib/rp2040_flash
make
cd -
```

**Note:** If make fails you forgot to install `build-essential` package:

```
sudo apt-get install build-essential
```

Then try the make again

Then we need to do the actual flashing:

```
cd klipper
sudo python3 ./scripts/flash_usb.py -t rp2040 -d 2e8a:0003 fw/K1/btteddy.uf2
```

!!! note

    We are not compiling new firmware, just flashing the firmware I have already prepared.
