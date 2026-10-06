### Limits on X and Y microsteps

You cannot use more than `microsteps: 64` for `[stepper_x]` and `[stepper_y]`, the MCU cannot handle high microsteps, it puts too much pressure on the mainboard and it will cause stuttering and other reliability issues including random crashes.

!!! note

    This limit generally does not apply to RPi Series Simple AF
