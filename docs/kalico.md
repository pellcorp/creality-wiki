# Kalico

There is a medium term plan to migrate all users (K1 Series and RPI Series) over to a Simple AF Kalico fork

## Why?

Because Klipper keeps refactoring stuff and making it really hard to rebase, especially our non critical mcu feature we cherry picked
from Kalico to Klipper makes updating to later version of Klipper very difficult.

We have decided that it would just be easier to use Kalico directly and we don't have to worry about merge conflicts for Kalico features.

## Forking Kalico?

We have three different Kalico forks:

- <https://github.com/pellcorp/kalico> - K1 Series Kalico which runs on Creality OS
- <https://github.com/pellcorp/kalico-rpi> - RPI Series Kalico which runs on SBC (like a RPI)
- <https://github.com/pellcorp/k1-kalico-firmware> - This fork is for building Creality firmware which gets copied to the pellcorp/kalico fw/ directory

We have some extensions which are not upstreamed and likely might never be upstramed, we can probably use kalico plugins for much of this,
but for simplicity reasons it should be possible to switch between kalico and klipper without any loss of functionality, once a migration is
complete to Kalico this would be less of an issue and we may retire at least our kalico-rpi fork.

### K1 Series specific extensions

- Kalico requires python 3.9, and we are stuck on python 3.8, python 3.8 compatibility changes.  
- There is no gcc available on Creality OS so we pre-compile c_helper.so.
- We ship firmware in the fw/ directory of the klipper fork, which the S13mcu_update makes use of.
- Input shaping by default causes OOM so we have added a max_velocity_factor to speed up input shaping to avoid running out of ram 

### K1 and RPI extensions

- Include virtual pins into our fork
- Extended fan extension for M106 to support targeting different fans with the P argument
- Support a no_reconnect flag for non critical mcus, although this might be retired due to recent stability changes in Kalico
- Expand environment variables in gcode shell commands

## How do I switch?

On both K1 and RPI Series you can switch between kalico and klipper very easily, first of all make sure your pellcorp/creality repo is 
fully up to date, run:

```
~/pellcorp/installer.sh --branch main
```

Then to switch to Kalico, you can run:

```
~/pellcorp/installer.sh --kalico
```

!!! danger

    For K1 Series, the Ender 5 Max and Ender 3 V3 are not currently supported, if you want to use Kalico on either of these
    platforms, please raise a support issue at <https://github.com/pellcorp/creality> and I can look into generating firmware
    for these printers.

To switch back to Klipper, you can run:

```
~/pellcorp/installer.sh --klipper
```
