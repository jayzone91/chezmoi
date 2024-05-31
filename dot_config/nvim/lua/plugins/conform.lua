-- [[
-- conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
-- ]]

return {
  "stevearc/conform.nvim",
  event = "BufEnter",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      php = { "php-cs-fixer" },
      python = { "isort", "black" },
      sql = { "sql-formatter" },
      zsh = { "beatysh" },
      -- Use the "*" filetype to run formatters on all filetypes.
      ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
          async = false,
        })
      end,
    })
  end,
}
