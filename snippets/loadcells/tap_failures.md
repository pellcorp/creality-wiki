### Tap Failures

If you see tap validation errors in the console like `TAP_PULLBACK_TOO_SHORT` or `TAP_BREAK_CONTACT_TOO_LATE` the pullback move is too short, increase `pullback_distance` in the `[load_cell_probe]` section.  The default is `0.2`, on the Ender 3 V3 setting it to `0.5` fixed frequent `TAP_PULLBACK_TOO_SHORT` failures.

```
[load_cell_probe]
pullback_distance: 0.5
```

If the errors are `TAP_BREAK_CONTACT_TOO_EARLY` it is too long.
