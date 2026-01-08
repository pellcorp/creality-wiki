# Configure Wifi via USB

A recently added feature allows configuring a new wifi ap via a USB Stick, you copy a `wpa_supplicant.conf` to a FAT32 formatted USB stick and plug it into the
front of your printer and power cycle the printer, the printer will notice the file, copy it over to the printer and restart wifi, by the time GrumpyScreen
appears your wifi ap should have been switched.

!!! note

     This feature is not **yet** available for Simple AF for RPi!

!!! danger

    If you leave the USB Stick in the printer with a `wpa_supplicant.conf` on it, the printer is going to be copying that file across and restarting WIFI
    every time the printer is power cycled, this is not good for the printer, so delete the wpa_supplicant.conf from the stick after the printer has switched
    the wifi AP over.

The format of the file must be precisely what the printer is looking for:

```
ctrl_interface=/var/run/wpa_supplicant
update_config=1
country=GB

network={
	ssid="THE-WIFI-SSID"
	psk="TheWifiPassword"
	priority=1
}
```

For example if your wifi ssid is `MyWifiIsCool` and your Wifi AP Password is `Ab1123AX$@&*`, your wpa_supplicant.conf file might looke like:


```
ctrl_interface=/var/run/wpa_supplicant
update_config=1
country=GB

network={
	ssid="MyWifiIsCool"
	psk="Ab1123AX$@&*"
	priority=1
}
```

!!! note

    Be sure to set your country code appropriately, the default is GB for some reason.
