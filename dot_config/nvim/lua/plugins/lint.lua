-- [[
-- nvim-lint
-- An asynchronous linter plugin for Neovim complementary
-- to the built-in Language Server Protocol support.
-- https://github.com/mfussenegger/nvim-lint
-- ]]

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "InsertLeave", "BufWritePost" },
  config = function()
    require("lint").linters_by_ft = {
      css = { "stylelint" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      json = { "jsonlint" },
      html = { "htmlhint" },
      php = { "phpcs" },
      python = { "ruff" },
      markdown = { "markdownlint" },
      sql = { "sqlfluff" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
