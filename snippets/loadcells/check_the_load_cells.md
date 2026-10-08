### Check the Load Cells

Make sure the bed is empty and run `LOAD_CELL_DIAGNOSTIC`, it collects samples for 10 seconds, press on the bed while it runs.

- `Saturated samples` should be 0
- `Unique values` should be a large part of the samples collected, if it is 1 there is a wiring or configuration problem
- `Sample range` should increase when you press on the bed

**Source:** <https://github.com/KalicoCrew/kalico/blob/main/docs/Load_Cell.md#diagnostics>
