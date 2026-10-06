## Setup Klipper Virtual Env

```
virtualenv -p python3.12 --system-site-packages $HOME/klippy-env
$HOME/klippy-env/bin/pip3 install -U pip wheel setuptools
$HOME/klippy-env/bin/pip3 install -r $HOME/klipper/scripts/klippy-requirements.txt
```

!!! note

    If you get an error `RuntimeError: failed to find interpreter for Builtin discover of python_spec='python3.12'` it means you
    are likely trying to do this on Ubuntu 26.04 and you need to [install python 3.12](#ubuntu-2604-python-312)
