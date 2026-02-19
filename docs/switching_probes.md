# Switching Probes

Switching a probe is fairly straightforward, although there is likely to be some leftover save config stuff (sections prefixed with `#*#`) you will need to remove manually.

## Update to Latest Repo

Strongly recommended to update to latest Simple AF repo before switching, this does **not** change your installation, this just pulls the latest code from the github repo but does not change your installation.

```
~/pellcorp/installer.sh --branch main
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --branch main
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch main
        ~/pellcorp/installer.sh --update
        ```

## Switching to a new probe

So you can switch from any probe to any probe, the format of this is identical:

```
~/pellcorp/installer.sh --update TheNewProbe --mount TheMount
```

Where `TheNewProbe` is one of:

- [cartographer](cartographer.md#mount-options)
- [cartotouch](cartotouch.md#mount-options)
- [beacon](beacon.md#mount-options)
- [bltouch](bltouch.md#mount-options)
- [microprobe](microprobe.md#mount-options)
- [klicky](klicky.md#mount-options)
- [btteddy](btteddy.md#mount-options)
- [eddyng](eddyng.md#mount-options)

The `TheMount` is a specific mount as defined on the specific probes mount options page

!!! note

    For switching from cartotouch to cartographer if you are using the same physical mount and can specify `--mount %CURRENT%`

## Cleaning up Save Configuration from previous probe

Due to limitations in the installer, any calibrations for the old mount are not removed from the save config section (the bit with the `#*#` prefixes)!

## Cleanup of btteddy

By way of example, the sections you will need to remove when switching **from** btteddy to any other probe are the `[probe_eddy_current btt_eddy]` and `[temperature_probe btt_eddy]`.
Below is a sample of a save config section before it's cleaned up:

```
#*# <---------------------- SAVE_CONFIG ---------------------->
#*# DO NOT EDIT THIS BLOCK OR BELOW. The contents are auto-generated.
#*#
#*# [probe_eddy_current btt_eddy]
#*# reg_drive_current = 16
#*# calibrate =
#*# 	0.050000:3229623.081,0.089844:3228656.922,0.129688:3227682.221,
#*# 	0.170313:3226695.637,0.210156:3225925.777,0.250000:3225049.143,
#*# 	0.289844:3224178.350,0.329688:3223328.887,0.370313:3222455.740,
#*# 	0.410156:3221661.219,0.450000:3220817.495,0.489844:3220013.384,
#*# 	0.529688:3219257.034,0.570313:3218493.613,0.610156:3217775.328,
#*# 	0.650000:3217020.398,0.689844:3216301.864,0.729688:3215605.615,
#*# 	0.770313:3214913.808,0.810156:3214239.239,0.850000:3213525.635,
#*# 	0.889844:3212871.102,0.929688:3212234.758,0.970313:3211590.242,
#*# 	1.010156:3211002.511,1.050000:3210349.316,1.089844:3209777.121,
#*# 	1.129688:3209175.318,1.170313:3208611.538,1.210156:3208032.647,
#*# 	1.250000:3207492.880,1.289844:3206917.046,1.329688:3206415.591,
#*# 	1.370313:3205880.562,1.410156:3205394.722,1.450000:3204864.651,
#*# 	1.489844:3204379.413,1.529688:3203897.234,1.570313:3203431.680,
#*# 	1.610156:3202978.011,1.650000:3202519.475,1.689844:3202074.561,
#*# 	1.729688:3201659.005,1.770313:3201238.720,1.810156:3200813.280,
#*# 	1.850000:3200430.722,1.889844:3199992.144,1.929688:3199611.268,
#*# 	1.970313:3199221.565,2.010156:3198835.752,2.050000:3198467.735,
#*# 	2.089844:3198101.270,2.129688:3197730.675,2.170313:3197376.618,
#*# 	2.210156:3197038.317,2.250000:3196675.894,2.289844:3196353.214,
#*# 	2.329688:3196017.205,2.370313:3195692.745,2.410156:3195402.473,
#*# 	2.450000:3195069.483,2.489844:3194769.319,2.529688:3194462.596,
#*# 	2.570313:3194164.150,2.610156:3193881.610,2.650000:3193597.617,
#*# 	2.689844:3193318.625,2.729688:3193042.973,2.770313:3192751.070,
#*# 	2.810156:3192490.459,2.850000:3192230.825,2.889844:3191958.479,
#*# 	2.929688:3191712.831,2.970313:3191462.271,3.010156:3191219.721,
#*# 	3.050000:3190981.222,3.089844:3190753.242,3.129688:3190511.100,
#*# 	3.170313:3190299.786,3.210156:3190068.619,3.250000:3189831.741,
#*# 	3.289844:3189617.482,3.329688:3189389.765,3.370313:3189197.550,
#*# 	3.410156:3188974.854,3.450000:3188748.495,3.489844:3188581.109,
#*# 	3.529688:3188367.906,3.570313:3188168.587,3.610156:3187994.694,
#*# 	3.650000:3187798.898,3.689844:3187610.875,3.729688:3187425.754,
#*# 	3.770313:3187238.814,3.810156:3187073.057,3.850000:3186889.971,
#*# 	3.889844:3186706.388,3.929688:3186549.245,3.970313:3186371.693,
#*# 	4.010156:3186206.078,4.050000:3186034.704
#*#
#*# [temperature_probe btt_eddy]
#*# calibration_temp = 31.277144
#*# drift_calibration =
#*# 	3248461.603278, -742.266053, 5.941681
#*# 	3232546.800798, -532.646128, 4.333960
#*# 	3221197.567542, -402.246316, 3.280220
#*# 	3212037.696292, -298.346640, 2.475110
#*# 	3205049.979491, -224.530808, 1.894581
#*# 	3199321.580766, -160.479829, 1.391101
#*# 	3194836.872775, -114.271960, 1.027188
#*# 	3191166.868067, -79.113531, 0.762889
#*# 	3188276.332957, -51.153179, 0.530008
#*# drift_calibration_min_temp = 40.45907253515328
#*#
#*# [heater_bed]
#*# control = pid
#*# pid_kp = 65.083
#*# pid_ki = 0.739
#*# pid_kd = 1432.639
#*#
#*# [extruder]
#*# control = pid
#*# pid_kp = 32.351
#*# pid_ki = 3.126
#*# pid_kd = 83.708
#*#
#*# [input_shaper]
#*# shaper_type_x = ei
#*# shaper_freq_x = 48.2
#*# shaper_type_y = zv
#*# shaper_freq_y = 54.8
```

And here it is after being manually cleaned up:

```
#*# <---------------------- SAVE_CONFIG ---------------------->
#*# DO NOT EDIT THIS BLOCK OR BELOW. The contents are auto-generated.
#*#
#*# [heater_bed]
#*# control = pid
#*# pid_kp = 65.083
#*# pid_ki = 0.739
#*# pid_kd = 1432.639
#*#
#*# [extruder]
#*# control = pid
#*# pid_kp = 32.351
#*# pid_ki = 3.126
#*# pid_kd = 83.708
#*#
#*# [input_shaper]
#*# shaper_type_x = ei
#*# shaper_freq_x = 48.2
#*# shaper_type_y = zv
#*# shaper_freq_y = 54.8
```

Note that there is a single blank line, blank because all its got is `#*#` between each section!
