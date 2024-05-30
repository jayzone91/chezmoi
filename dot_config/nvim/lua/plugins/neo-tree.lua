-- [[
-- neo-tree.nvim
-- Neovim plugin to manage the file system and other tree like structures.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- ]]

return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  branch = "v3.x",
  dependencies = {
    -- [[
    -- plenary.nvim
    -- plenary: full; complete; entire; absolute; unqualified.
    -- All the lua functions I don't want to write twice.
    -- https://github.com/nvim-lua/plenary.nvim
    -- ]]
    "nvim-lua/plenary.nvim",
    -- [[
    -- nvim-web-devicons
    -- lua `fork` of vim-web-devicons for neovim
    -- https://github.com/nvim-tree/nvim-web-devicons
    -- ]]
    "nvim-tree/nvim-web-devicons",
    -- [[
    -- nui.nvim
    -- UI Component Library for Neovim.
    -- https://github.com/MunifTanjim/nui.nvim
    -- ]]
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
  },
  opts = {
    window = {
      position = "float",
    },
  },
}
