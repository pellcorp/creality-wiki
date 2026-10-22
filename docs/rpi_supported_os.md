# Supported OS

Simple AF is best supported by RPi or OrangePi running a version of debian **11, 12 or 13** (which includes Orange Pi Debian, Rasbian, Arbian, whatever BTT is doing, etc).

!!! danger

    Do not try and install Simple AF for RPi on Mainsail OS or onto an existing klipper environment which has been setup using kiuah

## Pre-built Simple AF images

A few projects ship a flashable image with Simple AF already on the card. Flash the image for **your** SBC, then follow that project's first-boot notes. Depending on the image, after login you may still need to run `~/pellcorp/installer.sh` (or their wrapper) to pick printer / probe / mount. See [Simple AF for RPi](rpi.md).

| Project | Boards | Base OS |
|---------|--------|---------|
| [Fly-Bian Project](https://github.com/0dysseusRex/fly-bian) | Mellow Fly Lite 2.1; Mellow Fly Pi V3 | Armbian (Debian 13 / Trixie) |

## Raspberry Pi OS

So far been tested to work on a pi 3, 4 and 5, it does not matter whether you use 32 or 64 bit OS.
It is recommended to use the [Rpi Imager](https://www.raspberrypi.com/software/) and choose `Raspberry PI OS Lite (64-bit)` or `Raspberry PI OS (Legacy, 64 bit) Lite`

!!! note

    If for some strange reason your DHCP server provides an invalid DHCP option, you will need to modify the config, for debian 12 onwards
    its likely going to be network manager.

    Assuming you are using Ethernet, something like this might work:
    
    ```
    sudo nmcli connection modify "Wired connection 1" ipv4.ignore-auto-dns yes ipv4.dns "1.1.1.1 8.8.8.8"
    sudo nmcli connection down "Wired connection 1"
    sudo nmcli connection up "Wired connection 1"
    ```

You must login as the **pi** (Default password is `raspberry`) user to perform the installation, you are not allowed to run the installer as root!

## Orange Pi OS

Please note that OrangePi OS (based on Arch) **is not supported** and will fail to install because the installer assumes a debian based OS, this is unlikely
to change anytime soon.

## Orange Pi Debian OS

Testing has been done on an Orange Pi Zero 3 W running a server image available from:
<https://drive.google.com/drive/folders/10zlO-0mMz-fqRQOKAOWX-mQA_UbN_C1n>

!!! note

    Please make sure to set `bootlogo=true` in the `orangepiEnv.txt` before booting for the first time so that
    the boot display works correctly.

    When running the `sudo apt-get update` you might get an error complaining about `Err:36 https://repo.huaweicloud.com/docker-ce/linux/debian bullseye/stable arm64 Contents`,
    this is a long standing bug (from 2023) that was never fixed and the work around is to run:
    ```
    sudo rm /etc/apt/sources.list.d/docker.list
    sudo apt-get --allow-releaseinfo-change update
    ```

You must login as the **orangepi** (Default password is `orangepi`) user to perform the installation, you are not allowed to run the installer as root!

!!! warning

    By default the `orangepi` user cannot sudo without providing a password, the installer will create a ` /etc/sudoers.d/nopasswd` file
    to enable no password sudo for the orangepi user.

## DietPi OS

Basic testing has been done with DietPi (Bookworm) running on an Orange Pi 3 Zero W

Some trouble was encountered getting DietPi setup in a home network which uses a PiHole connected to cleanbrowsing.org DNS family filter
which prevented the default DNS settings from working.

The dietpi.txt was updated as follows:

```
AUTO_SETUP_AUTOMATED=1
SURVEY_OPTED_IN=0
CONFIG_CHECK_CONNECTION_IP=8.8.8.8
CONFIG_CHECK_CONNECTION_IPV6=2001:4860:4860::8888
CONFIG_CHECK_DNS_DOMAIN=google.com
CONFIG_CHECK_DIETPI_UPDATES=0
CONFIG_CHECK_APT_UPDATES=0
CONFIG_SERIAL_CONSOLE_ENABLE=0
```

You do not want the OS doing updates while prints are going so updating should be controlled by Moonraker only.   The DNS check configuration was reconfigured to use google as the quad9 DNS was not resolved by cleanbrowsing.org, of course your situation may be completely
different and the above options might be overkill.

A few hops are needed to be jumped through before getting the OrangePi setup, no idea if this is due to some weird
combination of settings above.  You have to physically power off the device after the first run finishes and the
pi hole is supposedly rebooted, otherwise ethernet does not come back.

Login as root after powering up the device for the first time, and it will tell you that first run setup is going on in a
different screen and will eventually let you know a restart will be required, wait until you are kicked from the SSH session and then give it
a minute and power cycle the pi.

Then login as the **dietpi** (Default password is `dietpi`) user to start the installation, after logging in, you may be told that first run setup is still going,
give it a few minutes and you should be greeted with a login prompt.

## Ubuntu based distributions

On Ubuntu 22.04 or 24.04 based distributions, it might work but no formal testing has been performed as yet!

## Armbian

On Debian 11, 12 or 13, Ubuntu 22.04 or 24.04 based distributions

!!! note

    We have user reports of successful testing of Simple AF for RPI with Debian Bookworm and Ubuntu 22.04 :-)

## BTT OS

On Debian 11, 12 or 13 based, might work but no formal testing has been performed as yet!
