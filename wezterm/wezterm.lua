local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.window_close_confirmation = "NeverPrompt"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

local colorscheme

local path = (os.getenv("WEZTERM_CONFIG_DIR") or os.getenv("HOME") or os.getenv("USERPROFILE"))
	.. "\\wezterm_colorscheme"
path = path:gsub("\\\\", "/")
local file = io.open(path, "r")
if file == nil then
	file = io.open(path, "w+")
	assert(file)
	file:write("Catppuccin Mocha")
end
file = io.open(path, "r")
assert(file)
colorscheme = file:read("*a")
file:close()
config.color_scheme = colorscheme
wezterm.add_to_config_reload_watch_list(path)

-- local function theme_switch(appearance)
-- 	if appearance:find("Dark") then
-- 		return "Catppuccin Mocha"
-- 	else
-- 		return "Catppuccin Latte"
-- 	end
-- end
--
-- config.color_scheme = theme_switch(wezterm.gui.get_appearance())
-- local color_theme = wezterm.color.get_builtin_schemes()[theme_switch(wezterm.gui.get_appearance())]
local color_theme = wezterm.color.get_builtin_schemes()[colorscheme]

-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
-- 	local _, _, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)
config.tab_max_width = 100

local os_type = wezterm.target_triple

local use_fancy_titlebar = false
config.use_fancy_tab_bar = use_fancy_titlebar
config.tab_bar_at_bottom = not use_fancy_titlebar

--NOTE: This does not work

function Toggle_Fancy_Titlebar(swap)
	if swap == nil then
		swap = true
	end
	use_fancy_titlebar = swap and not use_fancy_titlebar
	if use_fancy_titlebar then
		config.window_frame = { active_titlebar_bg = color_theme.background }
		config.window_decorations = "RESIZE | INTEGRATED_BUTTONS | TITLE"
		config.integrated_title_button_style = "Windows"
		wezterm.on("format-tab-title", function(tab)
			return {
				{ Background = { Color = color_theme.background } },
				{ Text = "[" .. tab.tab_index + 1 .. "] " .. tab.active_pane.title },
			}
		end)
	else
		config.colors = {
			tab_bar = {
				background = color_theme.background,
			},
		}
	end
end

Toggle_Fancy_Titlebar(false)
wezterm.on("update-status", function(window)
	window:set_left_status(wezterm.format({
		{ Background = { Color = color_theme.foreground } },
		{ Foreground = { Color = color_theme.background } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = window:leader_is_active() and " LEADER " or "" },
	}))
end)

local function go_to_remote(window, pane)
	local cwd = pane:get_current_working_dir().path
	local info = pane:get_foreground_process_info()
	wezterm.log_info(cwd)
	-- local success, out, _ = wezterm.run_child_process({
	-- 	"cmd",
	-- 	"cd " .. wezterm.shell.quote_arg(cwd) .. "&& git remote get-url origin",
	-- })
	-- if success then
	-- 	wezterm.log_info("Opening URL: ", out)
	-- 	-- local url = out:match("^%s*(.-)%s*$")
	-- 	-- -- Convert git@ to https if needed
	-- 	-- url = url:gsub("git@([^:]+):", "https://%1/")
	-- 	wezterm.open_with(out)
	-- else
	-- 	wezterm.open_with("https://google.com")
	-- end
	return nil
end

config.keys = {
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action_callback(go_to_remote),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
	--NOTE: this isn't actually disabling the ctrl+shift+num default keystrokes...

	-- table.insert(config.keys, {
	-- 	key = tostring(i),
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action.DisableDefaultAssignment,
	-- })
end

if os_type == "x86_64-pc-windows-msvc" then
	local _, stdout, _ = wezterm.run_child_process({ "cmd.exe", "ver" })
	local _, _, build, _ = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	local is_windows_11 = tonumber(build) >= 22000
	if is_windows_11 and not use_fancy_titlebar then
		--NOTE: Can't combine this with window_decorations: https://github.com/wezterm/wezterm/issues/3598
		-- config.window_background_opacity = 0.5
		-- config.win32_system_backdrop = "Acrylic"
		config.window_decorations = "RESIZE"
		-- NOTE: I was under the impression that these settings would make it more performant, but that doesn't seem to be the case. If anything, it was much worse
		config.webgpu_power_preference = "HighPerformance"
		config.front_end = "OpenGL"
		config.prefer_egl = true
	end
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

return config
