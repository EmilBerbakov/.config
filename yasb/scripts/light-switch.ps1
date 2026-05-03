
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$sys = 'SystemUsesLightTheme'
$app = 'AppsUseLightTheme'

$sysVal = Get-ItemPropertyValue -Path $path -Name $sys
$appVal = Get-ItemPropertyValue -Path $path -Name $app

Set-ItemProperty -Path $path -Name $sys -Value $( 1-$sysVal)
Set-ItemProperty -Path $path -Name $app -Value $( 1-$appVal)

$isLightMode = 1-$sysVal -eq 1

# $wallpaper = "C:\Users\8eber\Downloads\$(($isLightMode) ? 'light-mode.jpeg' : 'dark-mode.jpeg')"
$wallpaper = Resolve-Path "~/OneDrive/Pictures/Wallpapers/$(($isLightMode) ? 'light-mode.jpg' : 'dark-mode.png')"

Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class NativeMethods {
  [DllImport("user32.dll",SetLastError=true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[NativeMethods]::SystemParametersInfo(20, 0, $wallpaper, 0x01 -bor 0x02) | Out-Null

Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class WinAPI {
  [DllImport("user32.dll",CharSet=CharSet.Auto)]
  public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
}
"@
$HWND_BROADCAST = [IntPtr]0xffff
$WM_SETTINGCHANGE = 0x001A
$SMTO_ABORTIFHUNG = 0x2
[UIntPtr]$res = [UIntPtr]::Zero
[WinAPI]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE, [UIntPtr]::Zero, "ImmersiveColorSet", $SMTO_ABORTIFHUNG, 5000, [ref]$res) | Out-Null

$AccentPalette = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette"
if ($AccentPalette) {
    $cssContent = ":root {"
    for ($i = 0; $i -lt 8; $i++) {
        $offset = $i * 4
        $r = $AccentPalette.AccentPalette[$offset]
        $g = $AccentPalette.AccentPalette[$offset + 1]
        $b = $AccentPalette.AccentPalette[$offset + 2]
        $hexColor = "#{0:X2}{1:X2}{2:X2}" -f $r, $g, $b
        $cssContent += " --color$($i): $($hexColor); "
    }
    $cssContent += "--bg: #$(($isLightMode) ? 'F3F3F3' : '202020' );"
    $cssContent += "}"
    Set-Content -Path '~/.config/yasb/vars.css' -Value $cssContent
}
