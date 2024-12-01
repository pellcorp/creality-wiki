# Update or Reinstall - What gets overriden

The `KAMP_Settings.cfg` is updated to enable LINE_PURGE and SMART_PARK.

The printer.cfg will be modified if new features have been added that require changes to the printer.cfg file, this would normally be existing sections being removed, because they are redefined and expanded somewhere else.  For example the `virtual_sdcard` section will be removed 
from the printer.cfg because it's already defined in the fluidd client.cfg file, but there are many other examples of this.

The printer.cfg file is backed up to /usr/data/printer_data/backups/printer-YYYYMMDD-HHMMSS.cfg whenever the installer.sh script is run.

### Configuration overridden

For `/usr/data/printer_data/`:
- moonraker.asvc

For `/usr/data/printer_data/config/`:
- moonraker.conf
- fan_control.cfg
- start_end.cfg
- useful_macros.cfg
- guppyscreen.cfg
- guppyscreen.json
- sensorless.cfg
- KAMP_Settings.cfg
- webcam.conf
- cartographer.conf
- bltouch-k1.cfg
- bltouch-k1m.cfg
- microprobe-k1.cfg
- microprobe-k1m.cfg
- cartotouch.cfg
- cartographer.cfg
- cartographer-k1.cfg
- cartographer-k1m.cfg
- cartographer_macro.cfg
- cartotouch_macro.cfg
- cartotouch_calibrate.cfg
- btteddy.cfg
- btteddy-k1.cfg
- btteddy-k1m.cfg
- btteddy_macro.cfg
- btteddy_calibrate.cfg
- quickstart.cfg

**Note:** Configuration overrides will automatically restore any customisations to **some** of these files, so generally you don't have to worry about manually reapplying customisations after running update or a reinstall.

For `/etc/init.d`:
- S13mcu_update
- S50dropbear
- S50nginx_service
- S55klipper_service
- S56moonraker_service
- S58factoryreset

These directories (and sub-directories) are entirely replaced:
- /usr/data/nginx/
- /usr/data/klipper/
- /usr/data/fluidd/
- /usr/data/mainsail/
- /usr/data/moonraker/
- /usr/data/moonraker-env/
- /usr/data/guppyscreen/
- /usr/data/cartographer-klipper/
- /usr/data/moonraker-timelapse/
- /usr/data/KAMP/

### Moonraker Database

For a reinstall the moonraker database is automatically backed up and restored.  There is currently no way to avoid this, so if you want to have a new moonraker database, just delete it before you run the reinstall.   A update will not touch the moonraker database.

For example:
```
rm -rf /usr/data/printer_data/database/
/usr/data/pellcorp/k1/installer.sh --reinstall
```
