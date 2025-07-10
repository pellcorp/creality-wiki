#!/bin/sh

#released_timestamp=$(cat /usr/data/guppyscreen/release.info | grep "TIMESTAMP=" | awk -F '=' '{print $2}')
#/usr/data/helper-script/files/fixes/curl -s https://api.github.com/repos/pellcorp/guppyscreen/releases -o /tmp/guppy-releases.json
#published_date=$(cat /tmp/guppy-releases.json | jq -r '.[0].assets[] | select(.name=="guppyscreen.tar.gz") | .updated_at' | sed 's/T/ /g' | sed 's/Z//g')
#published=$(date -d "$published_date" +%s)

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
/etc/init.d/S99guppyscreen restart
