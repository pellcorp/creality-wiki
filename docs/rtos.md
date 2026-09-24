# Replace early boot Creality logo

Even after installing Simple AF the early boot creality logo remains, and annoyingly on the Nebula Pad its the wrong orientation, there is a way to fix that but its not without some risk.

!!! info

    For now only Ender 3 V3 KE, K1, K1C, K1SE and K1 Max are supported.

    If any Ender 5 Max or Ender 3 V3 CoreXZ users are interested in getting this working on their hardware open an issue at <https://github.com/pellcorp/creality/issues>


Make sure your SimpleAF pellcorp/creality repo is up to date, you dont actually need to update your installation, just the repo:

```
/usr/data/pellcorp/installer.sh --branch main
```


Then you can run the tool to update the boot logo:

```
/usr/data/pellcorp/k1/zero/write-rtos.sh
```

It will prompt you to confirm by pasting in WRITE-RTOS when asked

Here is what it looks like on my K1M dev box:

```
root@K1Max-C04D /root [#] /usr/data/pellcorp/k1/zero/write-rtos.sh
Model:  K1
Image:  /usr/data/pellcorp/k1/zero/zero-k1.bin (452408 bytes)
Target: /dev/mmcblk0p3 (4194304 bytes, GPT label rtos)
Backup: /usr/data/zero-k1.bin.rtos-backup.bin
Writing replaces the early boot RTOS/logo.
Type WRITE-RTOS to continue: WRITE-RTOS
Backing up current RTOS partition...
4+0 records in
4+0 records out
Writing patched K1 zero.bin...
0+1 records in
0+1 records out
Success. The RTOS partition matches the supplied K1 zero.bin.
Backup retained at: /usr/data/zero-k1.bin.rtos-backup.bin
```

!!! note

    `K1` is just saying thats the version of the zero.bin file to be written, which is the same for K1, K1C, K1SE and K1 Max!
    The early boot image is just the first frame from the later boot-display, so the balls are frozen until the boot-display starts, this is expected.
