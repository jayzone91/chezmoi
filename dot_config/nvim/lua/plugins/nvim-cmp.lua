return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  priority = 100,
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    -- Snippets
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "saadparwaiz1/cmp_luasnip",
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },

    -- Tailwind Helper
    {
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
    },
  },
  config = function() require("config.cmp") end,
}
