return {
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/ts-comments.nvim",
        opts = {
          lang = {
            python = "# %s",
          },
        },
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
      },
    },
    config = function()
      ---@diagnostic disable-next-line:missing-fields
      require("Comment").setup({})
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
}
