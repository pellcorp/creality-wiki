# Legacy SimpleAF

As of October 20th Australian Eastern Daylight time, we are desupporting Klipper and hard migrating to Kalico which has been
in the works for months.

![image](assets/images/klipper_not_supported.png)

## What if I can't switch to Kalico?

To allow existing users to update to the latest code before the switch was made, we have created a legacy branch of Simple AF
which will allow you to get updates up until the very latest before the switch was made.

```
~/pellcorp/installer.sh --branch legacy
~/pellcorp/installer.sh --update
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --branch legacy
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --branch legacy
        ```

## How do I switch to Kalico?

```
~/pellcorp/installer.sh --update --kalico
```

!!! note

    If you run the above and receive an error like:

        ```
        root@K1Max-AF34 /root [#] ~/pellcorp/installer.sh --update --kalico
        -sh: /root/pellcorp/installer.sh: not found
        ```

    It means you are on an older version of Simple AF and you should instead use the old style commands:

        ```
        /usr/data/pellcorp/k1/installer.sh --update --kalico
        ```

## Why?

See [Kalico](kalico.md)
