#!/bin/sh

if [ ! -d /usr/data/helper-script/ ]; then
  echo "ERROR: Missing existing helper-script"
  exit 1
fi

# this is for installing over the top of guppyscreen installed onto a helper script printer
if [ ! -d /usr/data/guppyscreen ] || [ ! -f /etc/init.d/S99guppyscreen ]; then
  echo "ERROR: Missing existing guppyscreen"
  exit 1
fi

MODEL=$(/usr/bin/get_sn_mac.sh model)
if [ "$MODEL" = "CR-K1" ] || [ "$MODEL" = "K1C" ] || [ "$MODEL" = "K1 SE" ]; then
  model=k1
elif [ "$MODEL" = "CR-K1 Max" ]; then
  model=k1m
else
  echo "FATAL: This script is not supported for $MODEL!"
  exit 1
fi

/etc/init.d/S99guppyscreen stop > /dev/null 2>&1
killall -q guppyscreen > /dev/null 2>&1
rm /usr/data/guppyscreen/* 2> /dev/null

echo
echo "INFO: Installing grumpyscreen ..."

wget https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/helperscript/update-grumpyscreen.sh -O - > /usr/data/guppyscreen/update-grumpyscreen.sh
chmod 777 /usr/data/guppyscreen/update-grumpyscreen.sh

# remove the update macro
rm -rf /usr/data/printer_data/config/GuppyScreen/guppy_update.cfg

sed -i 's/\[calibrate_shaper_config\]//g' /usr/data/printer_data/config/GuppyScreen/guppy_cmd.cfg
sed -i 's/\[guppy_module_loader\]//g' /usr/data/printer_data/config/GuppyScreen/guppy_cmd.cfg

# remove the extras which are no longer used
rm /usr/share/klipper/klippy/extras/guppy_config_helper.py
rm /usr/share/klipper/klippy/extras/guppy_module_loader.py
rm /usr/share/klipper/klippy/extras/tmcstatus.py

wget https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/helperscript/grumpy-macros.cfg -O - > /usr/data/printer_data/config/GuppyScreen/grumpy-macros.cfg

/usr/data/guppyscreen/update-grumpyscreen.sh
