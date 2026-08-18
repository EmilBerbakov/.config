param([string]$Wallpaper)
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$sys = 'SystemUsesLightTheme'
$app = 'AppsUseLightTheme'

$sysVal = Get-ItemPropertyValue -Path $path -Name $sys
$appVal = Get-ItemPropertyValue -Path $path -Name $app

$mode = ($appVal -eq 1) ? "light" : "dark"
matugen image $wallpaper -m $mode -c path/to/matugen/config.toml
