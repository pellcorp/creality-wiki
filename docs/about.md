# What is Simple AF?

I started Simple AF after growing tired of having to pick and choose bits and pieces from the helper script or kiuah.  
I wanted a single command to set everything up for a printer, so that I could be calibrating my K1 from a factory reset in less than 20 minutes.

## History

This project originally started back in early 2024 to provide a more open klipper experience for K1 users, and the only way to do that
was by using an alternative probe like a bltouch or microprobe because the prtouch load cells implementation was completely locked down and closed source, that
situation has recently changed of course but there are still many components of Creality OS that are closed source. 

## What is Creality OS?

Creality OS is based on buildroot and is used by K1, K1C, K1SE, K1M, Ender 3 V3, Ender 3 V3 KE, Ender 5 Max and the retail Nebula Pad

Creality has never released the source for many components of their build root based Creality OS, and the web server, display server and
camera stack are very visible components which are impossible for us to modify.

Even to this day there are parts of some klipper forks used by Creality OS which are not open source, or where there are no build files
to build new firmware, we have spent a lot of time reverse engineering firmware blobs for all the printers we support.

## What Printers are supported?

So Simple AF is supported on the following printers:

- Creality K1, K1C, K1SE and K1 Max (until the late 2025 models which changed the firmware entirely)
- Ender 5 Max
- Ender 3 V3
- Ender 3 V3 KE

And now on a retail Nebula Pad with a limited set of older marlin creality printers including:

- Ender 3 V3 SE
- Ender 3 V1, V1 Pro, Neo, V2 and V2 Neo

### What about Simple AF for RPI?

We also have a variant of Simple AF for users who have upgraded their Creality Printers to use a new mainboard with a SBC like a Rpi, I created
this mostly at the behest of existing users who wanted the same basic ootb experience they had on their Creality stock hardware printers, so the
RPI variant uses the same macros and installs the same basic software with a few obvious differences including: 

- Crowsnest instead of UStreamer
- Our Klipper and Kalico forks don't precompile c_helper.so or the Klipper mcu binaries 

For RPI series the process to calibrate a printer is basically the same, the main difference is as part of the installer you choose a base
printer cfg, either one we maintain or you can provide your own, but then the installation process is the same.

!!! note

    I am well aware of kiauh and people are probably asking why not just use kiuah, my personal preference is I actually don't like kiuah at
    at all because I want to run a single command and get everything setup, I don't want to have to go searching through menus for each feature
    I want to install, and I want the entire installation to be tightly integrated and tested together.

## What Probes are supported?

It supports automatically configuring one of the following probes for one of the above printers:

- BLTouch, CRTouch (3dTouch can be supported but there is so much variability)
- BTT BIQU Microprobe
- Cartographer V3 and V4
- Beacon
- BTT BIQO USB Eddy or DUO in USB mode
- EddyNG on a BTT BIQU USB Eddy or DUO in USB mode 
- Klicky Probe

We support a variety of mount options across many of those printers and lots of documentation for how to set them up 

## What gets installed?

Running the installer sets up:

- Klipper or Kalico 
- Moonraker
- Nginx
- Fluidd and Mainsail (with a easy way to switch which is the default but both are available on different ports)
- A webcam stack
- A backup tool including integration with github to backup your customisations
- A full set of macros so you can calibrate and start printing immediately no having to hunt for anything
- The ability to switch probes without a reinstallation

## What about support?

We have a discord and a wiki with lots of information, including a FAQ

Because Simple AF is essentially the same across all printers we support, there are 1000s of people using Simple AF on various printers with various
probes but their experience can benefit new users even if they are not on the exact same platform or probe.
