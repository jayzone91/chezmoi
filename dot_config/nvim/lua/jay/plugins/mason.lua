local linter = require("jay.config.mason").linter
local servers = require("jay.config.mason").lspserver
local formatter = require("jay.config.mason").formatter

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason").setup({})

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == table then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    local formatters_to_install = {}
    for _, value in pairs(formatter) do
      vim.list_extend(formatters_to_install, value)
    end

    local ensure_installed = {}

    vim.list_extend(ensure_installed, servers_to_install)
    vim.list_extend(ensure_installed, formatters_to_install)

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      -- debounce_hours = 5
    })
  end,
}
