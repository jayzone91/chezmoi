-- [[
-- mason.nvim
-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
-- https://github.com/williamboman/mason.nvim
-- ]]

return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    -- [[
    -- mason-lspconfig.nvim
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    -- https://github.com/williamboman/mason-lspconfig.nvim
    -- ]]
    "williamboman/mason-lspconfig.nvim",

    -- [[
    -- mason-tool-installer.nvim
    -- Install and upgrade third party tools automatically
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    -- ]]
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)

    require("mason-lspconfig").setup()

    local servers = require("config.lspserver")
    local formatters = require("config.formatters")
    local linters = require("config.linters")

    local servers_to_install = vim.tbl_filter(function(key)
      return servers[key]
    end, vim.tbl_keys(servers))

    local ensure_installed = {}

    vim.list_extend(ensure_installed, servers_to_install)
    vim.list_extend(ensure_installed, formatters)
    vim.list_extend(ensure_installed, linters)

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 Seconds
      -- debounce_hours = 5, -- at least 5 hours between attempts to install/update
      integrations = {
        ["mason-lspconfig"] = true,
      },
    })
  end,
}
