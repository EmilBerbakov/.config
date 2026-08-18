local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
-- config.tab_max_width = 100

local os_type = wezterm.target_triple
local is_windows = os_type == "x86_64-pc-windows-msvc"

if is_windows then
	config.default_prog = { "pwsh", "-NoLogo" }
end

local path = (os.getenv("WEZTERM_CONFIG_DIR") or os.getenv("HOME") or os.getenv("USERPROFILE")) .. '/color'
local color_scheme = 'material-wezterm'
config.color_scheme_dirs = { path }
config.color_scheme = color_scheme
wezterm.add_to_config_reload_watch_list(path .. '/' .. color_scheme .. '.toml')
local palette

wezterm.on('window-config-reloaded', function(window)
	palette = window:effective_config().resolved_palette
	local overrides = window:get_config_overrides() or {}

	overrides.colors = {
		tab_bar = {
			background = palette.background,
			active_tab = {
				bg_color = palette.ansi[4],
				fg_color = palette.cursor_fg,
			},
		},
	}

	window:set_config_overrides(overrides)
end)


wezterm.on("update-status", function(window)
	palette = palette or window:effective_config().resolved_palette
	window:set_left_status(wezterm.format({
		{ Background = { Color = palette.foreground } },
		{ Foreground = { Color = palette.background } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = window:leader_is_active() and " LEADER " or "" }
	}))
end)

config.keys = {
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local cwd = pane:get_current_working_dir().file_path
			if not cwd then
				window:toast_notification("Error", "Couuld not get CWD for pane", nil, 3000)
				return
			end
			--NOTE: this doesn't work in wsl; looks like there's some wsl-specific stuff for WezTerm that I need to look into to make this work
			local actual_path = is_windows and string.sub(cwd, 2) or cwd
			local cmd = {
				"git",
				"-C",
				actual_path,
				"config",
				"--get",
				"remote.origin.url",
			}

			local success, stdout, _ = wezterm.run_child_process(cmd)

			if not success then
				window:toast_notification("Error", "Could not get git remote url", nil, 3000)
				return
			end

			local url = stdout:match("^%s*(.-)%s*$")
			if not url or url == "" then
				window:toast_notification("Error", "No git origin found", nil, 3000)
				return
			end

			wezterm.open_with(url)
		end),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection 'Left'
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection 'Down'
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection 'Up'
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection 'Right'
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
