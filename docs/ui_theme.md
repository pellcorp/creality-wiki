# Simple AF Theme

!!! danger

     This will wipe out any custom theme you have, to avoid this backup any ~/printer_data/config/.theme or ~/printer_data/config/.fluidd-theme before
     running the change-theme.sh command!

We have recently added this capability and you can enable the theme for fluidd and mainsail like so:

```
~/pellcorp/installer.sh --branch main
~/pellcorp/tools/change-theme.sh simpleaf
```

!!! tip

    You do not need to run `~/pellcorp/installer.sh --branch main` every time, that is just to make sure your local pellcorp/creality git repo
    copy is up to date.

To revert to stock run:

```
~/pellcorp/tools/change-theme.sh stock
```

!!! note

     You do **not** need to run a `~/installer.sh --update` after the `--branch main`, we just need the repo updated.
