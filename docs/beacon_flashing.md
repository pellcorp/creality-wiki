!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR BEACON

## Creating a Live USB Key

If you do not have a Raspberry PI or an Linux Desktop or Server machine, you can create a live USB and boot into that, the following instructions work fine on a Usb Key, just make sure the USB is at least 8GB in size to allow for installing the packages we need and cloning klipper and cartographer-klipper.

https://ubuntu.com/tutorials/try-ubuntu-before-you-install#1-getting-started

## Install some deps on Ubuntu 

```
sudo apt-get update
sudo apt-get install virtualenv python3-dev python3-pip libffi-dev build-essential git dfu-util
```

## Clone Klipper and Beacon-Klipper

```
git clone "https://github.com/Klipper3d/klipper" $HOME/klipper
git clone https://github.com/beacon3d/beacon_klipper.git $HOME/beacon-klipper
```

## Setup Klipper Virtual Env

```
virtualenv --system-site-packages $HOME/klippy-env
$HOME/klippy-env/bin/pip3 install -r $HOME/klipper/scripts/klippy-requirements.txt
```

## Flash Beacon

```
sudo $HOME/beacon-klipper/install.sh
```

![image](assets/images/beacon_dfu.png)
