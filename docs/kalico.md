# Kalico

We are migrating all users over to Kalico for both K1 Series and RPI Series, all new installs or reinstalls and switching
probes will now switch you over.

!!! info

     Switching a mount on an existing probe will not switch your installation over to kalico from klipper, also if you switch
     to `btteddy` you will stay on klipper, because btteddy does not properly support kalico as yet, that is coming soon.

## Kalico nov2026 changes

### Load cells (K1, K1C, K1 SE, K1 Max, Ender 3 V3, Ender 3 V3 Plus, Ender 5 Max)

Your load cells need calibrating again.

1. Open `printer.cfg` and go to the bottom.
2. Delete the `reference_tare_counts` and `counts_per_gram` lines.
3. Save and restart.
4. Run `LOAD_CELL_CALIBRATE`.

### Load cells for z-offset

Some command names changed. Only matters if you use them in your own macros.

| Old | New |
|---|---|
| `LOAD_CELL_PROBE` | `PROBE PROBE=load_cell_probe` |
| `LOAD_CELL_Z_OFFSET_APPLY_PROBE` | `Z_OFFSET_APPLY_PROBE PROBE=load_cell_probe` |
| `LOAD_CELL_QUERY_PROBE` | `QUERY_PROBE PROBE=load_cell_probe` |

### Better load cell taps

Clean the nozzle, run `LOAD_CELL_PROBE_CALIBRATE CALIBRATION=TAP_PERFORMANCE`, then `SAVE_CONFIG`.

### Input shaper

Run `SHAPER_CALIBRATE` again.

## Klipper End-Of-Life in Simple AF

By the end of October / early November 2026 the installer will refuse to update an existing installation which has klipper.  You will
be forced to switch to kalico via `--kalico` update option to get fresh updates for Simple AF.  We are going to start making use
of Kalico specific features going forward, and we will no longer be supporting switching back to klipper for any probe.

## Why?

Kalico gives us non-critical mcu and load cells, plus a bunch of other QOL features like logging configuration and sensorless homing 
without homing override (which we will migrate to after we switch over)

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
