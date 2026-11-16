# Kalico nov2026

## Load cells (K1, K1C, K1 SE, K1 Max, Ender 3 V3, Ender 3 V3 Plus, Ender 5 Max)

Kalico nov2026 saves the load cell tare for each load cell instead of one combined number. The old number stops Kalico from starting on printers with 4 load cells, so it has to be removed and the load cells calibrated again.

1. Open `printer.cfg` and go to the bottom.
2. Delete the `reference_tare_counts` and `counts_per_gram` lines.
3. Save and restart.
4. Run `LOAD_CELL_CALIBRATE`.

## Load cells for z-offset

Kalico nov2026 has built in support for more than one probe, and a probe is picked with `PROBE=` instead of a renamed command. The `LOAD_CELL_` commands no longer exist. Only matters if you use them in your own macros.

| Old | New |
|---|---|
| `LOAD_CELL_PROBE` | `PROBE PROBE=load_cell_probe` |
| `LOAD_CELL_Z_OFFSET_APPLY_PROBE` | `Z_OFFSET_APPLY_PROBE PROBE=load_cell_probe` |
| `LOAD_CELL_QUERY_PROBE` | `QUERY_PROBE PROBE=load_cell_probe` |

## Better load cell taps

New in Kalico nov2026. It tunes how far the nozzle lifts after each tap, and turns on tap quality checking, which catches ooze on the nozzle.

Clean the nozzle, run `LOAD_CELL_PROBE_CALIBRATE CALIBRATION=TAP_PERFORMANCE`, then `SAVE_CONFIG`.

## Input shaper

Kalico nov2026 changes how the speed limit of the resonance test is worked out, so the test shakes harder than before. That can change the recommended input shaper.

Run `SHAPER_CALIBRATE` again.
