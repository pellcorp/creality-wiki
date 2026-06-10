# Cartographer Flashing

!!! danger

    THIS IS A RISKY OPERATION YOU CAN BRICK YOUR CARTO

!!! warning

    You might corrupt the katapult boot loader trying to use a Linux VM or WSL to flash the carto, I strongly recommend a live USB over a VM or WSL.

This page covers the scripted Ubuntu flashing flow for Cartographer USB probes on K1, K1C, K1SE, K1 Max, Ender 3 V3 KE and Ender 5 Max.

If you want the fully manual process instead, see the unlisted manual guides for [V3](cartographer_V3_flashing.md) and [V4](cartographer_V4_flashing.md).

## Firmware targets

- V3 probes will be flashed with `CARTOGRAPHER K1 5.0.0`
- V4 probes will be flashed with `CARTOGRAPHER V4 6.0.0 Lite`

!!! warn 

    These cartographer versions versions have been extensively tested with Simple AF K1 Series, newer versions may not work as reliably.

## Scripted Ubuntu flow

There is now an automated script which does:

1. Installing Ubuntu dependencies.
2. Installing Python 3.12 if the default `python3` is newer.
3. Cloning or updating `~/klipper` and `~/cartographer_firmware`.
4. Creating or rebuilding `~/klippy-env`.
5. Flashing via Katapult or DFU.
6. Waiting for the probe to reconnect and optionally sending an anonymous usage report on opt-in.

### Downloading

```bash
curl -s -L https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/scripts/cartographer_flash.sh -O ~/cartographer_flash.sh
```

### Katapult mode

```bash
bash ~/cartographer_flash.sh
```

The script auto-detects V4 when the serial id exposes `stm32g431`. Otherwise it defaults to V3. You can still force the model with `--model`.

### DFU mode

In DFU mode you must bridge the boot pins before connecting the probe over USB.

```bash
./scripts/cartographer_flash.sh --dfu --model v3
```

!!! note

    The `--model` is required in DFU mode because the normal Cartographer serial id is not available, specify `--model v3` if you 
    have an older probe, `--model v4` if you have a new probe.

## Notes

- The script uses `sudo` for `apt`, `add-apt-repository`, bootloader entry, `dfu-util` and flashing.
- If `python3.12` is already installed, the script reuses it and skips adding the deadsnakes PPA.
- If `apt` is blocked by `unattended-upgrades`, the script retries automatically.
- If `~/klipper` or `~/cartographer_firmware` already exists with the wrong `origin` remote or local uncommitted changes, the script aborts instead of updating it.
