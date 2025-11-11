# Additional Camera

For Simple AF for RPi you can setup multiple cameras via crowsnest, K1 Series (which includes K1, K1M, K1SE, K1C, Ender 5 Max and Ender 3 V3 KE) you 
cannot run more than one camera on the printer itself, the webcam service only supports a single camera because trying to run more than one camera is 
a really bad idea on this hardware.

The solution on K1 Series for additional cameras is to setup a separate RPi or Orange Pi (or the like) on the same network as your printer and install
crowsnest. and then update /usr/data/printer_data/config/webcam.conf with that camera so that fluidd and mainsail will load it, but the printer itself will have nothing
to do with this.

Get yourself a raspberry pi or an orange pi zero and get some kind of debian distribution installed, the following instructions will assume debian.

## Install Crowsnest

We use crowsnest on Simple AF for RPi, I am sure there are different options you can try but I know crowsnest so I will document that, lets get it
installed first.

```
sudo apt-get update
sudo apt-get --yes install make
git clone https://github.com/mainsail-crew/crowsnest.git ~/crowsnest
cd crowsnest/
sudo CROWSNEST_UNATTENDED=1 CROWSNEST_ADD_CROWSNEST_MOONRAKER=0 make install
```

Lets start it so it writes its default config which we will need next:

```
sudo systemctl enable crowsnest
sudo systemctl start crowsnest
```

The config file for crowsnest will be located at `~/printer_data/config/crowsnest.conf`

The config file will look something like:

```
[crowsnest]
log_path: /home/orangepi/printer_data/logs/crowsnest.log
log_level: verbose                      # Valid Options are quiet/verbose/debug
delete_log: false                       # Deletes log on every restart, if set to true
no_proxy: false                         # If set to true, no reverse proxy is required. Only change this, if you know what you are doing.

[cam 1]
mode: ustreamer                         # ustreamer - Provides MJPG and snapshots. (All devices)
                                        # camera-streamer - Provides WebRTC, MJPG and snapshots. (only RPiOS + RPi 0/1/2/3/4)
enable_rtsp: false                      # If camera-streamer is used, this also enables usage of an RTSP server
rtsp_port: 8554                         # Set different ports for each device!
port: 8080                              # HTTP/MJPG stream/snapshot port
device: /dev/video0                     # See log for available devices
resolution: 640x480                     # <width>x<height> format
max_fps: 15                             # If hardware supports it, it will be forced, otherwise ignored/coerced.
#custom_flags:                          # You can run the stream services with custom flags.
#v4l2ctl:                               # Add v4l2-ctl parameters to setup your camera, see log for your camera capabilities.
```

You must change the `no_proxy` from `false` to `true` because otherwise the camera service is not available on the wifi or ethernet interface.

And additionally its possible you will need to change the device: `/dev/video0` to something else than the default and you can find the right device by running `~/crowsnest/tools/dev-helper.sh -c`

You can find more information at [Simple AF for RPi Camera Support(rpi.md/#crowsnest-camera-support)

After you have changed the no_proxy and potentially the device config you need to restart crowsnest with `sudo systemctl restart crowsnest`

## Enable Camera in moonraker

You can just add an additional camera to the `webcam.conf` located in the config directory which you can edit via fluidd or mainsail and then just
restart moonraker from the services menu, the additional config might look like:

```
[webcam additional]
location: rpi
enabled: True
service: mjpegstreamer
flip_horizontal: False
flip_vertical: False
rotation: 0
target_fps: 10
target_fps_idle: 5
stream_url: /webcam/?action=stream
snapshot_url: /webcam/?action=snapshot
stream_url: http://X.X.X.X:8080/?action=stream
snapshot_url: http://X.X.X.X:8080/?action=snapshot
```

Where `X.X.X.X` would be replaced with the ip address of your RPi running crowsnest!

More information about the format of webcam definitions can be found at <https://moonraker.readthedocs.io/en/latest/configuration/#webcam>
