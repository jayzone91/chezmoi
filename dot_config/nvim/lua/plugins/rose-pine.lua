-- [[
-- Rosé Pine for Neovim
-- Soho vibes for Neovim
-- https://github.com/rose-pine/neovim
-- ]]

return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  lazy = false,
  opts = {
    variant = "moon",
    dark_variant = "moon",
    extend_background_behind_borders = true,
    styles = {
      transparency = true,
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd([[colorscheme rose-pine]])
  end,
}
