# Crowsnest (Camera Support)

Crowsnest is automatically installed for you but a single webcam is configured and points at `/dev/video0`, this
won't always end up being a valid webcam.

To find out what devices are available you can use the crowsnest tool like so:

```
~/crowsnest/tools/dev-helper.sh -c
```

![image](assets/images/crowsnest_dev_helper.png)

!!! warning

    According to the crowsnest project, its always preferable to use full paths, especially in Mutlicam setups using /dev/video* 
    will lead to errors or unexpected behaviours.
    
    Source: <https://crowsnest.mainsail.xyz/configuration/cam-section#device>

## Rpi Camera

I've not found a way to get the V1 cam working with rasbian 12, only with 11 and enable classic legacy cam support
and then it just works.
