# Klippain

Klippain is only pre-installed on corexy printers

If you do not define `[adxl345]` and `[resonance_tester]` sections in your base printer cfg, the installer will install
klippain but not add the `[include klippain.cfg]`, so if you setup adxl and resonance tester config after installation
you should also manually add the `[include klippain.cfg]` to your printer.cfg as well!

!!! warning

    If you do not have a `[resonance_tester]` section, the `TEST_RESONANCES`, `SHAPER_CALIBRATE`, `INPUT_SHAPER` and `INPUT_SHAPER_GRAPHS`
    macros will not work!
