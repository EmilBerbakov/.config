In order to use this config, you will need: 
1. [Matugen](https://iniox.github.io/#matugen)
2. [PowerShell 7+](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6)
3. [A Nerd Font](https://www.nerdfonts.com/font-downloads) (I'm partial to JetBrainsMono Nerd Font, myself)
4. A collection of wallpapers within a single directory

Once you have all of these, edit the following lines in the following files:

| File | Line |
| ---- | ---- |
| config.yaml | line 97 ```image_path: "path\\to\\wallpaper\\directory"``` |
| config.yaml | line 116 ```- "pwsh.exe -NoProfile -ExecutionPolicy Bypass -File 'path/to/wallpaper-switch.ps1' {image}"``` |
| wallpaper-switch.ps1 | line 10 ```matugen image $wallpaper -m $mode -c path/to/matugen/config.toml``` |

Note that you can remove the ```-c path/to/matugen/config.toml``` portion of the PowerShell script if you save the Matugen config file in the default directory.


If you do not want to use Matugen, there is an option to instead use Window's in-built accent color system.
This will require a bit more editing and playing around with things:

| File | Line |
| ----- | ---- |
| config.yaml | line 97 ```image_path: "path\\to\\wallpaper\\directory"``` |
| config.yaml | line 116 ```- "pwsh.exe -NoProfile -ExecutionPolicy Bypass -File 'path/to/accent-palette.ps1' {image}"``` |
| accent-palette.ps1 | line 40 ```Set-Content -Path 'path/to/accent-palette.css' -Value $cssContent``` |
| style.css | line 1: import accent-palette.css instead of material-palette.css |
| style.css | All lines that use css variables - replace all of the Material variables with one of the variables from accent-palette.css (they will be called color0 - color6, bg, and fg) |

Experimentation will be needed to see what looks good with the accent-palette configuration; it's been a while since I've used it.
