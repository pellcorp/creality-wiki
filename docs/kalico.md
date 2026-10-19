# Kalico

We are migrating all users over to Kalico for both K1 Series and RPI Series, all new installs or reinstalls and switching
probes will now switch you over.

!!! info

     Switching a mount on an existing probe will not switch your installation over to kalico from klipper, also if you switch
     to `btteddy` you will stay on klipper, because btteddy does not support kalico as yet, that is coming in november 2026.

## Klipper End-Of-Life in Simple AF

By the end of October / early November 2026 the installer will refuse to update an existing installation which has klipper.  You will
be forced to switch to kalico via `--kalico` update option to get fresh updates for Simple AF.  We are going to start making use
of Kalico specific features going forward, and we will no longer be supporting switching back to klipper for any probe.

## Why?

Kalico gives us non-critical mcu and load cells, plus a bunch of other QOL features like logging configuration and sensorless homing 
without homing override (which we will migrate to after we switch over)

We have decided that it would just be easier to use Kalico directly and we don't have to worry about merge conflicts for Kalico features.

## Forking Kalico?

We have three different Kalico forks:

- <https://github.com/pellcorp/kalico> - K1 Series Kalico which runs on Creality OS
- <https://github.com/pellcorp/kalico-rpi> - RPI Series Kalico which runs on SBC (like a RPI)
- <https://github.com/pellcorp/k1-kalico-firmware> - This fork is for building Creality firmware which gets copied to the pellcorp/kalico fw/ directory

### K1 Series specific extensions

- Kalico requires python 3.9, and we are stuck on python 3.8, python 3.8 compatibility changes.  
- There is no gcc available on Creality OS so we pre-compile c_helper.so.
- We ship firmware in the fw/ directory of the klipper fork, which the S13mcu_update makes use of.
- Input shaping by default causes OOM so we have added a max_velocity_factor to speed up input shaping to avoid running out of ram 

### K1 and RPI extensions

- Include virtual pins into our fork
- Extended fan extension for M106 to support targeting different fans with the P argument
- Support a no_reconnect flag for non critical mcus, although this might be retired due to recent stability changes in Kalico

## How do I switch?

On both K1 and RPI Series you can switch to kalico very easily, first of all make sure your pellcorp/creality repo is
fully up to date, run:

```
~/pellcorp/installer.sh --branch main
```

Then to switch to Kalico, you can run:

```
~/pellcorp/installer.sh --kalico
```
