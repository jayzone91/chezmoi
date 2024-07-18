local formatter = require("jay.config.mason").formatter

return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = formatter,
      format_on_save = {
        timout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
