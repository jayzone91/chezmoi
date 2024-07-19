return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = { "InsertEnter" },
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",

    -- Snippets
    {
      "L3MON4D3/LuaSnip",
      build = (not vim.uv.os_uname().sysname:find("Windows") ~= nil)
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    },
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.shortmess:append("c")

    local lspkind = require("lspkind")
    lspkind.init()

    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
    })
  end,
}
