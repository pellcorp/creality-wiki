# MCU Fan

By default Simple AF configures the main MCU fan to always be on to avoid overheating the MCU, you can instead restore it to only come on when the steppers or heaters are activated by a few tweaks to printer.cfg.

So disable this:

```    
[static_digital_output mcu_fan_always_on]
pins:PB2
```

Enable this:

```    
[controller_fan mcu]
pin: PB2
tachometer_pin: ^PC6
heater: extruder, heater_bed
stepper: stepper_x, stepper_y, stepper_z
idle_timeout: 90
```

You also have the option of making the MCU fan purely temp based, however there is a risk if the temp sensor on the MCU is a bit dodgy the fan might not startup early enough to avoid damage or weird behaviour from the MCU and other components, I strongly recommend leaving the MCU fan to always be on

But if you want to, something like this might work:

So disable this:

```
[static_digital_output mcu_fan_always_on]
pins:PB2
```

And add this config:

```    
# thanks to Habitural from discord
[temperature_fan _mcu_fan]
pin: PB2
kick_start_time: 0.8
off_below: 0.1
#max_power 1.0
sensor_type: temperature_mcu
control: pid
min_temp: 0
max_temp: 80
pid_kp: 1.0
pid_ki: 0.5
pid_kd: 2.0
min_speed: 0.1
max_speed: 0.8
target_temp: 38
```

You may need to add `ADC_TEMPERATURE` to the `[duplicate_pin_override]` section if using this last option.

Note config overrides should retain these config changes as long as you do them in the printer.cfg file.
