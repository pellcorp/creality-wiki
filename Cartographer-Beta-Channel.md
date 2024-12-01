# Switching to Beta

# CURRENTLY SWITCHING TO THE BETA CHANNEL MAY CAUSE SOFT BRICK OF YOUR PRINTER REQUIRING AN EMERGENCY FACTORY RESET.

- Step 1 - change cartographer.conf

Change the channel from `stable` to `dev`
Add or modify the `primary_branch` attribute and set it to `beta`

![image](https://github.com/user-attachments/assets/ecc374f2-5360-424d-a0b0-4221f98f236e)

- Step 2 - login to your printer and run these commands:

```
cd /usr/data/cartographer-klipper
git fetch
git switch beta
cd ~
/etc/init.d/S56moonraker_service restart
/etc/init.d/S55klipper_service restart
```

Now you are on the beta

# Switching to Stable

- Step 1 - change cartographer.conf

Change the channel from `dev` to `stable`
Add or modify the `primary_branch` attribute and set it to `master`

![image](https://github.com/user-attachments/assets/93d83c70-d992-4ef1-bb57-497684cd96db)

- Step 2 - login to your printer and run these commands:

```
cd /usr/data/cartographer-klipper
git fetch
git switch master
cd ~
/etc/init.d/S56moonraker_service restart
/etc/init.d/S55klipper_service restart
```

Now you are on the stable
