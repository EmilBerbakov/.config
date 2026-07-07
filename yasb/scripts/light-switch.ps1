param([string]$isSystemLight)
$check = $isSystemLight -eq 1
$mode = ($check) ? "light" : "dark"
$prefer = ($check) ? "darkness" : "lightness"
$wallpaper = Get-ItemPropertyValue -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper
Write-Host $prefer
matugen image $wallpaper -m $mode -c C:/Users/8eber/.config/matugen/config.toml --prefer $prefer
