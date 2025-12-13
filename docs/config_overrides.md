The `pellcorp-overrides` directory stores custom cfg and conf files as well as customisations you have made to some of the core config files such as printer.cfg.  

The following core config files can have overrides saved for them: 

- printer.cfg
- sensorless.cfg
- cartotouch.cfg
- cartographer.cfg
- cartographer.conf
- btteddy.cfg
- btteddy_macro.cfg
- beacon.conf
- beacon.cfg
- eddyng.cfg
- klicky.cfg
- klicky_macro.cfg
- KAMP_Settings.cfg
- moonraker.conf
- start_end.cfg
- fan_control.cfg
- internal_macros.cfg
- useful_macros.cfg
- grumpyscreen.ini

## Restrictions

- No support is provided to edit `gcode_macro` or `homing_override` section `gcode` values in **any** config files
- You can modify `variable_` variables in gcode macros, but **not** the gcode macros themselves
- You can modify **existing** values in existing sections
- You can **only** add or delete values from **existing** sections in printer.cfg, fan_control.cfg, grumpyscreen.ini and moonraker.conf, all other files these changes will be ignored.
- You can **only** add or delete sections in printer.cfg, fan_control.cfg, moonraker.conf and grumpyscreen.ini, all other files these changes will be ignored.

!!! tip

    You should run the CONFIG_OVERRIDES macro every time you make any changes to either your own custom cfg or conf files, or make changes to any core config files.

!!! note

    The first step in both a `~/pellcorp/installer.sh --update` or `~/pellcorp/installer.sh  --reinstall` is to backup your config-overrides, so that they can be reapplied, but they will be lost if you do a factory reset.

## Git Backups for Configuration Overrides

If the pellcorp-overrides directory is a git repo, calling the CONFIG_OVERRIDES or `~/pellcorp/tools/config-overrides.sh` will generate a new git commit and push it to origin if any files are changed.

### Create repository

Create a new `pellcorp-overrides` repository on your github account:

![image](assets/images/git_backup_new_repo.png)

!!! info

    You don't actually have to call it pellcorp-overrides, you can call it whatever you want, but it should be a repository dedicated to just doing backups for this project.

!!! warning

    Set your new repository to be private unless you want to share settings with everyone else, or potentially sensitive information in the moonraker.conf, notifier.conf, etc.  Be really careful with using github keys in moonraker.conf update manager too, as these will be version controlled.   If possible put all your secrets in moonraker.secrets which is not saved to version control.

### Create a personal access token

Click [here](https://github.com/settings/tokens?type=beta) to create a fine grained personal access token.  Create a finegrained token and limit its access to just your `pellcorp-overrides` repository.   Make sure that Contents read and write access.

![image](assets/images/git_backup_contents.png)

Make sure you limit it to just the new repository you created:

![image](assets/images/git_backup_select_repo.png)

**Source:** <https://guilouz.github.io/Creality-Helper-Script-Wiki/helper-script/git-backup/>

### Create Local Repo

You will need 3 pieces of information for this process to succeed:

1. Your github username
2. Your email address
3. The github token you just created

Ssh into your k1 and run the following:

```
export GITHUB_USERNAME=myusername
export EMAIL_ADDRESS=me@somewhere.com
export GITHUB_TOKEN="The token I just created"
export GITHUB_REPO=pellcorp-overrides
export GITHUB_BRANCH=main
/usr/data/pellcorp/tools/config-overrides.sh --repo
```

!!! note

    The `GITHUB_BRANCH` is optional, if its not specified it will use `main` as the branch.

    On Simple AF for RPI you can use `~/pellcorp/tools/config-overrides.sh --repo`

If you want to setup the repository locally ignoring any local files in the `pellcorp-overrides` directory, you can use the `--clean-repo` argument, instead of the `--repo` argument, which will rebase the local changes on top of the repo.

!!! note
    
    For K1 Series (including Ender 5 Max), the pellcorp-overrides is located at /usr/data/pellcorp-overrides, but there is a soft link
    created to /root, so you scripts and the wiki will often refer to pellcorp-overrides by the shorthand of `~/pellcorp-overrides`

    The `moonraker.secrets` file is not versioned controlled.

### Troubleshooting

#### Support for password authentication was removed on August 13, 2021

![image](assets/images/git_backups_expired_token.png)

This most likely means your personal access token is misconfigured, deleted, or expired
