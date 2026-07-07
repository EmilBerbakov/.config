param([string]$Wallpaper)
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$sys = 'SystemUsesLightTheme'
$app = 'AppsUseLightTheme'

$sysVal = Get-ItemPropertyValue -Path $path -Name $sys
$appVal = Get-ItemPropertyValue -Path $path -Name $app

$mode = ($appVal -eq 1) ? "light" : "dark"
$prefer = ($mode) ? "darkness" : "lightness"

matugen image $Wallpaper -m $mode -c C:/Users/8eber/.config/matugen/config.toml --prefer $prefer
