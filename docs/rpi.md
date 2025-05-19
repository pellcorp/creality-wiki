# Simple AF for RPi

!!! warning

    This feature is being actively worked on and has not been officially released so its bound to be broken from time to time as I add
    required features and sometimes existing stuff breaks, over the next few weeks I hope to polish it sufficiently that it can be 
    officially released, but we are not there yet.

    Outstanding and solved issues for RPi variant here:
    <https://github.com/pellcorp/creality/issues/702>

Work is being done to bring Simple AF to the RPi (and other rpi like sbc)

## Supported OS

Simple AF for RPi requires a version of debian 11 or 12 and has only been tested in raspberry pi 3, 4 and 5, it does not matter whether you use 32 or 64 bit OS.  It is recommended to use the [Rpi Imager](https://www.raspberrypi.com/software/) and choose `Raspberry PI OS Lite (64-bit)` or `Raspberry PI OS (Legacy, 64 bit) Lite`

Simple AF for RPi will be tested on Orange Pi and other devices in the future, but for now I can only guarantee function on official Rpi devices. 

!!! danger

    Do not try and install Simple AF for RPi on Mainsail OS or onto an existing klipper environment which has been setup using kiuah

## Installation

### Cloning repo

The following commands should be executed to get the repo locally:

```
sudo apt-get update
sudo apt-get install --yes git wget
git clone https://github.com/pellcorp/creality.git ~/pellcorp
~/pellcorp/rpi/installer.sh --branch jp_simpleaf_rpi
```

### Installing

The installation command is very similar to K1 series:

```
~/pellcorp/rpi/installer.sh --install --printer <ThePrinter> <TheProbe> --mount <TheMount>
```

- Where `--printer <ThePrinter>` is a predefined or downloaded printer definition
- Where `--mount <TheMount>` is only required for some predefined printer definitions
- Where `<TheProbe>` is one of bltouch, microprobe, cartotouch, beacon, klicky, btteddy or eddyng. 

#### Predefined Printer

You need to figure out what kind of mainboard you have because that will dictate whether you can  use a predefined printer cfg file 
or you need to provide your own.  The easiest way to find out what predefined printers are available is to run the command:

```
~/pellcorp/rpi/installer.sh --install --printer
```

![image](assets/images/rpi_install_printers.png)

!!! note

    For the `--printer` argument specify the ID of the printer so for instance `--printer creality-ender3-v3-se`

#### Downloaded Printer Definition

Otherwise you will need to download a basic printer config, this definition should **not** include any kind of probe
configuration, this should just have the basics:

- extruder
- heaters
- steppers
- the `[printer]` section
- fans
- filament runout

You can download a definition from <https://github.com/pellcorp/klipper-rpi/blob/master/config/> with wget, something like:

```
wget https://raw.githubusercontent.com/pellcorp/klipper-rpi/refs/heads/master/config/generic-bigtreetech-skr-pico-v1.0.cfg -O ~/bigtreetech-skr-pico-v1.0.cfg
```

!!! note

    For the `--printer` argument specify the path to the file, so `--printer ~/bigtreetech-skr-pico-v1.0.cfg`

#### Choose a Probe

You need to choose a probe one of:

- Cartotouch
- Beacon
- BlTouch
- Microprobe
- Klicky
- BttEddy
- Eddyng

!!! warning

    Refer to the other guides for probe specific config, but keep in mind that any references to `/usr/data/` in those guides should be replaced
    with your PI users home directory (so /home/pi, home/orangepi, /home/whatever)

#### Choose a mount

If you have chosen a predefined printer its possible it will require you to choose a mount, just like for K1 series, you can run the installer
with the --mount option without an argument to get a list of possible mounts:

![image](assets/images/rpi_choose_mount.png)

## Post Installation issues

### Rpi Camera

I've not found a way to get the V1 cam working with rasbian 12, only with 11 and enable classic legacy cam support
and then it just works.

### KlipperScreen

The installer will automatically install KlipperScreen on Pi4 or above, there are concerns of overloading a pi3
or less with klipperscreen so the installer will install grumpyscreen for lower specced devices, you can actually
force the installation of KlipperScreen afterwards by running:

```
sudo systemctl stop grumpyscreen
sudo systemctl disable grumpyscreen
~/pellcorp/rpi/install-klipperscreen.sh
```

### Grumpyscreen

#### BTT HDMI Screen

For whatever reason Grumpyscreen does not work nicely with a HDMI screen its on my list of TODOs to fix this, if possible
setup Simple AF on a Pi4 or above to get KlipperScreen.

#### BTT DSI Screen

Support for grumpyscreen will be provided for BTT DSI screens but you need to setup the screen to be correctly configured.

<https://github.com/bigtreetech/TFT43-DIP>

By default when grumpyscreen starts its probably going to look like:

![image](assets/images/grumpyscreen_rpi_error.png)

The following changes are required to fix that:

Need to download the dtbo file:

```
sudo wget https://raw.githubusercontent.com/bigtreetech/TFT43-DIP/master/gt911_btt_tft43_dip.dtbo -O /boot/overlays/gt911_btt_tft43_dip.dtbo
```

Needs this in `/boot/firmware/config.txt` (for bookworm) or `/boot/config.txt` (for bulleye)

```
[all]
gpu_mem=160

dtoverlay=vc4-kms-dpi-generic
dtparam=rgb666-padhi,clock-frequency=32000000
dtparam=hactive=800,hfp=16,hsync=1,hbp=46
dtparam=vactive=480,vfp=7,vsync=3,vbp=23
dtparam=backlight-gpio=19
dtparam=rotate=0

dtoverlay=gt911_btt_tft43_dip
dtparam=rotate_0
```

And please make sure you disable this line:

```
# dtoverlay=vc4-kms-v3d
```

!!! note
    
    The gpu_mem=160 is really important otherwise Grumpyscreen won't display correctly.
