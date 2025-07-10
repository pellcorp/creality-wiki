#!/bin/sh

curl -L "https://github.com/pellcorp/guppyscreen/releases/download/main/guppyscreen.tar.gz" -o /usr/data/guppyscreen.tar.gz
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
/etc/init.d/S99guppyscreen restart
