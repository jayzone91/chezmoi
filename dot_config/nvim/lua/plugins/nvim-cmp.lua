-- [[
-- nvim-cmp
-- A completion plugin for neovim coded in Lua.
-- https://github.com/hrsh7th/nvim-cmp
-- ]]

return {
  "hrsh7th/nvim-cmp",
  event = "BufEnter",
  dependencies = {
    -- [[
    -- lspkind.nvim
    -- vscode-like pictograms for neovim lsp completion items
    -- https://github.com/onsails/lspkind.nvim
    -- ]]
    "onsails/lspkind.nvim",
    -- [[
    -- cmp-nvim-lsp
    -- nvim-cmp source for neovim builtin LSP client
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    -- ]]
    "hrsh7th/cmp-nvim-lsp",
    -- [[
    -- cmp-path
    -- nvim-cmp source for path
    -- https://github.com/hrsh7th/cmp-path
    -- ]]
    "hrsh7th/cmp-path",
    -- [[
    -- cmp-buffer
    -- nvim-cmp source for buffer words
    -- https://github.com/hrsh7th/cmp-buffer
    -- ]]
    "hrsh7th/cmp-buffer",
    -- [[
    -- cmp-nvim-lsp-signature-help
    -- nvim-cmp source for displaying function signatures with the current parameter emphasized
    -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
    -- ]]
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- [[
    -- cmp_luasnip
    -- luasnip completion source for nvim-cmp
    -- https://github.com/saadparwaiz1/cmp_luasnip
    -- ]]
    "saadparwaiz1/cmp_luasnip",
    -- [[
    -- LuaSnip
    -- Snippet Engine for Neovim written in Lua.
    -- https://github.com/L3MON4D3/LuaSnip
    -- ]]
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = (not vim.uv.os_uname().sysname:find("Windows") ~= nil)
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    },
    -- [[
    -- friendly-snippets
    -- Set of preconfigured snippets for different languages.
    -- https://github.com/rafamadriz/friendly-snippets
    -- ]]
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("config.cmp")
  end,
}
