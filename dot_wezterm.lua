-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Set Theme
config.color_scheme = "rose-pine-moon"
-- Set your Font
config.font = wezterm.font("MesloLGS NF")

-- and finally, return the configuration to wezterm
return config
