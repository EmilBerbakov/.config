# .config
Run setup.ps1 to set up all the environment variables needed to get this up and running.
TODO - add actually downloading the software to the setup script.

Speed up glazewm and yasb on startup by creating scheduled tasks that trigger on login.
glazewm has to be done by hand, but yasb has a cli:
```yasbc enable-autostart --task```

An easier way to do this is to first generate the yasb task, and then add GlazeWM to the trigger to resolve first
