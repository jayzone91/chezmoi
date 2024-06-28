return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
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

    local ext = require("config.external")
    local servers = ext.lspserver
    local linters = ext.linter
    local formatters = ext.formatter
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
