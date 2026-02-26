# Switching Probes

Switching a probe is fairly straightforward, the installer will remove any leftover calibrations, bed meshes and 
axis twist calibrations for the old probe!

## Update to Latest Repo

Strongly recommended to update to latest Simple AF repo before switching, this does **not** change your installation, this just pulls the latest code from the github repo but does not change your installation.

```
~/pellcorp/installer.sh --branch main
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --branch main
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch main
        ~/pellcorp/installer.sh --update
        ```

## Switching to a new probe

So you can switch from any probe to any probe, the format of this is identical:

```
~/pellcorp/installer.sh --update TheNewProbe --mount TheMount
```

Where `TheNewProbe` is one of:

- [cartographer](cartographer.md#mount-options)
- [cartotouch](cartotouch.md#mount-options)
- [beacon](beacon.md#mount-options)
- [bltouch](bltouch.md#mount-options)
- [microprobe](microprobe.md#mount-options)
- [klicky](klicky.md#mount-options)
- [btteddy](btteddy.md#mount-options)
- [eddyng](eddyng.md#mount-options)

The `TheMount` is a specific mount as defined in the specific probe mount-options section!

!!! note

    For switching from cartotouch to cartographer if you are using the same physical mount you can specify `--mount %CURRENT%`

## Cleaning up Save Configuration from previous probe

The installer has been updated to automatically remove configuration for the old probe, in addition it will remove any bed mesh and 
axis twist configuration.
