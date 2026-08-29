# Pre-Rooted Firmware

!!! klipper-error "Brick Alert"

    I WILL NOT BE HELD RESPONSIBLE IF YOU BRICK YOUR PRINTER - CREATING AND INSTALLING CUSTOM FIRMWARE IS RISKY

There is another project <https://github.com/pellcorp/creality-firmware> 

## Pre-rooted

The one caveat being for some printers like the Ender 3 V3 KE, pre-root is not enabled until
the initial setup steps are completed.

## Configure WIFI via USB

See the details [Configure WIFI via USB](configure_wifi.md)

## Emergency Factory Reset

Usb based activation of factory reset if the worst happens, for more details see [Emergency Factory Reset](emergency_factory_reset.md)

## Where do I get the firmware?

There is firmware for the K1 Series (K1, K1C, K1SE and K1 Max), Ender 3 V3 KE, Nebula Pad and CR10SE at the moment.

Go to <https://github.com/pellcorp/downloads/tree/main/creality/prerooted>

!!! tip

    The CR4CU220812S11_ota_img prefixed images are suitable for K1, K1C, K1 Max and K1 SE prior to late 2025.

## What is the root Password?

For all firmware its `Creality2023`

## Gotchas

For the Ender 3 V3 KE, Nebula Pad and CR10SE the ssh service is not started until after the first start screens, if you have
a dodgy Ender 3 V3 KE, sometimes you got to keep dismissing errors and clicking next until finally SSH starts, it is super
annoying to be honest.
