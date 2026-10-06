## Clone Klipper and Cartographer-Firmware

```
git clone "https://github.com/pellcorp/klipper" $HOME/klipper
git clone "https://github.com/Cartographer3D/cartographer_firmware" $HOME/cartographer_firmware
```

!!! note 

    If you already have `cartographer_firmware` cloned locally, make sure you are on latest `main` like so:
    
    ```
    cd $HOME/cartographer_firmware
    git fetch
    git switch main
    git reset --hard origin/main
    ```
