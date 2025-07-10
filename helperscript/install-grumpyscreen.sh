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

/usr/data/helper-script/files/fixes/curl -L "https://github.com/pellcorp/guppyscreen/releases/download/main/guppyscreen.tar.gz" -o /usr/data/guppyscreen.tar.gz
if [ $? -eq 0 ]; then
    tar xf /usr/data/guppyscreen.tar.gz -C /usr/data/ 2> /dev/null
    status=$?
    rm /usr/data/guppyscreen.tar.gz
    if [ $status -ne 0 ]; then
        echo "ERROR: Grumpyscreen could not be downloaded!"
        exit 0
    fi
else
    echo "ERROR: Grumpyscreen could not be downloaded!"
    exit 0
fi

# now lets clean out all the crap from guppyscreen
rm -rf /usr/data/printer_data/config/GuppyScreen/guppy_update.cfg
rm /usr/share/klipper/klippy/extras/guppy_config_helper.py
rm /usr/share/klipper/klippy/extras/guppy_module_loader.py
rm /usr/share/klipper/klippy/extras/tmcstatus.py

wget https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/helperscript/grumpyscreen.cfg -O - > /usr/data/printer_data/config/GuppyScreen/grumpyscreen.cfg
wget https://raw.githubusercontent.com/pellcorp/creality-wiki/refs/heads/main/helperscript/update-grumpyscreen.sh -O - > /usr/data/printer_data/config/GuppyScreen/update-grumpyscreen.sh
chmod 777 /usr/data/printer_data/config/GuppyScreen/update-grumpyscreen.sh

jq '.default_macros.cooldown="SET_HEATER_TEMPERATURE HEATER=extruder TARGET=0"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.default_macros.load_filament="_GUPPY_LOAD_MATERIAL EXTRUDER_TEMP={}"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.default_macros.unload_filament="_GUPPY_QUIT_MATERIAL EXTRUDER_TEMP={}"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.guppy_restart_cmd="/etc/init.d/S99guppyscreen restart"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.guppy_update_cmd="/usr/data/printer_data/config/GuppyScreen/update-grumpyscreen.sh"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

/etc/init.d/S99guppyscreen start
