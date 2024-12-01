**I AM NOT RESPONSIBLE FOR DAMAGE TO YOUR PRINTER - INSTALLING CUSTOM FIRMWARE IS A RISK**

The **Simple AF** project is for anyone who wants to use a different probe with their K1, K1C or K1 Max and use vanilla klipper and no Creality Gcode.

This project supports the following probes:

- Cartographer
- Beacon **EXPERIMENTAL**
- BTT Eddy
- Microprobe
- BLTouch, 3dTouch, CrTouch

# Installation

There is a separate guide for each probe

- If you have a Cartographer follow the [Cartographer guide](Simple-AF-Cartographer)

- If you have a Beacon follow the [Beacon guide](Simple-AF-Beacon)

- If you have a BTT Eddy, follow the [BTT Eddy guide](Simple-AF-BTT-Eddy)

- If you have a Microprobe, follow the [Microprobe guide](Simple-AF-Microprobe)

- If you have a BLTouch, 3dTouch or CrTouch follow the [Bltouch guide](Simple-AF-Bltouch)

# The Details

The installation script will perform the following steps:

- Disable creality services
- Install Emergency Factory Reset feature
- Install Bash
- Replace Creality cam_app and old mjpg_streamer with entware mjpg_streamer
- Install Moonraker
- Install Moonraker Timelapse - no longer enabled by default
- Install Nginx
- Install Fluidd and Fluidd Config
- Install Mainsail
- Install KAMP
- Install Vanilla Klipper
- Install Guppyscreen
- Setup the probe of course
