# Simple AF Fluidd and Mainsail Themes

!!! danger

     This will wipe out any custom theme you have, to avoid this backup any ~/printer_data/config/.theme or ~/printer_data/config/.fluidd-theme before
     running the change-theme.sh command!

Make sure your local pellcorp/creality git repo is up to date first:

```
~/pellcorp/installer.sh --branch main
```

!!! note

     You do **not** need to run a `~/installer.sh --update` after the `--branch main`, we just need the repo updated.

To see the available themes:

```
~/pellcorp/tools/change-theme.sh list
```

To install a theme, for example the `chefs` theme:

```
~/pellcorp/tools/change-theme.sh chefs
```

To remove the theme and go back to the default Simple AF logo run:

```
~/pellcorp/tools/change-theme.sh stock
```

Refresh Fluidd or Mainsail after changing the theme.

## Themes

<!-- simple-af-themes -->

## Making a Theme

See [Making a Simple AF Theme](https://github.com/pellcorp/simple-af-themes/blob/main/template/README.md) if you would like to make your own theme.
