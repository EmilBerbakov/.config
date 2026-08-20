if ([int]$PSVersionTable.PSVersion.Major -lt 7) {
		winget install --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
	}
$config = '%userprofile%\.config'
$wezterm = "$config\wezterm"
[System.Environment]::SetEnvironmentVariable('WEZTERM_CONFIG_DIR', "$wezterm", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('WEZTERM_CONFIG_FILE', "$wezterm\wezterm.lua", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('GLAZEWM_CONFIG_PATH', "$config\glazewm\config.yaml", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('HOME', '%userprofile%', [System.EnvironmentVariableTarget]::User)

