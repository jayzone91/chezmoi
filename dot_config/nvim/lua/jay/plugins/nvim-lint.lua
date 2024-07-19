local linter = require("jay.config.mason").linter

return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = linter

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
