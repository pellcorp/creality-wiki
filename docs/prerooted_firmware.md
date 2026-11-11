# Pre-Rooted Firmware

!!! klipper-error "Brick Alert"

    WE ARE NOT RESPONSIBLE IF YOU BRICK YOUR PRINTER - CREATING AND INSTALLING CUSTOM FIRMWARE IS RISKY


## Where do I get the firmware?

There is firmware for the K1 Series (K1, K1C, K1SE and K1 Max), Ender 3 V3 KE, Ender 5 Max, Nebula Pad and CR10SE at the moment.

Go to <https://github.com/pellcorp/downloads/tree/main/creality/prerooted>

!!! tip

    The CR4CU220812S11_ota_img prefixed images are suitable for K1, K1C, K1 Max and K1 SE prior to late 2025.

## What is included?

So all images are pre-rooted with `Creality2023` as the password.  All images now start dropbear immediately there is no reliance
on the display to start dropbear and when the display tries to start drop bear later it will harmlessly crash leaving the version
the pre-rooted firmware started, this is different to previous iterations of this firmware which relied on setting the prerooted flag
and waiting for the display, which honestly was not required this is better.

!!! note

    The firmware that enables SSH without waiting for the screen was uploaded on november 11th 2026 (AEDT)

In addition to being pre-rooted we also added a few goodies to help:

- [Configure WIFI via USB](configure_wifi.md)
- [Emergency Factory Reset via USB](emergency_factory_reset.md)
- SFTP is enabled ootb
- The /usr/bin/curl binary is fixed for SSL / TLS

## How were these built?

All the .img were build with <https://github.com/pellcorp/creality-firmware>, the .ingenic images are [manually
constructed](https://github.com/pellcorp/creality-firmware/tree/main/ingenic) by taking the prerooted and decrypted rootfs from creating the img to construct the equivalent .ingenic 
images.
