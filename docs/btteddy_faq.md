# Frequently Asked Questions

## How can I skip Waiting for btt eddy to be at least ...?

In the latest version of Simple AF there is a variable in the `btteddy_macro.cfg` which you can flip to False,
so from:

```
# if we should wait for eddy to be at calibration temp before homing
variable_wait_for_temp: True
```

To:

```
# if we should wait for eddy to be at calibration temp before homing
variable_wait_for_temp: False
```

!!! note

    Until recently this configuration was in the sensorless.cfg file as `variable_btteddy_wait_for_temp: True`, its been
    moved where it belongs in `btteddy_macro.cfg`!
