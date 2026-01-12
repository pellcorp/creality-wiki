# OctoEverywhere Companion

OctoEverywhere is a 3D printing community project that enables free remote access, AI print failure detection, notifications, and more. OctoEverywhere cannot be installed onto the K1 when running the Cartographer, beacon or btt eddy, the stress placed on the system by running OctoEverywhere is too great, however the OctoEverywhere Companion running on another device on the same WIFI network as the K1 works great.

!!! danger

    You must not setup OctoEverywhere on a K1 series machine (which includes Ender 3 V3 KE, NebulaPad and Ender 5 Max) because
    it will overwhelm the processor and cause serious stability issues.

    It's probably fine to setup Octoeverywhere on the same host as Simple AF if using Simple AF for RPi series

Learn More:
[https://octoeverywhere.com/companion](https://octoeverywhere.com/companion?source=simpleaf_docs)

## How do I control OctoEverywhere?

[Installing OctoEverywhere Companion](misc.md#octoeverywhere-companion)

OctoEverywhere Companion is controlled by systemd, and each printer is a separate service, so you can see them here:

```
$ systemctl list-units octo* --all
UNIT                               LOAD   ACTIVE SUB     DESCRIPTION                 
octoeverywhere-companion-2.service loaded active running OctoEverywhere For Moonraker
octoeverywhere-companion.service   loaded active running OctoEverywhere For Moonraker
```

To check status:

```
systemctl status octoeverywhere-companion.service
```

To start it:

```    
sudo systemctl start octoeverywhere-companion.service
```

To make it start on boot:

```    
sudo systemctl enable octoeverywhere-companion.service
```

The configuration for each instance of the service is in a separate directory in your home directory, so in my case I have two of them:

```
~/.octoeverywhere-companion/
~/.octoeverywhere-companion-2/
```

And you can find a octoeverywhere.conf in each directory and you can change the IP address in that config file and restart the service:

```
sudo systemctl restart octoeverywhere-companion
```
