return {
  "folke/todo-comments.nvim",
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)

    vim.keymap.set(
      "n",
      "<leader>ft",
      "<cmd>TodoTelescope<CR>",
      { desc = "Telescope Todos" }
    )
    vim.keymap.set(
      "n",
      "<leader>xt",
      "<cmd>Trouble todo<CR>",
      { desc = "Trouble Todo" }
    )
  end,
}
