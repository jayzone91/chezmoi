local M = {}

M.lspserver = {
  lua_ls = {
    server_capabilities = {
      semanticTokensProvider = vim.NIL,
    },
  },
  gopls = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 100,
          },
        },
      },
    },
  },
  cssls = {},
  html = {},
  intelephense = {},
  jsonls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
  tsserver = {},
}

M.linter = {
  python = { "flake8" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

M.formatter = {
  lua = { "stylua" },
  python = { "isort", "black" },
  go = { "goimports", "golines" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  html = { "prettierd" },
  yaml = { "prettierd" },
  css = { "prettierd" },
  markdown = { "prettierd" },
  tailwindcss = { "rustywind" },
}

return M
