return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
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
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup({
        columns = { "icon" },
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["q"] = "actions.close",
          ["<ESC>"] = "actions.close",
          ["<BS>"] = "actions.parent",
        },
      })

      vim.keymap.set(
        "n",
        "<leader>o",
        "<CMD>Oil --float<CR>",
        { desc = "Open parent dir in Oil" }
      )
    end,
  },
}
