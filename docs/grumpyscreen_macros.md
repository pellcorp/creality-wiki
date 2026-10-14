# GrumpyScreen Macros

The **Macros** tab provides one-touch buttons for Klipper G-code macros. It is available from the Console screen when Klipper is connected. Selecting a button sends its macro command and returns to the Console tab so that its response is visible.

## Add a macro

Edit the GrumpyScreen configuration file and add one section for each button:

```ini
[macro "BED_MESH_CALIBRATE"]
display_name: Bed Mesh
icon: bed
```

The value in the section header is the G-code command sent to Klipper. `display_name` is optional; when omitted, the command itself is shown. `icon` is optional and defaults to `refresh`.

For example, a macro with parameters can be added exactly as it would be entered in the Console:

```ini
[macro "G28 X Y"]
display_name: Home XY
icon: home
```

Restart GrumpyScreen after saving the configuration. Macros can also be placed in the GrumpyScreen override configuration; this is useful for machine-specific buttons.

## Icon reference

Use the value in the first column as `icon: <value>`. If an unknown value is supplied, GrumpyScreen uses the refresh icon.

| Icon value | Preview | Meaning |
| --- | --- | --- |
| `arrow_down` | ![Down arrow](assets/images/grumpyscreen-icons/arrow_down.svg) | Down arrow |
| `arrow_left` | ![Left arrow](assets/images/grumpyscreen-icons/arrow_left.svg) | Left arrow |
| `arrow_right` | ![Right arrow](assets/images/grumpyscreen-icons/arrow_right.svg) | Right arrow |
| `arrow_up` | ![Up arrow](assets/images/grumpyscreen-icons/arrow_up.svg) | Up arrow |
| `back` | ![Back](assets/images/grumpyscreen-icons/back.svg) | Back or return |
| `bed` | ![Bed](assets/images/grumpyscreen-icons/bed.svg) | Heated bed or bed mesh |
| `cancel` | ![Cancel](assets/images/grumpyscreen-icons/cancel.svg) | Cancel or stop current action |
| `clock` | ![Clock](assets/images/grumpyscreen-icons/clock_img.svg) | Time or timer |
| `cooldown` | ![Cooldown](assets/images/grumpyscreen-icons/cooldown_img.svg) | Cool down heaters |
| `delete` | ![Delete](assets/images/grumpyscreen-icons/delete_img.svg) | Delete or clear |
| `emergency` | ![Emergency](assets/images/grumpyscreen-icons/emergency.svg) | Emergency stop |
| `extrude` | ![Extrude](assets/images/grumpyscreen-icons/extrude_img.svg) | Extrude filament |
| `extruder` | ![Extruder](assets/images/grumpyscreen-icons/extruder.svg) | Extruder or hotend |
| `factory_reset` | ![Factory reset](assets/images/grumpyscreen-icons/factory_reset_img.svg) | Factory reset |
| `fan` | ![Fan](assets/images/grumpyscreen-icons/fan.svg) | Fan control |
| `fan_off` | ![Fan off](assets/images/grumpyscreen-icons/fan_off_img.svg) | Turn a fan off |
| `fan_on` | ![Fan on](assets/images/grumpyscreen-icons/fan_on.svg) | Turn a fan on |
| `fine_tune` | ![Fine tune](assets/images/grumpyscreen-icons/fine_tune_img.svg) | Fine tuning |
| `firmware` | ![Firmware](assets/images/grumpyscreen-icons/firmware_img.svg) | Firmware action |
| `flow` | ![Flow](assets/images/grumpyscreen-icons/extrude.svg) | Flow adjustment |
| `flow_up` | ![Flow up](assets/images/grumpyscreen-icons/flow_up_img.svg) | Increase flow |
| `gui` | ![GUI](assets/images/grumpyscreen-icons/gui_img.svg) | Screen or GUI action |
| `heater` | ![Heater](assets/images/grumpyscreen-icons/heater.svg) | Heater control |
| `home` | ![Home](assets/images/grumpyscreen-icons/home.svg) | Home printer axes |
| `home_z` | ![Home Z](assets/images/grumpyscreen-icons/home_z.svg) | Home Z axis |
| `hourglass` | ![Hourglass](assets/images/grumpyscreen-icons/hourglass.svg) | Waiting or in progress |
| `infinity` | ![Infinity](assets/images/grumpyscreen-icons/infinity_img.svg) | Continuous or unlimited action |
| `info` | ![Information](assets/images/grumpyscreen-icons/info_img.svg) | Information |
| `layers` | ![Layers](assets/images/grumpyscreen-icons/layers_img.svg) | Print layers |
| `light` | ![Light](assets/images/grumpyscreen-icons/light_img.svg) | Turn a light on |
| `light_off` | ![Light off](assets/images/grumpyscreen-icons/light_off.svg) | Turn a light off |
| `load_filament` | ![Load filament](assets/images/grumpyscreen-icons/load_filament_img.svg) | Load filament |
| `motor_off` | ![Motor off](assets/images/grumpyscreen-icons/motor_off_img.svg) | Disable motors |
| `move` | ![Move](assets/images/grumpyscreen-icons/move.svg) | Move printer axes |
| `pa_plus` | ![Pressure advance](assets/images/grumpyscreen-icons/pa_plus_img.svg) | Increase pressure advance |
| `pause` | ![Pause](assets/images/grumpyscreen-icons/pause_img.svg) | Pause a print |
| `print` | ![Print](assets/images/grumpyscreen-icons/print.svg) | Print action |
| `refresh` | ![Refresh](assets/images/grumpyscreen-icons/refresh_img.svg) | Refresh or rerun |
| `restart` | ![Restart](assets/images/grumpyscreen-icons/restart_img.svg) | Restart |
| `resume` | ![Resume](assets/images/grumpyscreen-icons/resume.svg) | Resume a print |
| `retract` | ![Retract](assets/images/grumpyscreen-icons/retract_img.svg) | Retract filament |
| `sd` | ![SD card](assets/images/grumpyscreen-icons/sd_img.svg) | SD card or files |
| `shutdown` | ![Shutdown](assets/images/grumpyscreen-icons/shutdown_img.svg) | Shut down host |
| `speed_up` | ![Speed up](assets/images/grumpyscreen-icons/speed_up_img.svg) | Increase speed |
| `spoolman` | ![Spoolman](assets/images/grumpyscreen-icons/spoolman_img.svg) | Spoolman or spool management |
| `support_zip` | ![Support zip](assets/images/grumpyscreen-icons/support_zip_img.svg) | Create a support archive |
| `switch_stock` | ![Switch to stock](assets/images/grumpyscreen-icons/switch_stock_img.svg) | Switch to stock firmware |
| `unload_filament` | ![Unload filament](assets/images/grumpyscreen-icons/unload_filament_img.svg) | Unload filament |
| `update` | ![Update](assets/images/grumpyscreen-icons/update_img.svg) | Update software or firmware |
| `z_closer` | ![Z closer](assets/images/grumpyscreen-icons/z_closer.svg) | Move Z closer to the bed |
| `z_farther` | ![Z farther](assets/images/grumpyscreen-icons/z_farther.svg) | Move Z farther from the bed |
