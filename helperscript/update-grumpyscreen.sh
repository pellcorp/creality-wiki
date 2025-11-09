#!/bin/sh

/usr/data/helper-script/files/fixes/curl -L "https://github.com/pellcorp/grumpyscreen/releases/download/main/guppyscreen.tar.gz" -o /usr/data/guppyscreen.tar.gz
if [ $? -eq 0 ]; then
    tar xf /usr/data/guppyscreen.tar.gz -C /usr/data/ 2> /dev/null
    status=$?
    rm /usr/data/guppyscreen.tar.gz
    if [ $status -ne 0 ]; then
        echo "ERROR: GrumpyScreen could not be downloaded!"
        exit 0
    fi
else
    echo "ERROR: GrumpyScreen could not be downloaded!"
    exit 0
fi

sed -i 's/cooldown:.*/cooldown: SET_HEATER_TEMPERATURE HEATER=extruder TARGET=0/g' /usr/data/guppyscreen/grumpyscreen.cfg
sed -i 's/load_filament:.*/load_filament: _GUPPY_LOAD_MATERIAL EXTRUDER_TEMP={}/g' /usr/data/guppyscreen/grumpyscreen.cfg
sed -i 's/unload_filament:.*/unload_filament: _GUPPY_QUIT_MATERIAL EXTRUDER_TEMP={}/g' /usr/data/guppyscreen/grumpyscreen.cfg
sed -i 's/guppy_update_cmd:.*/guppy_update_cmd: /usr/data/guppyscreen/update-grumpyscreen.sh/g' /usr/data/guppyscreen/grumpyscreen.cfg

/etc/init.d/S99guppyscreen restart
