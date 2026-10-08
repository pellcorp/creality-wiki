### Calibration Errors

| Error | Cause | Fix |
| --- | --- | --- |
| `Tare and Calibration readings are less than 1% different!` | The weight is too light, the reading has to change by at least 1% of the sensor range | Use more weight, on the Ender 3 V3 about 3 kg (`3000` grams) is needed and 2598 grams was not enough.  The message suggests a higher gain, but `gain` is already at its highest setting (`A-128`), so more weight is the only fix |
| `Sensor is saturated with too much load!` | The weight is too heavy | Use less weight |
| `Tare and Calibration readings are the same!` | The reading did not change | Check the weight is actually on the bed and run `LOAD_CELL_DIAGNOSTIC` to check the sensor |

The calibration is still active after one of these errors, so you can change the weight and run `CALIBRATE GRAMS=<weight in grams>` again.
