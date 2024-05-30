-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Disable automatic Updates because we will update wezterm with homebrew
config.check_for_updates = false

-- Stupid Wezterm Defaults...
config.send_composed_key_when_left_alt_is_pressed = true

config.exit_behavior = "CloseOnCleanExit"

-- Set Theme
config.color_scheme = "rose-pine-moon"
-- Set your Font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 18

-- Tab Bar Settings
config.hide_tab_bar_if_only_one_tab = true

-- Hide Title Bar
config.window_decorations = "NONE"

-- Transparent Background
config.window_background_opacity = 0.3
config.macos_window_background_blur = 20

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
