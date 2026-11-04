# Happy Hare

Simple AF is adding full MMU support for Happy Hare, initially this support is documenting how to install Happy Hare and enable MMU panels in grumpyscreen, but we are working on docs and hooks and things to make
this support more streamlined and polished.

For more information head to <https://github.com/moggieuk/Happy-Hare>

!!! note

    For Simple AF for RPI follow the Happy Hare official installation guide instead.

## Install

The default installer needs to be executed with some different arguments

!!! danger

    You must clone to /usr/data/Happy-Hare, do NOT clone it to /root (or run git clone without the second argument), this can very easily brick your printer if /root fills up!

So first of all clone the repo:

```
git clone https://github.com/moggieuk/Happy-Hare.git /usr/data/Happy-Hare
```

Then run the installer:

```
cd /usr/data/Happy-Hare
./install.sh -k /usr/data/klipper -c /usr/data/printer_data/config -z -m /usr/data/moonraker -e
systemctl restart moonraker
systemctl restart klipper
```

## Filament runout

TODO

## Enable MMU in Grumpyscreen

To access the MMU panel in grumpyscreen you must modify the grumpyscreen.ini to enable your chosen backend:

![image](assets/images/grumpyscreen_ini_mmu.png)

Restart Grumpyscreen after making this change

!!! tip

    You can restart Grumpyscreen via the Services menu in Fluidd or Mainsail, you can also Restart GUI from Grumpyscreen

When you restart Grumpyscreen there will be a MMU icon on the left panel, it will be grayed out until klipper starts
and Grumpyscreen sees the required MMU configuration registered.

![image](assets/images/grumpyscreen_hh_mmu.png)
