### Loadcells for Z-Offset

!!! note

    For K1, K1C, K1 Max, K1SE, Ender 3 V3, Ender 5 Max, Ender 3 V3 SE and Ender 3 V3 KE users you have the option to use loadcells for automating
    your z-offset during printing.

!!! tip "Migrating from Loadcells?"

    When you switch to another probe you need to specify the `--loadcells-zoffset` argument, otherwise the Simple AF installer will assume you want
    to ignore loadcells entirely with your new probe.
    
Just add `--loadcells-zoffset` to the installation or update command to enable the loadcells for z-offset.

!!! tip

    You can also run `~/pellcorp/installer.sh --loadcells-zoffset` to enable loadcells for z-offset for an existing probe, without running a full update
    of anything else, assuming you have updated the Simple AF repo first.

See [Load Cells for Z-Offset](loadcells_zoffset.md).

!!! klipper-error "Rear mounted probes always wipe on the side"

    With loadcells for z-offset and a **rear mounted probe** the wipe is always done on the front left of the build plate, a rear wipe could drive
    the probe into the frame, **there is no option to wipe at the back**.

