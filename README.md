# .config
Before using these, a few environment variables need to be set:

WEZTERM_CONFIG_DIR = HOMEPATH\.config\wezterm
WEZTERM_CONFIG_FILE = <WEZTERM_CONFIG_DIR>\wezterm.lua
GLAZEWM_CONFIG_PATH = HOMEPATH\.config\glazewm\config.yaml

After that, you're most likely going to have to restart.
From there, things should just work.

Copy this to HOMEPATH

Speed up glazewm and yasb on startup by creating scheduled tasks that trigger on login.
glazewm has to be done by hand, but yasb has a cli:
```yasbc enable-autostart --task```
