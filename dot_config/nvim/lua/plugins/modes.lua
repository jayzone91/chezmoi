local colors = require("rose-pine.palette")

return {
  "mvllow/modes.nvim",
  tag = "v0.2.0",
  opts = {
    colors = {
      bg = "", -- Optional bg param, defaults to Normal hl group
      copy = colors.gold,
      delete = colors.love,
      insert = colors.pine,
      visual = colors.rose,
    },

    line_opacity = 0.2,
    set_cursor = true,
    set_cursorline = true,
    set_number = true,
    ignore_filetypes = { "NeoTree", "TelescopePrompt" },
  },
}
