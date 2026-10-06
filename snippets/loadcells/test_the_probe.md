### Test the Probe

Run `LOAD_CELL_TEST_TAP`, then gently tap the nozzle or press on the bed 3 times, it will report each tap as it is detected.  If no tap is detected within 30 seconds it fails.

!!! note

    Load cell probes always report not triggered for `QUERY_ENDSTOPS` and `QUERY_PROBE`, use `LOAD_CELL_TEST_TAP` instead.
