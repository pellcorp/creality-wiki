**THIS IS A RISKY OPERATION YOU COULD EASILY BRICK YOUR BTT EDDY**

It is really important that you update the firmware on your eddy before doing an installation, otherwise the serial config will be wrong.

# On Windows or Linux Desktop

Flashing the btt eddy is really easy, there is no need to have a Live USB or anything, all you need is the btteddy.uf2 file from https://github.com/pellcorp/klipper/blob/master/fw/K1/btteddy.uf2.

# On K1

TODO - it is possible to flash the eddy directly on the K1, but I have not confirmed these steps as yet, I will update the wiki once I have.

# Flashing

## Connecting in BOOTSEL mode

You need to connect your btt eddy to your computer in BOOTSEL mode, you do this by disconnecting the eddy usb **or eddy duo**, and then push and hold boot button on Eddy (It's next to where the cable plugs in) and at the same time, plug in the cable to your computer.

On windows or a Linux Desktop if you successfully connected the eddy in bootsel mode, it will be mounted as a new drive on your computer.

## Flashing btteddy.uf2 file

Copy the btteddy.uf2 file across to the btt eddy drive, it should automatically flash the eddy and disconnect for you.

Once this is done go ahead and reconnect your eddy to your K1.
