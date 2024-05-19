return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    document_color = {
      enabled = true,
      kind = "inline",
      inline_symbol = "󰝤 ",
      debounce = 200,
    },
    conceal = {
      enabled = true,
      min_length = 30,
      symbol = "󱏿", -- only a single character is allowed
      highlight = { -- extmark highlight options, see :h 'highlight'
        fg = "#38BDF8",
      },
    },
  },
}
