# Backups

Every time the installer.sh is run a new backup of the existing printer_data/config directory is saved, you can get a list
of all the backups with the command

## Restoring a backup

```
~/pellcorp/tools/backups.sh --list
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/tools/backups.sh --list
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch main
        ~/pellcorp/tools/backups.sh --list
        ```

And you can revert to one of them with:

```
~/pellcorp/tools/backups.sh --restore filename
```

Where filename is one of the backups listed, so for instance:

```
root@K1Max-AF34 /root [#] ~/pellcorp/tools/backups.sh --list
backup-2025-08-29_13-36-22.tar.gz
backup-latest.tar.gz
backup-2025-08-27_11-21-15.tar.gz
backup-2025-08-22_16-06-32.tar.gz
backup-2025-08-22_16-04-02.tar.gz
backup-2025-08-22_04-56-40.tar.gz
backup-2025-08-22_04-51-21.tar.gz
```

I can restore to:

```
~/pellcorp/tools/backups.sh --restore backup-2025-08-22_04-51-21.tar.gz
```

