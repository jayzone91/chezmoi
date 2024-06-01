-- [[
-- tiny-devicons-auto-colors.nvim
-- A Neovim plugin that automatically assigns colors to
-- devicons based on their nearest color in a predefined color palette.
-- https://github.com/rachartier/tiny-devicons-auto-colors.nvim
-- ]]

return {
  "rachartier/tiny-devicons-auto-colors.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    require("tiny-devicons-auto-colors").setup({
      autoreload = true, -- Automatic Reload the colors when colorscheme changes
    })
  end,
}
