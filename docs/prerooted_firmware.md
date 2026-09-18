# Pre-Rooted Firmware

!!! klipper-error "Brick Alert"

    I WILL NOT BE HELD RESPONSIBLE IF YOU BRICK YOUR PRINTER - CREATING AND INSTALLING CUSTOM FIRMWARE IS RISKY


## Where do I get the firmware?

There is firmware for the K1 Series (K1, K1C, K1SE and K1 Max), Ender 3 V3 KE, Nebula Pad and CR10SE at the moment.

Go to <https://github.com/pellcorp/downloads/tree/main/creality/prerooted>

!!! tip

    The CR4CU220812S11_ota_img prefixed images are suitable for K1, K1C, K1 Max and K1 SE prior to late 2025.

## What is included?

So all images are pre-rooted with `Creality2023` as the password.  For the Ender 3 V3 KE, Nebula Pad and CR10SE images unfortunately
SSH does not get enabled until the initial setup steps are completed.  Firmware for K1 series printers seems
like ssh gets enabled much earlier soon as the display service starts.  The reason for this is that the display server is
responsible for starting dropbear, because the actual drop bear service is disabled.

In addition to being pre-rooted we also added a few goodies to help:

- [Configure WIFI via USB](configure_wifi.md)
- [Emergency Factory Reset via USB](emergency_factory_reset.md)


## What if I can't get past the setup for Ender 3 V3 KE, Nebula Pad and CR10SE?

If there is interest I can create bootstrap images which can be used to install Simple AF bypassing the 
display service and disable klipper.  They are still pre-rooted like the normal images but directly start dropbear 
and have a simple UI for wifi.

## How were these built?

All the .img and .ingenic were build with <https://github.com/pellcorp/creality-firmware>
