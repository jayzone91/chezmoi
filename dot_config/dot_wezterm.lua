-- Pull in the Wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

-- This is where you actually apply yout config

-- and finally, return the configuration to wezterm
return config
