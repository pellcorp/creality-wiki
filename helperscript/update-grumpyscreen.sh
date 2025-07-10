#!/bin/sh

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

jq '.default_macros.cooldown="SET_HEATER_TEMPERATURE HEATER=extruder TARGET=0"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.default_macros.load_filament="_GUPPY_LOAD_MATERIAL EXTRUDER_TEMP={}"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.default_macros.unload_filament="_GUPPY_QUIT_MATERIAL EXTRUDER_TEMP={}"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.guppy_restart_cmd="/etc/init.d/S99guppyscreen restart"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

jq '.guppy_update_cmd="/usr/data/guppyscreen/update-grumpyscreen.sh"' /usr/data/guppyscreen/guppyscreen.json > /usr/data/guppyscreen.json.$$
mv /usr/data/guppyscreen.json.$$ /usr/data/guppyscreen/guppyscreen.json

/etc/init.d/S99guppyscreen restart
