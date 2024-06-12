-- Not really a configuration option,
-- but g:neovide only exists and is set
-- to v:true if this Neovim is in Neovide.
-- Useful for configuring things only for
-- Neovide in your Neovim Config.
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here

  -- Controls the font used in Neovide.
  vim.o.guifont = "MesloLGS Nerd Font Mono:h18"

  -- Controls spacing between lines, may also be negative
  vim.o.linespace = 0

  -- In addition to setting the font itself, this setting allows to
  -- chanfe the scale without changing the whole font definition.
  vim.g.neovide_scale_factor = 1.0

  -- You can fine tune the gamma and contrast of the text to your liking.
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5

  -- Controls the space between the window border and the actual neovim,
  -- which is filled with the background color instead.
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Background color (deprecated, currently macOS only)

  -- Helper Function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  -- Window Blur (Currently MacOs only)
  vim.g.neovide_window_blurred = true

  -- Floating blur amount
  -- controls the blur radius on the respective axis for floating windows
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  -- Show border (currently macOS only)
  vim.g.neovide_show_border = false

  -- position animation length
  vim.g.neovide_scroll_animation_length = 0

  -- When scrolling more than one screen at a time, only this many lines at the
  -- end of the scroll action will be animated. Set it to 0 to snap to the final
  -- position without any animation, or to aomething big like 9999 to always scroll
  -- the whole screen.
  vim.g.neovide_scroll_animation_far_lines = 0

  -- hiding the mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true

  -- Underline automatic scaling
  vim.g.neovide_underline_stroke_scale = 1.0

  -- theme
  -- Set the background option when Neovide starts. Possible values:
  -- light, dark, auto. On Systems that support it, auto will mirror the
  -- system theme, and will update background when the system theme changes.
  vim.g.neovide_theme = "dark"

  -- Group non-empty consecutive layers (zindex) together, so that the shadows
  -- and blurring is done for the whole group instead of each individual layer.
  -- This can get rid of some shadowing and blending artifacts.
  vim.g.experimental_layer_grouping = true

  -- Refresh Rate
  vim.g.neovide_refresh_rate = 60

  -- Idle Refresh Rate
  vim.g.neovide_refresh_rate_idle = 5

  -- No Idle
  -- Setting g:neovide_no_idle to a boolean value will force neovide to
  -- redraw all the time. This can be a quick hack if animations appear to stop
  -- too early
  vim.g.neovide_no_idle = false

  -- Conform Quit
  -- If set to true, quitting while having unsaved changes will
  -- require confirmation.
  vim.g.neovide_confirm_quit = true

  -- Fullscreen
  vim.g.neovide_fullscreen = false

  -- Remember previous window size
  vim.g.neovide_remember_previous_window_size = true

  -- macOS option key is meta
  vim.g.neovide_input_macos_option_key_is_meta = "only_right"

  -- Cursor animation (default 0.13)
  vim.g.neovide_cursor_animation_length = 0.1

  -- Animation trail size (default 0.8)
  vim.g.neovide_cursor_trail_size = 0.2

  -- Antialiasing
  vim.g.neovide_cursor_antialiasing = true

  -- Animate in insert mode
  vim.g.neovide_cursor_animate_in_insert_mode = true

  -- Animate switch to command line
  vim.g.neovide_cursor_animate_command_line = false

  -- Animate cursor blink
  vim.g.neovide_cursor_smooth_blink = true
end
