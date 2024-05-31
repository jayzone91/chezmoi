-- [[
-- bufferline.nvim
-- A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
-- https://github.com/akinsho/bufferline.nvim
-- ]]

return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
        numbers = "none",
        color_icons = true,
        show_close_icons = false,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
      },
    })
  end,
}
