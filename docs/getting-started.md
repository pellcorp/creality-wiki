# Getting Started

SimpleAF is an open-source Klipper-based firmware for Creality K1, K1C, K1SE, K1 Max, Ender 3 V3 KE, and Ender 5 Max — and as a separate variant for Raspberry Pi / SBC users. Which install guide you follow depends on which probe you have (or plan to install).

## Pick your probe

- **[Cartographer](cartographer.md)** — Cartographer V3 / V4
- **[Beacon](beacon.md)**
- **[BTT Eddy](btteddy.md)**
- **[EddyNG](eddyng.md)** — BTT Eddy running eddy-ng firmware
- **[BLTouch](bltouch.md)** — also covers CR-Touch and 3D Touch
- **[Microprobe](microprobe.md)**
- **[Klicky](klicky.md)**

Each guide walks through firmware requirements, hardware install, software install, and calibration.

## Running on a Raspberry Pi or SBC?

For Raspberry Pi, Orange Pi, Rock Pi, and similar single-board computers, see [SimpleAF for RPi](rpi.md).

## What about the slicer settings?

OrcaSlicer is the only slicer we support!  You must verify that your start and end slicer gcode are correct before trying
to print, please refer to [Slicer Settings](slicer_settings.md)

## What an install looks like

The installation flow on a Creality printer is:

1. Verify firmware requirements for your printer
2. Flash any required probe firmware
3. Mount the probe
4. (Optional) [Factory reset](factory_reset.md) — only if you've used Guilouz's Helper Script or installed Fluidd / Mainsail from Creality directly
5. Clone the SimpleAF repo and run the installer
6. Calibrate

The basic install command (replace `<probe>` and `<Mount>` with the specific values from your probe page):

```
git config --global http.sslVerify false
git clone https://github.com/pellcorp/creality.git /usr/data/pellcorp
/usr/data/pellcorp/installer.sh --install <probe> --mount <Mount>
```

## Getting help

For support, join the [SimpleAF Discord](https://discord.gg/M5rmBQqRSG). The [FAQ](faq.md) covers common questions.
