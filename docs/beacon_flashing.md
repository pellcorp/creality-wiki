# Beacon Flashing

!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR BEACON

## Flashing the Beacon

You will need some kind of linux environment, this can be a Raspberry Pi, desktop Linux or even a Linux Server if you can plug something in via USB.   If you do not have anything like that, you will need to create a Live USB key running Ubuntu 24.04 Desktop edition.

### Creating a Live USB Key

You should create a live USB with Ubuntu 24.04 Desktop, make sure the USB is at least 8GB in size!

<https://ubuntu.com/tutorials/try-ubuntu-before-you-install#1-getting-started>

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
cd $HOME/beacon-klipper
sudo -E ./install.sh
```

![image](assets/images/beacon_dfu.png)
